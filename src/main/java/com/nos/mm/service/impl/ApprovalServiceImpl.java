package com.nos.mm.service.impl;

import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.ApprovalMapper;
import com.nos.mm.service.ApprovalService;
import com.nos.mm.service.ConsultationService;
import com.nos.mm.service.DecidingOfficerService;
import com.nos.mm.service.ExpenseService;
import com.nos.mm.service.MemberService;
import com.nos.mm.service.VacationService;
import com.nos.mm.util.FCMsender;
import com.nos.mm.util.NosMap;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	
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
	private ApprovalMapper approvalMapper;

	/* 결재자Service */
	@Autowired
	private DecidingOfficerService decidingOfficerService;
	
	@Autowired
	private MemberService memberService;

	/* 메일Service */
	@Autowired
    protected JavaMailSender javaMailSender;
	
	private final String VACATION = "VACATION";
	private final String CONSULTATION = "CONSULTATION";
	private final String EXPENSE = "EXPENSE";

	/** 결재등록
	 * @param param
	 * @throws Exception
	 */
	@Override
	public int insert(NosMap param) throws Exception {
		int aprvTn = approvalMapper.selectAprvTn(param) + 1;
		param.put("aprvTn", aprvTn);
		param.put("aprvStat", (aprvTn == 1)?"AS01":"AS02");
		return approvalMapper.insert(param);
	}

	/** 결재수신목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<NosMap> selectReceivedList(NosMap param) throws Exception {
		return approvalMapper.selectReceivedList(param);
	}
	
	/** 결재상신목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<NosMap> selectReportedList(NosMap param) throws Exception {
		return approvalMapper.selectReportedList(param);
	}
	
	/** 결재보관목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<NosMap> selectStoredList(NosMap param) throws Exception {
		return approvalMapper.selectStoredList(param);
	}
	
	/** 휴가결재정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public NosMap selectOneVacationApproval(NosMap param) throws Exception {
		return approvalMapper.selectOneVacationApproval(param);
	}

	/** 품의결재정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public NosMap selectOneConsultationApproval(NosMap param) throws Exception {
		return approvalMapper.selectOneConsultationApproval(param);
	}
	
	/** 비용처리결재정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public NosMap selectOneExpenseApproval(NosMap param) throws Exception {
		return approvalMapper.selectOneExpenseApproval(param);
	}

	/** 결재상태변경
	 * @param param
	 * @param isPersonCheck
	 * @return
	 * @throws Exception
	 */
	@Override
	public int updateAprvStat(NosMap param, boolean isPersonCheck) throws Exception {
		int result = -1;
		NosMap info = null;
		String aprvLnkgClsf = param.getString("aprvLnkgClsf");
		String aprvLnkgTblPk = "";
		//String aprvLnKgTblPk = param.getString(aprvLnkgClsf);
		if(aprvLnkgClsf.equalsIgnoreCase(VACATION)) {
			info = vacationService.selectOne(param);
			aprvLnkgTblPk = info.getString("vacNo");
		}
		else if(aprvLnkgClsf.equalsIgnoreCase(CONSULTATION)) {
			info = consultationService.selectOne(param);
			aprvLnkgTblPk = info.getString("cstnNo");
		} else if(aprvLnkgClsf.equalsIgnoreCase(EXPENSE)) {
			info = new NosMap((Map<String, Object>) expenseService.selectOne(param).get("exDtl"));
			aprvLnkgTblPk = info.getString("cstnNo");
		}

		if(info != null) {
			if(!isPersonCheck || info.getString("memNo").equals(param.getString("sesMemNo"))) {
				String beforeAprvStat = info.getString("aprvStat");
				String afterAprvStat = param.getString("aprvStat");

				if(isValidCodeCheck(beforeAprvStat, afterAprvStat)) {
					//재상신
					if(beforeAprvStat.equals("AS04") && afterAprvStat.equals("AS02")) {
						NosMap approvalParam = new NosMap();
						approvalParam.put("aprvLnkgClsf", aprvLnkgClsf);           //결재연동구분
						// approvalParam.put("aprvLnkgTblPk", aprvLnkgTblPk);         //결재연동테이블PK
						approvalParam.put("aprvLnkgTblPk", info.get("exNo"));         //결재연동테이블PK
						approvalParam.put("sesMemNo", param.getString("sesMemNo"));//처리자회원번호
						result = this.insert(approvalParam);                       //결재등록

						if(result > 0) {
							NosMap decidingOfficerParam = new NosMap();
							decidingOfficerParam.put("aprvNoNew", approvalParam.getString("aprvNo"));
							decidingOfficerParam.put("aprvNoOld", info.getString("aprvNo"));
							if(decidingOfficerService.insertCopy(decidingOfficerParam) > 0) {//결재자 등록
								approvalNitification(info, afterAprvStat);
							}
						}
					}
					else {
						param.put("aprvNo", info.getString("aprvNo"));
						result = approvalMapper.updateAprvStat(param);
						if(result > 0) {
							approvalNitification(info, afterAprvStat);
						}
					}
				}
			}
		}
		return result;
	}

	@Override
	public void approvalNitification(NosMap nosMap, String aprvStat) throws Exception {
		if(nosMap != null) {
			final String receivedUrl = "http://nat.nineonesoft.com:7070/nos.mm/approval/list?type=received";
			final String reportedUrl = "http://nat.nineonesoft.com:7070/nos.mm/approval/list?type=reported";
			final String storedUrl = "http://nat.nineonesoft.com:7070/nos.mm/approval/list?type=stored";
			final String aprvNo = nosMap.getString("aprvNo");
			String aprvLnkgClsf = nosMap.getString("aprvLnkgClsf");
			String email = nosMap.getString("memId");
			String[] emails;
			String title;
			String text;
			String FCMSender_title;
	    	String FCMSender_message;
	    	String FCMSender_link;
	    	String FCMSender_target;

			if(aprvLnkgClsf.equalsIgnoreCase(VACATION)) aprvLnkgClsf = "휴가신청서";
			else if(aprvLnkgClsf.equalsIgnoreCase(CONSULTATION)) aprvLnkgClsf = "품의신청서";
			else if(aprvLnkgClsf.equalsIgnoreCase(EXPENSE)) aprvLnkgClsf = "비용처리명세서";

			/** AS02-상신 */
			if(aprvStat.equals("AS02")) {
				//현재 결재자에게 메일 발송
				email = decidingOfficerService.selectOneNowDecidingOfficerId(aprvNo);
				System.out.println(nosMap);
				title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf + " 결재가 상신되었습니다.";
				text = title + "\n\n" + receivedUrl;
				sendEmail(title, text, email);
				
				FCMSender_target = email;
				FCMSender_message = title;
	    		FCMSender_title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf;
	    		FCMSender_link = receivedUrl;
	    		if( memberService.getToken(FCMSender_target) != null ) {
	    			FCMsender.SendFcm_Individual(FCMSender_title, FCMSender_message, memberService.getToken(FCMSender_target), FCMSender_link);
	    		}
			}
			/** AS03-상신취소, AS04-반려 */
			// 상신취소시 메일 발송 안함 (수정 19.07.02)
			else if(aprvStat.equals("AS04")) {
				//결재승인 한 결재자들에게 메일발송
				emails = decidingOfficerService.selectListDecidingOfficerId(aprvNo);
				
				title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf + " 결재가 반려되었습니다.";
				text = title + "\n\n" + storedUrl;
				
				sendEmail(title, text, emails);

				FCMSender_target = email;
				FCMSender_message = title;
				FCMSender_title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf;
				FCMSender_link = storedUrl;
				if( memberService.getToken(FCMSender_target) != null ) {
					FCMsender.SendFcm_Individual(FCMSender_title, FCMSender_message, memberService.getToken(FCMSender_target), FCMSender_link);
				}
			}
			/** AS05-결재완료 */
			if(aprvStat.equals("AS05")) {
				//결재승인 한 결재자들에게 메일발송(최종결제자 제외)
				emails = decidingOfficerService.selectListDecidingOfficerIdLastException(aprvNo);
				title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf + " 결재가 완료되었습니다.";
				text = title + "\n\n" + storedUrl;
				sendEmail(title, text, emails);
				
				FCMSender_target = email;
				FCMSender_message = title;
	    		FCMSender_title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf;
	    		FCMSender_link = storedUrl;
	    		if( memberService.getToken(FCMSender_target) != null ) {
	    			FCMsender.SendFcm_Individual(FCMSender_title, FCMSender_message, memberService.getToken(FCMSender_target), FCMSender_link);
	    		}
	    		
				//결재상신자에게 메일발송
				text = title + "\n\n" + reportedUrl;
				sendEmail(title, text, email);
				sendEmail(title, text, "jhpark@nineonesoft.com");
				
				FCMSender_target = email;
				FCMSender_message = title;
	    		FCMSender_title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf;
	    		FCMSender_link = reportedUrl;
	    		if( memberService.getToken(FCMSender_target) != null ) {
	    			FCMsender.SendFcm_Individual(FCMSender_title, FCMSender_message, memberService.getToken(FCMSender_target), FCMSender_link);
	    		}
	    		
	    		FCMSender_target = "jhpark@nineonesoft.com";
				FCMSender_message = title;
	    		FCMSender_title = "[ " + nosMap.getString("memName") + " ] " + aprvLnkgClsf;
	    		FCMSender_link = reportedUrl;
	    		if( memberService.getToken(FCMSender_target) != null ) {
	    			FCMsender.SendFcm_Individual(FCMSender_title, FCMSender_message, memberService.getToken(FCMSender_target), FCMSender_link);
	    		}
			}
		}
	}
	
	private boolean isValidCodeCheck(String beforeAprvStat, String afterAprvStat) {
		/** AS01-임시저장, AS04-반려 -> AS02-상신 */
		if(beforeAprvStat.equals("AS01") || beforeAprvStat.equals("AS04") && afterAprvStat.equals("AS02")) return true;

		/** AS02-상신, AS05-결재완료 -> AS03-상신취소 */
		if((beforeAprvStat.equals("AS02") || beforeAprvStat.equals("AS05")) && afterAprvStat.equals("AS03")) return true;

		/** AS02-상신 -> AS04-반려, AS05-결재완료 */
		if(beforeAprvStat.equals("AS02") && (afterAprvStat.equals("AS04") || afterAprvStat.equals("AS05"))) return true;

		return false;
	}

	private void sendEmail(String title, String text, String to) throws Exception {
		sendEmail(title, text, to, null);
	}

	private void sendEmail(String title, String text, String[] tos) throws Exception {
		sendEmail(title, text, null, tos);
	}

	private void sendEmail(String title, String text, String to, String[] tos) throws Exception {
		MimeMessage msg = javaMailSender.createMimeMessage();
    	MimeMessageHelper msgHelper = new MimeMessageHelper(msg);
        msgHelper.setFrom("91softmanagement@gmail.com");
		msgHelper.setSubject(title);
        msgHelper.setText(text);
        if(to != null && !to.equals("")) {
    		msgHelper.setTo(to);
        	javaMailSender.send(msg);
        }
        if(tos != null && tos.length > 0) {
    		msgHelper.setTo(tos);
    		javaMailSender.send(msg);
        }
	}
}