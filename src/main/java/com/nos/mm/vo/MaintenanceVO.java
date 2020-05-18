package com.nos.mm.vo;

import java.sql.Date;

public class MaintenanceVO {

	private int mn_no;
	private String mn_sup_item;
	private String mn_reference;
	private String mn_req_date;
	private String mn_start_date;
	private String mn_end_date;
	private int mn_sup_days;
	private int mn_del_yn;
	private String mem_no;
	private int mn_group_no;
	private int client_no;
	private int support_no;
	private int work_scope_no;
	private Date write_date;
	private int parent_no;

	public int getMn_no() {
		return mn_no;
	}

	public void setMn_no(int mn_no) {
		this.mn_no = mn_no;
	}

	public String getMn_sup_item() {
		return mn_sup_item;
	}

	public void setMn_sup_item(String mn_sup_item) {
		this.mn_sup_item = mn_sup_item;
	}

	public String getMn_reference() {
		return mn_reference;
	}

	public void setMn_reference(String mn_reference) {
		this.mn_reference = mn_reference;
	}

	public String getMn_req_date() {
		return mn_req_date;
	}

	public void setMn_req_date(String mn_req_date) {
		this.mn_req_date = mn_req_date;
	}

	public String getMn_start_date() {
		return mn_start_date;
	}

	public void setMn_start_date(String mn_start_date) {
		this.mn_start_date = mn_start_date;
	}

	public String getMn_end_date() {
		return mn_end_date;
	}

	public void setMn_end_date(String mn_end_date) {
		this.mn_end_date = mn_end_date;
	}

	public int getMn_sup_days() {
		return mn_sup_days;
	}

	public void setMn_sup_days(int mn_sup_days) {
		this.mn_sup_days = mn_sup_days;
	}

	public int getMn_del_yn() {
		return mn_del_yn;
	}

	public void setMn_del_yn(int mn_del_yn) {
		this.mn_del_yn = mn_del_yn;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public int getClient_no() {
		return client_no;
	}

	public void setClient_no(int client_no) {
		this.client_no = client_no;
	}

	public int getSupport_no() {
		return support_no;
	}

	public void setSupport_no(int support_no) {
		this.support_no = support_no;
	}

	public int getWork_scope_no() {
		return work_scope_no;
	}

	public void setWork_scope_no(int work_scope_no) {
		this.work_scope_no = work_scope_no;
	}

	public int getParent_no() {
		return parent_no;
	}

	public void setParent_no(int parent_no) {
		this.parent_no = parent_no;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public int getMn_group_no() {
		return mn_group_no;
	}

	public void setMn_group_no(int mn_group_no) {
		this.mn_group_no = mn_group_no;
	}

	public char[] get(String string) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
