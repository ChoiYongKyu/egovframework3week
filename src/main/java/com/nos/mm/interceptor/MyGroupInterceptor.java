package com.nos.mm.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.nos.mm.service.MenuService;

public class MyGroupInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	MenuService service;

	private final static Logger logger = Logger.getLogger(MyGroupInterceptor.class);

	@Override
	// 웹을 로드하기 전에
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		/*
		 * if(request.getRemoteAddr().toString().equals("192.168.10.17")){
		 * System.out.println("차단!"); return false; }
		 */
		return true;
	}

	@Override
	// 웹을 로드 한 후에
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	// 브라우저를 로드하기 직전에
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// System.out.println("----------------------interceptor
		// START!!!!!!!!!!!!!!");
		// 세션에 사용자의 그룹 리스트 정보가 없을경우 리스트 정보를 저장함
		HttpSession session = request.getSession();
		if (session.getAttribute("myGroup") == null) {
			session.setAttribute("myGroup", service.getGroup(request.getUserPrincipal().getName()));
		}
		// logger.trace("Trace Message!");
		// logger.debug("Debug Message!");
		// logger.info("Info Message!");
		// logger.warn("Warn Message!");
		// logger.error("Error Message!");
		// logger.fatal("Fatal Message!");
//		logger.info("----------IP_= " + request.getRemoteAddr());
//		logger.info("----------HOST_= " + request.getRemoteHost());
//		logger.info("----------PORT_= " + request.getRemotePort());
//		logger.info("----------USER_= " + request.getRemoteUser());
//		logger.info("----------지역_= " + request.getLocale());
		//
		// logger.debug("----------------쿠키 불러오기");
		// Cookie cookies[] = request.getCookies();
		// for (Cookie cook : cookies) {
		// String result = "";
		// result += cook.getName();
		// result += " = ";
		// result += cook.getValue();
		// logger.debug("----------------------Cookies : " + result);
		// }

		// System.out.println("");
		// System.out.println("");
		// System.out.println("");

		Enumeration<String> eParam = request.getParameterNames();
		if (eParam.hasMoreElements()) {
			logger.debug("------파라미터 데이터 ");
			while (eParam.hasMoreElements()) {
				String result = "           ";
				result += eParam.nextElement();
				result += " = ";
				result += request.getParameter(eParam.nextElement());
				logger.debug(result + "           ");
			}
			logger.debug("------파라미터 데이터 끝");
		}
		// Enumeration<String> parameterEnum = request.getParameterNames();
		// String paramNm = null;
		// String[] param = null;
		// int paramCnt = 0;
		// System.out.println("----------------" + request.getRequestURI() + "
		// 파라미터 필터");
		// while (parameterEnum != null && parameterEnum.hasMoreElements()){
		// paramNm = (String) parameterEnum.nextElement();
		// param = request.getParameterValues(paramNm);
		// if(param!=null && param.length > 0){
		// paramCnt = param.length;
		// if(paramCnt >1){
		// for(int i = 0; i < paramCnt; i++){
		// System.out.println("▶▶ " + paramNm + " : " + param[i]);
		// }
		// } else {
		// System.out.println("▶▶ " + paramNm + " : " + param[0]);
		// }
		// }
		// }
		// System.out.println("-------------- 파라미터 필터 끝---------------");

		// System.out.println("");
		// System.out.println("");
		// System.out.println("");
		// System.out.println("");
		// System.out.println("----------------------interceptor
		// END!!!!!!!!!!!!!!");

//		Enumeration<String> eAttr = request.getAttributeNames();
//		if (eAttr.hasMoreElements()) {
//			logger.debug("--------attribute");
//			while (eAttr.hasMoreElements()) {
//				String aName = (String) eAttr.nextElement();
//				String aValue = request.getHeader(aName);
//
//				logger.debug(aName + " = " + aValue);
//			}
//			logger.debug("--------attribute 끝");
		// }
	}
}
