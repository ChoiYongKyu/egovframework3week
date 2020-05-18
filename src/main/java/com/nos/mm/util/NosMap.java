package com.nos.mm.util;
import java.util.Map;

import org.apache.commons.collections4.map.ListOrderedMap;

@SuppressWarnings("rawtypes")
public class NosMap extends ListOrderedMap {
    private static final long serialVersionUID = 6723434363565852261L;

	/** 기본생성자
	 */
	public NosMap() {
		super();
	}
	
	/** 다른 맵을 NosMap으로 변환하여 객체생성
	 * @param param
	 */
    @SuppressWarnings("unchecked")
	public NosMap(Map<String, Object> param) {
    	super(param);
    }

    @SuppressWarnings("unchecked")
	@Override
    public Object put(Object key, Object value) {
    	System.out.println("########### Key :::: " + key.toString());
    	if(key.toString().equals("CSTN_CN")) {
    		value = value.toString().replaceAll("width:", "");
    	}
    	
        return super.put(CamelUtil.convert2CamelCase((String) key), value);
    }

    public String getString(String key) {
    	Object thisValue = get(key);
    	if(thisValue == null) {
    		return "";
    	}
    	else {
    		return String.valueOf(thisValue);
    	}
    }
    
    public int getInt(String key) {
    	String value = getString(key);
    	if(value == "") {
    		return 0;
    	}
    	else {
    		return Integer.parseInt(value);
    	}
    }
}