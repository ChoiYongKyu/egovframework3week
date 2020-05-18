package com.nos.mm.vo;

public class MenuVO {

	private int menu_no;
	private String menu_name;
	private int menu_parent;
	private String url;
	private int level;
	
	public int getMenu_no() {
		return menu_no;
	}
	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public int getMenu_parent() {
		return menu_parent;
	}
	public void setMenu_parent(int menu_parent) {
		this.menu_parent = menu_parent;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
}
