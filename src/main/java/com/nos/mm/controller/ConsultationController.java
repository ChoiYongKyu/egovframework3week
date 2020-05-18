package com.nos.mm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.mapper.DecidingOfficerMapper;
import com.nos.mm.service.ApprovalService;
import com.nos.mm.service.CodeService;
import com.nos.mm.service.ConsultationService;
import com.nos.mm.service.FileService;
import com.nos.mm.service.MemberService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping("/consultation")
public class ConsultationController {
	/* 공통코드Service */
	@Autowired
	private CodeService codeService;

	/* 회원Service */
	@Autowired
	private MemberService memberService;
	
	/* 품의Service */
	@Autowired
	private ConsultationService consultationService;
	
	/* 결재Service */
	@Autowired
	private ApprovalService approvalService;

	/* 결재자Service */
	@Autowired
	private DecidingOfficerMapper decidingOfficerService;

	/* 파일Service */
	@Autowired
	private FileService fileService;

	@RequestMapping("/list")
	public ModelAndView list(Authentication authentication) throws Exception {
		ModelAndView mav = new ModelAndView("consultation/list");
		mav.addObject("consultationList", consultationService.selectList());
		return mav;
	}

	@RequestMapping("/register")
	public ModelAndView register(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		String sesMemNo = getSesMemNo(authentication);

		ModelAndView mav = new ModelAndView("consultation/register");
		mav.addObject("sesMemNo", sesMemNo);
		mav.addObject("memberList", memberService.memberList());

		NosMap consultationParam = new NosMap(param);

		//등록
		if(consultationParam.getString("cstnNo").equals("")) {
			MemberVO memberVO = new MemberVO();
			memberVO.setMem_no(Integer.parseInt(sesMemNo));
			mav.addObject("consultationInfo", memberService.memberInfo(memberVO));
			mav.addObject("memDeptList", codeService.getResultList("MEM_DEPT"));
			mav.addObject("mode", "insert");
			return mav;
		}
		//수정
		else {
			NosMap consultationInfo = consultationService.selectOne(consultationParam);
			if(consultationInfo != null) {
				if(consultationInfo.getString("memNo").equals(sesMemNo)) {
					String aprvStat = consultationInfo.getString("aprvStat");
					//결재상태[AS01-임시저장, AS02-상신, AS03-상신취소, AS04-반려, AS05-결재완료]
					if(aprvStat.equals("AS01") || aprvStat.equals("AS04")) {
						mav.addObject("consultationInfo", consultationInfo);
						mav.addObject("decidingOfficerList", decidingOfficerService.selectList(consultationInfo));
						mav.addObject("mode", "update");
						return mav;
					}
				}
			}
		}
		return new ModelAndView("redirect:/consultation/list");
	}

	@RequestMapping("/view")
	public ModelAndView view(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		NosMap consultationParam = new NosMap(param);
		NosMap consultationInfo = consultationService.selectOne(consultationParam);
		if(consultationInfo != null) {
			ModelAndView mav = new ModelAndView("consultation/view");
			mav.addObject("sesMemNo", getSesMemNo(authentication));
			mav.addObject("consultationInfo", consultationInfo);
			mav.addObject("decidingOfficerList", decidingOfficerService.selectList(consultationInfo));
			return mav;
		}
		else {
			return new ModelAndView("consultation/list");
		}
	}

	@RequestMapping("/insertConsultation")
	public ModelAndView insertConsultation(Authentication authentication, HttpServletRequest request, @RequestParam Map<String, Object> param, @RequestParam("cstnAttach") MultipartFile file) throws Exception {
		String sesMemNo = getSesMemNo(authentication);

		NosMap consultationParam = new NosMap(param);
		consultationParam.put("sesMemNo", sesMemNo);//처리자회원번호

		consultationService.insert(consultationParam);//품의등록

		uploadFile(consultationParam.getInt("cstnNo"), 0, file, "CONSULTATION");  //파일등록

		NosMap approvalParam = new NosMap();
		approvalParam.put("aprvLnkgClsf", "CONSULTATION");                        //결재연동구분
		approvalParam.put("aprvLnkgTblPk", consultationParam.getString("cstnNo"));//결재연동테이블PK
		approvalParam.put("sesMemNo", sesMemNo);                                  //처리자회원번호
		approvalService.insert(approvalParam);                                    //결재등록

		String[] approver = request.getParameterValues("approver");
		for(int i = 0; i < approver.length; i++) {
			NosMap decidingOfficerParam = new NosMap();
			decidingOfficerParam.put("aprvNo", approvalParam.getString("aprvNo"));//결재번호
			decidingOfficerParam.put("aprvSort", (i + 1));                        //결재순서
			decidingOfficerParam.put("memNo", approver[i]);                       //결재자회원번호
			decidingOfficerParam.put("docfStat", "DS01");                         //결재자상태[DS01-대기, DS02-승인, DS03-반려]
			decidingOfficerService.insert(decidingOfficerParam);                  //결재자등록
		}

		ModelAndView mav = new ModelAndView("redirect:/consultation/view");
		mav.addObject("cstnNo", consultationParam.getString("cstnNo"));
		return mav;
	}

	@RequestMapping("/updateConsultation")
	public ModelAndView updateConsultation(Authentication authentication, HttpServletRequest request, @RequestParam Map<String, Object> param, @RequestParam("cstnAttach") MultipartFile file) throws Exception {
		NosMap consultationParam = new NosMap(param);

		System.out.println(consultationParam);
		NosMap consultationInfo = consultationService.selectOne(consultationParam);
		System.out.println(consultationInfo);

		if(consultationInfo != null) {
			String sesMemNo = getSesMemNo(authentication);
			if(consultationInfo.getString("memNo").equals(sesMemNo)) {
				String aprvStat = consultationInfo.getString("aprvStat");
				//결재상태[AS01-임시저장, AS02-상신, AS03-상신취소, AS04-반려, AS05-결재완료]
				if(aprvStat.equals("AS01") || aprvStat.equals("AS04")) {
					consultationParam.put("sesMemNo", sesMemNo);
					consultationService.update(consultationParam);//품의수정

					uploadFile(consultationParam.getInt("cstnNo"), consultationParam.getInt("uploadNo"), file, "CONSULTATION");  //파일등록

					decidingOfficerService.delete(consultationInfo);//결재자삭제

					String[] approver = request.getParameterValues("approver");
					for(int i = 0; i < approver.length; i++) {
						NosMap decidingOfficerParam = new NosMap();
						decidingOfficerParam.put("aprvNo", consultationInfo.getString("aprvNo"));//결재번호
						decidingOfficerParam.put("aprvSort", (i + 1));                       //결재순서
						decidingOfficerParam.put("memNo", approver[i]);                      //결재자회원번호
						decidingOfficerParam.put("docfStat", "DS01");                        //결재자상태[DS01-대기, DS02-승인, DS03-반려]
						decidingOfficerService.insert(decidingOfficerParam);                 //결재자등록
					}

					ModelAndView mav = new ModelAndView("redirect:/consultation/view");
					mav.addObject("cstnNo", consultationParam.getString("cstnNo"));
					return mav;
				}
			}
		}
		
		return new ModelAndView("redirect:/consultation/list");
	}
	
	@RequestMapping("/deleteConsultation")
	public ModelAndView deleteConsultation(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/consultation/list");

		String sesMemNo = getSesMemNo(authentication);
		NosMap consultationParam = new NosMap(param);
		if(!consultationParam.getString("cstnNo").equals("")) {
			consultationParam.put("sesMemNo", sesMemNo);
			consultationService.delete(consultationParam);
			fileService.deleteFile(consultationParam.getInt("uploadNo"));
		}
		return mav;
	}

	private String getSesMemNo(Authentication authentication) {
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		return Integer.toString(memberVO.getMem_no());
	}
	
	private void uploadFile(int cstnNo, int uploadNo, MultipartFile file, String table) throws Exception {
		deleteFile(uploadNo);

		if(file.getSize() > 0) {
			List<MultipartFile> files = new ArrayList<MultipartFile>();
			files.add(file);
			fileService.uploadFile(cstnNo, files, table);
		}
	}

	private void deleteFile(int uploadNo) throws Exception {
		if(uploadNo > 0) fileService.deleteFile(uploadNo);
	}
}