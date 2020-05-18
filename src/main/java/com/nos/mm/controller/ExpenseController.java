package com.nos.mm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.ApprovalService;
import com.nos.mm.service.CodeService;
import com.nos.mm.service.DecidingOfficerService;
import com.nos.mm.service.ExpenseService;
import com.nos.mm.service.MemberService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping(value="/expense")
public class ExpenseController {

	@Autowired
	private ExpenseService expenseService;
	
	@Autowired
	private DecidingOfficerService decidingOfficerService;

	@Autowired
	private ApprovalService approvalService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private MemberService memberService;
	
	/**
	 * 비용처리 리다이렉트
	 * @param authentication
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="")
	public ModelAndView listRedirect(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		return new ModelAndView("redirect:/expense/list");
	}
	
	/**
	 * 비용처리 목록
	 * @param authentication
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		ModelAndView mav = new ModelAndView("expense/list");
		
		// 자기 비용처리 목록만 조회 
		param.put("sesMemNo", getSesMemNo(authentication));
		param.put("sesDept", ((MemberVO)authentication.getPrincipal()).getMem_dept());
		
		mav.addObject("expenseMap", expenseService.selectList(param));
		
		return mav;
	}
	
	/**
	 * 비용처리 상세보기
	 * @param authentication
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/view")
	public ModelAndView view(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		NosMap nosMap = new NosMap(param);
		NosMap info = expenseService.selectOne(nosMap);
		
		if(info.get("exDtl") != null) {
			ModelAndView mav = new ModelAndView("expense/view");
			mav.addObject("mode", "view");
			mav.addObject("sesMemNo", getSesMemNo(authentication));
			mav.addObject("info", info);
			mav.addObject("decidingOfficerList", decidingOfficerService.selectList(new NosMap((Map<String, Object>) info.get("exDtl"))));
			return mav;
		}
		else {
			return new ModelAndView("redirect:/expense/list");
		}
	}
	
	/**
	 * 비용처리 등록/수정 페이지
	 * @param authentication
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/register")
	public ModelAndView register(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		NosMap nosMap = new NosMap(param);
		nosMap.put("exNo", param.get("exNo") != null ? param.get("exNo") : 0);
		NosMap info = expenseService.selectOne(nosMap);
		
		List<Map<String, Object>> exTypeList = codeService.getResultList("EX_TYPE");
		List<Map<String, Object>> memGradeList = codeService.getResultList("MEM_GRADE");
		List<Map<String, Object>> memDeptList = codeService.getResultList("MEM_DEPT");
		List<Map<String, Object>> useExtList1 = codeService.getResultList("USE_EX01");
		List<Map<String, Object>> useExtList2 = codeService.getResultList("USE_EX02");
		List<NosMap> memberList = memberService.memberList();
		
		ModelAndView mav = new ModelAndView("expense/view");
		mav.addObject("mode", "insert");
		mav.addObject("exTypeList", exTypeList);
		mav.addObject("memGradeList", memGradeList);
		mav.addObject("memDeptList", memDeptList);
		mav.addObject("useExtList1", useExtList1);
		mav.addObject("useExtList2", useExtList2);
		mav.addObject("memberList", memberList);
		mav.addObject("sesMemNo", getSesMemNo(authentication));
		
		if(info.get("exDtl") != null) {
			mav.addObject("mode", "update");
			mav.addObject("info", info);
			mav.addObject("decidingOfficerList", decidingOfficerService.selectList(new NosMap((Map<String, Object>) info.get("exDtl"))));
		}
		
		return mav;
	}
	
	/**
	 * 비용처리 등록/수정
	 * @param authentication
	 * @param request
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/registerExpense")
	public ModelAndView registerExpense(Authentication authentication, HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		String sesMemNo = getSesMemNo(authentication);
		
		NosMap nosMap = new NosMap(param);
		nosMap.put("sesMemNo", sesMemNo);
		
		String mode = nosMap.getString("mode");
		
		// 등록
		if("insert".equals(mode)) {
			expenseService.insert(nosMap, request);
	
		// 수정
		} else {
			expenseService.update(nosMap, request);
		} 
		
		ModelAndView mav = new ModelAndView("redirect:/expense/view");
		
		// 등록, 수정시
		if(!"Y".equals(nosMap.get("delYn"))) {
			NosMap expMap = expenseService.selectOne(param);
			
			// 등록
			if(expMap.get("exDtl") == null) {
				NosMap approvalParam = new NosMap();
				approvalParam.put("aprvLnkgClsf", "EXPENSE");                       //결재연동구분
				approvalParam.put("aprvLnkgTblPk", nosMap.getString("exNo"));		//결재연동테이블PK
				approvalParam.put("sesMemNo", sesMemNo);                            //처리자회원번호
				approvalService.insert(approvalParam);                              //결재등록

				String[] approver = request.getParameterValues("approver");
				for(int i = 0; i < approver.length; i++) {
					NosMap decidingOfficerParam = new NosMap();
					decidingOfficerParam.put("aprvNo", approvalParam.getString("aprvNo"));//결재번호
					decidingOfficerParam.put("aprvSort", (i + 1));                        //결재순서
					decidingOfficerParam.put("memNo", approver[i]);                       //결재자회원번호
					decidingOfficerParam.put("docfStat", "DS01");                         //결재자상태[DS01-대기, DS02-승인, DS03-반려]
					decidingOfficerService.insert(decidingOfficerParam);                  //결재자등록
				}
			} else {
				String aprvStat = ((NosMap)expMap.get("exDtl")).getString("aprvStat");
				// 결재상태[AS01-임시저장, AS02-상신, AS03-상신취소, AS04-반려, AS05-결재완료]
				if(aprvStat.equals("AS01") || aprvStat.equals("AS04")) {
					decidingOfficerService.delete((NosMap)expMap.get("exDtl"));//결재자삭제
					
					String[] approver = request.getParameterValues("approver");
					for(int i = 0; i < approver.length; i++) {
						NosMap decidingOfficerParam = new NosMap();
						decidingOfficerParam.put("aprvNo", ((NosMap)expMap.get("exDtl")).getString("aprvNo"));//결재번호
						decidingOfficerParam.put("aprvSort", (i + 1));                        //결재순서
						decidingOfficerParam.put("memNo", approver[i]);                       //결재자회원번호
						decidingOfficerParam.put("docfStat", "DS01");                         //결재자상태[DS01-대기, DS02-승인, DS03-반려]
						decidingOfficerService.insert(decidingOfficerParam);                  //결재자등록
					}
				}
			}
			
			mav.addObject("exNo", nosMap.getString("exNo"));
			mav.addObject("sesMemNo", sesMemNo);
		} else {
			mav.setViewName("redirect:/expense/list");	
		}
		
		return mav;
	}
	
	/**
	 * 비용처리 삭제
	 * @param authentication
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	public ModelAndView delete(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/expense/list");
		String sesMemNo = getSesMemNo(authentication);
		NosMap nosMap = new NosMap(param);
		if(!nosMap.getString("exNo").equals("")) {
			nosMap.put("sesMemNo", sesMemNo); //수정자번호
			expenseService.delete(nosMap);
		}
		return mav;
	}
	
	private String getSesMemNo(Authentication authentication) {
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		return Integer.toString(memberVO.getMem_no());
	}
}
