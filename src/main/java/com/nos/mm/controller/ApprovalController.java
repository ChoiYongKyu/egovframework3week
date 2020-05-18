package com.nos.mm.controller;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.ApprovalService;
import com.nos.mm.service.CodeService;
import com.nos.mm.service.ConsultationService;
import com.nos.mm.service.DecidingOfficerService;
import com.nos.mm.service.ExpenseService;
import com.nos.mm.service.VacationService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping("/approval")
public class ApprovalController {
	/* 공통코드Service */
	@Autowired
	private CodeService codeService;

	/* 휴가Service */
	@Autowired
	private VacationService vacationService;

	/* 품의Service */
	@Autowired
	private ConsultationService consultationService;

	/* 비용처리Service */
	@Autowired
	private ExpenseService expenseService;
	
	/* 결재Service */
	@Autowired
	private ApprovalService approvalService;

	/* 결재자Service */
	@Autowired
	private DecidingOfficerService decidingOfficerService;

	@RequestMapping("/list")
	public ModelAndView list(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		ModelAndView mav = new ModelAndView("approval/list");
		NosMap approvalParam = new NosMap(param);
		approvalParam.put("sesMemNo", getSesMemNo(authentication));//회원번호

		if(approvalParam.getString("type").equals("received")) {
			mav.addObject("list", approvalService.selectReceivedList(approvalParam));
		}
		else if(approvalParam.getString("type").equals("reported")) {
			mav.addObject("list", approvalService.selectReportedList(approvalParam));
		}
		else if(approvalParam.getString("type").equals("stored")) {
			// 자기 비용처리 목록만 조회
			String grade = ((MemberVO)authentication.getPrincipal()).getMem_grade();
			System.out.println("################# grade #####################" + grade);
			if (grade.equals("8")) {
				approvalParam.put("all", "");
			}
			approvalParam.put("sesDept", ((MemberVO)authentication.getPrincipal()).getMem_dept());
			mav.addObject("list", approvalService.selectStoredList(approvalParam));
		} else {
			mav.setViewName("redirect:/approval/list?type=received");
		}

		return mav;
	}

	@RequestMapping("/{clsf}View")
	public ModelAndView vacationView(Authentication authentication, @RequestParam Map<String, Object> param, @PathVariable("clsf") String clsf) throws Exception {
		ModelAndView mav = new ModelAndView("approval/" + clsf + "View");
		NosMap approvalParam = new NosMap(param);

		if(clsf.equalsIgnoreCase("vacation")) {
			mav.addObject("vacTypeList", codeService.getResultList("VAC_TYPE"));
			mav.addObject("vacationApprovalInfo", approvalService.selectOneVacationApproval(approvalParam));
		}
		else if(clsf.equalsIgnoreCase("consultation")) {
			mav.addObject("consultationApprovalInfo", approvalService.selectOneConsultationApproval(approvalParam));
		}
		else if(clsf.equalsIgnoreCase("expense")) {
			NosMap expInfo = approvalService.selectOneExpenseApproval(approvalParam);
			mav.addObject("expenseApprovalInfo", expInfo);
			param.put("exNo", expInfo.get("exNo"));
			mav.addObject("expenseDetailList", expenseService.selectOne(param).get("exDtlList"));
			
			if(!"EX03".equals(expInfo.get("category"))) {
				mav.setViewName("approval/" + clsf + "View");
			
			// 대중교통 비용처리
			} else {
				mav.setViewName("approval/" + clsf + "View2");
			}
		}

		mav.addObject("decidingOfficerList", decidingOfficerService.selectList(approvalParam));
		mav.addObject("sesMemNo", getSesMemNo(authentication));//회원번호

		return mav;
	}

	@RequestMapping("/updateReportOfficial")
	public ModelAndView updateReportOfficial(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		NosMap approvalParam = new NosMap(param);
		approvalParam.put("sesMemNo", getSesMemNo(authentication));//수정자번호
		approvalService.updateAprvStat(approvalParam, true);
		return new ModelAndView("redirect:/" + approvalParam.getString("aprvLnkgClsf").toLowerCase() + "/list");
	}

	@RequestMapping("/updateApprovalOrRejectJson")
	public ModelAndView updateApprovalOrRejectJson(Authentication authentication, @RequestParam Map<String, Object> param) throws Exception {
		NosMap decidingOfficerParam = new NosMap(param);
		decidingOfficerParam.put("sesMemNo", getSesMemNo(authentication));//수정자번호
		int result = decidingOfficerService.update(decidingOfficerParam);

		if(result > 0) {
			System.out.println(decidingOfficerParam);
			//승인
			if(decidingOfficerParam.getString("docfStat").equals("DS02")) {
				int allCnt = decidingOfficerService.selectAllCnt(decidingOfficerParam);
				int aprvCnt = decidingOfficerService.selectAprvCnt(decidingOfficerParam);
				if(allCnt == aprvCnt) {
					decidingOfficerParam.put("aprvStat", "AS05");
					approvalService.updateAprvStat(decidingOfficerParam, false); 
				}
				else {
					NosMap info = new NosMap();
					if(decidingOfficerParam.getString("aprvLnkgClsf").equalsIgnoreCase("vacation")) {
						info = vacationService.selectOne(decidingOfficerParam);
					}
					if(decidingOfficerParam.getString("aprvLnkgClsf").equalsIgnoreCase("consultation")) {
						info = consultationService.selectOne(decidingOfficerParam);
					}
					if(decidingOfficerParam.getString("aprvLnkgClsf").equalsIgnoreCase("expense")) {
						info = new NosMap((Map<String, Object>) expenseService.selectOne(decidingOfficerParam).get("exDtl"));
					}
 
					approvalService.approvalNitification(info, "AS02");
				}
			}
			//반려
			else {
				decidingOfficerParam.put("aprvStat", "AS04");
				approvalService.updateAprvStat(decidingOfficerParam, false);
			}
		}

		return new ModelAndView("jsonResult");//자동 include로 인하여 의미없는 값설정이여서 jsonResult값을 미설정함
	}

	private String getSesMemNo(Authentication authentication) {
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		return Integer.toString(memberVO.getMem_no());
	}
}