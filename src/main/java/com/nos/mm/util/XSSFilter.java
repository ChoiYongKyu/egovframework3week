package com.nos.mm.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class XSSFilter implements Filter {

	public FilterConfig filterCofig;
	
	@Override
	public void destroy() {
		this.filterCofig = null;
	}

	@Override
	public void init(FilterConfig filterCofig) throws ServletException {
		this.filterCofig = filterCofig; 
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
		filterChain.doFilter(new XSSprevent((HttpServletRequest)request), response);
	}

}
