package com.nos.mm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	final static Logger logger = Logger.getLogger(ProductController.class);

	@Autowired
	private ProductService service;

	@RequestMapping("")
	public ModelAndView product() {
		ModelAndView mav = new ModelAndView("redirect:/product/stats");

		return mav;
	}

	@RequestMapping("/productRegister")
	public ModelAndView registerVeiw() {
		ModelAndView mav = new ModelAndView("product/register");

		return mav;
	}

	@RequestMapping(value = "/productRegister", method = RequestMethod.POST) // 글
																				// 데이터
																				// 넘기기
	public ModelAndView insert(@RequestParam Map<String, Object> value) throws Exception {

		ModelAndView mav = new ModelAndView("redirect:/product/stats");
		logger.debug(value.toString());
		service.insert(value);
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/getChart", method = RequestMethod.POST) // 차트데이터
																		// 가져오기
	public Object getChart(@RequestParam Map<String, Object> value) throws Exception {
		service.getChart((int) value.get("client_no"));
		return false;
	}

	@RequestMapping("/productDetail")
	public ModelAndView productDetail(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("product/detail");
		Map<String, Object> map = service.getDetail(no);
		mav.addObject("detail", map.get("detail"));
		mav.addObject("version", map.get("version"));
		logger.debug(map.get("version").toString());

		return mav;
	}

	@RequestMapping(value = "/productDetail", method = RequestMethod.POST) // 버전
																			// 데이터
																			// 넘기기
	public ModelAndView insertVersion(@RequestParam Map<String, Object> value) throws Exception {
		logger.debug(value.toString());
		ModelAndView mav = new ModelAndView("redirect:/product/productDetail?no=" + value.get("product_no"));
		int testint = Integer.valueOf(value.get("add").toString());
		logger.debug(testint);
		if (testint == 0) {
			service.insertVersion(value);
		} else {
			service.updateVersion(value);
		}
		return mav;
	}

	@RequestMapping(value = "/versionDelete") // 버전 데이터 삭제
	public ModelAndView deleteVersion(@RequestParam int no, @RequestParam int pro) {
		ModelAndView mav = new ModelAndView("redirect:/product/productDetail?no=" + pro);
		service.deleteVersion(no);
		return mav;
	}

	@RequestMapping("/requireProduct") // 요구 제품 페이지
	public ModelAndView requireProduct(@RequestParam Map<String, Object> value, @RequestParam int no, @RequestParam String name) {
		ModelAndView mav = new ModelAndView("product/requireProduct");
		mav.addObject("productList", service.getProduct());
		mav.addObject("list", service.getProductList(no));
		mav.addObject("client_no",no);
		mav.addObject("client_name", name);
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/selectVersion", method = RequestMethod.POST) // 제품
																			// 선택시
																			// 버전
																			// 가져오기
	public List<Map<String, Object>> selectVersion(@RequestParam Map<String, Object> value) {
		logger.debug(value.toString());
		List<Map<String, Object>> map = service.getVersionList(value);

		return map;
	}

	@RequestMapping(value = "/requireProduct", method = RequestMethod.POST) // 제품
																		 // 버전
																		 // 넘기기
	public ModelAndView insertData(@RequestParam Map<String, Object> value) throws Exception {
		logger.debug("------------------" + value + "----------------");
		ModelAndView mav = new ModelAndView("redirect:/product/requireProduct?no="+value.get("client_no") 
										  + "&name=" + value.get("client_name"));
		
		if(Integer.valueOf(value.get("add").toString()) == 0) {
			service.dataInsert(value);
		} else {
			service.dataModify(value);
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/requireDelete") // 제품 
											  // 버전
											  // 삭제
	public ModelAndView deleteRow(@RequestParam int pNo, @RequestParam int lNo, @RequestParam int cNo, @RequestParam String cName) {
		ModelAndView mav = new ModelAndView("redirect:/product/requireProduct?no=" + cNo + "&name=" + cName);
		service.deleteRow(pNo, lNo);
		return mav;
	}
	
	@RequestMapping(value = "/stats") // 통계
									  // 페이지
									  // 고객사, 제품 뽑아옴
	public ModelAndView statsPage() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("productList", service.getProduct());
		mav.addObject("clientList", service.getClient());
		mav.addObject("list", service.getList());
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectClient", method = RequestMethod.POST) // 고객사
																			// 선택시
																			// 제품 값
																			// 가져오기
	public Map<String, Object> selectClient(@RequestParam Map<String, Object> value) {
		logger.debug("-------------------------------" + value+ "---------------------------------");
		Map<String, Object> result = new HashMap<>();  
		result.put("product", service.getUsingProductList(value));
		result.put("version", service.getUsingVersionList(value));
		result.put("count", service.getUsingCount(value));
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectProduct", method = RequestMethod.POST) // 제품
																			// 선택시
																			// 값
																			// 가져오기
	public List<Map<String, Object>> selectProduct(@RequestParam Map<String, Object> value) {
		logger.debug("-------------------------------" + value+ "---------------------------------");
		List<Map<String, Object>> map = service.getUsingClientList(value);

		return map;
	}
	
	
}
