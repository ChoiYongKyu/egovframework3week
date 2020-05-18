package com.nos.mm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nos.mm.mapper.DecidingOfficerMapper;
import com.nos.mm.service.ApprovalService;
import com.nos.mm.service.CodeService;
import com.nos.mm.service.MemberService;
import com.nos.mm.service.VacationService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping("/vacation")
public class VacationController {
	/* 공통코드Service */
	@Autowired
	private CodeService codeService;

	/* 회원Service */
	@Autowired
	private MemberService memberService;
	
	/* 휴가Service */
	@Autowired
	private VacationService vacationService;
	
	/* 결재Service */
	@Autowired
	private ApprovalService approvalService;

	/* 결재자Service */
	@Autowired
	private DecidingOfficerMapper decidingOfficerService;

	@RequestMapping("")
	public ModelAndView mainlist(){
		return new ModelAndView("redirect:/vacation/list");
	}
	
	
	@RequestMapping("/list")
	public ModelAndView list(Authentication authentication) throws Exception {
		ModelAndView mav = new ModelAndView("vacation/list");
		mav.addObject("vacationList", vacationService.selectList());
		return mav;
	}

	@RequestMapping("/register")
	public ModelAndView register(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		String sesMemNo = getSesMemNo(authentication);

		ModelAndView mav = new ModelAndView("vacation/register");
		mav.addObject("vacTypeList", codeService.getResultList("VAC_TYPE"));
		mav.addObject("memberList", memberService.memberList());
		mav.addObject("sesMemNo", sesMemNo);

		NosMap vacationParam = new NosMap(param);

		//등록
		if(vacationParam.getString("vacNo").equals("")) {
			mav.addObject("memDeptList", codeService.getResultList("MEM_DEPT"));
			mav.addObject("memGradeList", codeService.getResultList("MEM_GRADE"));
			mav.addObject("mode", "insert");
			return mav;
		}
		//수정
		else {
			NosMap vacationInfo = vacationService.selectOne(vacationParam);
			if(vacationInfo != null) {
				if(vacationInfo.getString("memNo").equals(sesMemNo)) {
					String aprvStat = vacationInfo.getString("aprvStat");
					//결재상태[AS01-임시저장, AS02-상신, AS03-상신취소, AS04-반려, AS05-결재완료]
					if(aprvStat.equals("AS01") || aprvStat.equals("AS04")) {
						mav.addObject("vacationInfo", vacationInfo);
						mav.addObject("decidingOfficerList", decidingOfficerService.selectList(vacationInfo));
						mav.addObject("mode", "update");
						return mav;
					}
				}
			}
		}
		return new ModelAndView("redirect:/vacation/list");
	}

	@RequestMapping("/view")
	public ModelAndView view(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		NosMap vacationParam = new NosMap(param);
		NosMap vacationInfo = vacationService.selectOne(vacationParam);
		if(vacationInfo != null) {
			ModelAndView mav = new ModelAndView("vacation/view");
			mav.addObject("sesMemNo", getSesMemNo(authentication));
			mav.addObject("vacationInfo", vacationInfo);
			mav.addObject("decidingOfficerList", decidingOfficerService.selectList(vacationInfo));
			return mav;
		}
		else {
			return new ModelAndView("vacation/list");
		}
	}

	@RequestMapping("/insertVacation")
	public ModelAndView insertVacation(Authentication authentication, HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		String sesMemNo = getSesMemNo(authentication);

		NosMap vacationParam = new NosMap(param);
		vacationParam.put("sesMemNo", sesMemNo);//처리자회원번호
		vacationService.insert(vacationParam);  //휴가등록

		NosMap approvalParam = new NosMap();
		approvalParam.put("aprvLnkgClsf", "VACATION");                       //결재연동구분
		approvalParam.put("aprvLnkgTblPk", vacationParam.getString("vacNo"));//결재연동테이블PK
		approvalParam.put("sesMemNo", sesMemNo);                             //처리자회원번호
		approvalService.insert(approvalParam);                               //결재등록

		String[] approver = request.getParameterValues("approver");
		for(int i = 0; i < approver.length; i++) {
			NosMap decidingOfficerParam = new NosMap();
			decidingOfficerParam.put("aprvNo", approvalParam.getString("aprvNo"));//결재번호
			decidingOfficerParam.put("aprvSort", (i + 1));                        //결재순서
			decidingOfficerParam.put("memNo", approver[i]);                       //결재자회원번호
			decidingOfficerParam.put("docfStat", "DS01");                         //결재자상태[DS01-대기, DS02-승인, DS03-반려]
			decidingOfficerService.insert(decidingOfficerParam);                  //결재자등록
		}

		ModelAndView mav = new ModelAndView("redirect:/vacation/view");
		mav.addObject("vacNo", vacationParam.getString("vacNo"));
		return mav;
	}
	
	@RequestMapping("/updateVacation")
	public ModelAndView updateVacation(Authentication authentication, HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		NosMap vacationParam = new NosMap(param);
		NosMap vacationInfo = vacationService.selectOne(vacationParam);
		if(vacationInfo != null) {
			String sesMemNo = getSesMemNo(authentication);
			if(vacationInfo.getString("memNo").equals(sesMemNo)) {
				String aprvStat = vacationInfo.getString("aprvStat");
				//결재상태[AS01-임시저장, AS02-상신, AS03-상신취소, AS04-반려, AS05-결재완료]
				if(aprvStat.equals("AS01") || aprvStat.equals("AS04")) {
					vacationParam.put("sesMemNo", sesMemNo); //수정자번호
					vacationService.update(vacationParam);//휴가수정

					decidingOfficerService.delete(vacationInfo);//결재자삭제

					String[] approver = request.getParameterValues("approver");
					for(int i = 0; i < approver.length; i++) {
						NosMap decidingOfficerParam = new NosMap();
						decidingOfficerParam.put("aprvNo", vacationInfo.getString("aprvNo"));//결재번호
						decidingOfficerParam.put("aprvSort", (i + 1));                       //결재순서
						decidingOfficerParam.put("memNo", approver[i]);                      //결재자회원번호
						decidingOfficerParam.put("docfStat", "DS01");                        //결재자상태[DS01-대기, DS02-승인, DS03-반려]
						decidingOfficerService.insert(decidingOfficerParam);                 //결재자등록
					}

					ModelAndView mav = new ModelAndView("redirect:/vacation/view");
					mav.addObject("vacNo", vacationParam.getString("vacNo"));
					return mav;
				}
			}
		}
		
		return new ModelAndView("redirect:/vacation/list");
	}
	
	@RequestMapping("/deleteVacation")
	public ModelAndView deleteVacation(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/vacation/list");

		String sesMemNo = getSesMemNo(authentication);
		NosMap vacationParam = new NosMap(param);
		if(!vacationParam.getString("vacNo").equals("")) {
			vacationParam.put("sesMemNo", sesMemNo); //수정자번호
			vacationService.delete(vacationParam);
		}
		return mav;
	}
	
	private String getSesMemNo(Authentication authentication) {
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		return Integer.toString(memberVO.getMem_no());
	}
	
	
	/* 캘린더 */
	@RequestMapping("/vac_calendar") // 캘린더 페이지 이동
	public ModelAndView calendar(@RequestParam Map<String, Object> map) throws Exception {
		ModelAndView mav = new ModelAndView("vacation/vac_calendar");

		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/calendarData") // 캘린더 페이지 이동
	public String calendarData(@RequestParam Map<String, Object> map) throws Exception {
		
		List<NosMap> list = vacationService.allListForCalendar();
		
		ObjectMapper objmap = new ObjectMapper();
		String result = objmap.writeValueAsString(list);
		
		
		return result;
	}
	
	
	
	
}