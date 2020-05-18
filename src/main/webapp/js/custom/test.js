$(function(){

	// csrf 꺼놔서 주석처리 함
	// 스프링 시큐리티 csrf 설정시 ajax로 form을 보낼 경우 추가해줘야 함 
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
//	$(document).ajaxSend(function(e, xhr, options) {
//		xhr.setRequestHeader(header, token);
//	});
	// jsp의 head로 추가해줘야 할 것이 있음
	
	// 유효성 확인용
	var submit = [false, false, false, false, false, false];
	
	$('#memberVO, #modify').submit(function(event) {
		event.preventDefault();
		
		if($(this).prop('id').match('memberVO')) {
			
			for(var i = 0; i < submit.length; i++) {
				if(submit[i] == false) {
					break;
				}
				
				if(i == 5) {
					$(this).unbind('submit').submit();
					alert('회원가입 성공');
				}
			}
			
		} else if($(this).prop('action').match('modify')){
			
//			$(this).find(':input').each(function() {
//				if($(this).val() == "") {
//					$(this).val($(this).prop('placeholder'));
//					console.log($(this).prop('placeholder'));
//				}
//			})
			
			for(var i = 2; i < submit.length; i++) {
				
				if('${mem_tel == "google user" }') {
					submit = [true, true, false, true, true, true];
					
					var regExp = /^[가-힣]{2,10}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
					var name = $('#modify input[name=mem_name]').val();
					var name_valid = $('#name_valid');
					
					if(!regExp.test(name)) {
						name_valid.show();
						submit[2] = false;
					} else {
						name_valid.hide();
						submit[2] = true;
					}
				}
			
				if(submit[i] == false) {
					break;
				}
				
				if(i == 5) {
					$(this).unbind('submit').submit();
				}
			}
			
		} 
	});
	
	// 회원가입, 아이디/비밀번호 찾기, 취소 버튼 누르면 이동할 때
	$('.move_button').click(function() {
		
		if($(this).prop('id').match('modify')) {
			$(location).prop('href', 'mypage/modify');
		} else {
			$(location).prop('href', ($(this).prop('id')));
		}
	});
	
	// 이메일 유효성 체크
	$('#memberVO input[name=mem_id]').on('change', function() {
		
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var email = $(this).val();
		var email_valid = $('#email_valid');
		var email_check = $('#email_check');
		
		if(!regExp.test(email)) {
			email_valid.show();
			email_check.hide();
			submit[0] = false;
		} else {
			email_valid.hide();
			email_check.hide();
			submit[0] = true;
			$.ajax({
				url: ctx + '/check',
				type: 'POST',
				data: 'email=' + email,
				dataType: 'text',
				success: function(emailDuplCheck) { // 자바스크립트에서 false로 반환되는 것은 "", null, undefined, 0, NaN이고 나머진 true 
					if(!emailDuplCheck) {
//						console.log(emailDuplCheck);
						email_check.hide();
						submit[1] = true;
					} else {
						console.log('fail' + emailDuplCheck);
						email_check.show();
						submit[1] = false;
					}
				},
				error: function(jqXHR, status, e) {
					console.log('ajax error');
				}
			});
		}
	});
	
	$('#modify input[name=mem_name]').on({
		'focusout': function() {
			if($(this).val() == '') {
				var mem_name = $(this).prop('placeholder');
				$(this).val(mem_name);
			}
			$(this).trigger('change');
		},
		'focusin': function() {
			var mem_name = $(this).val();
			$(this).val('');
		}
	});
	
	$('#modify input[name=mem_tel]').on({
		'focusout': function() {
			if($(this).val() == '') {
				var mem_tel = $(this).prop('placeholder');
				$(this).val(mem_tel);
			}
			$(this).trigger('change');
		},
		'focusin': function() {
			var mem_tel = $(this).val();
			$(this).val('');
		}
	});
	
	// 이름 유효성 체크
	$('#memberVO input[name=mem_name], #modify input[name=mem_name]').on('change', function() {
		
		// 이름 유효성 검사 문제 있음 (한글 10자리 초과됨, 영어 이름 first name 10자리 초과됨)
		var regExp = /^[가-힣]{2,10}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
//		var regExp = /^[가-힣a-zA-Z]{2,10}$/;
		var name = $('input[name=mem_name]').val();
		var name_valid = $('#name_valid');
		
		if(!regExp.test(name)) {
			name_valid.show();
			submit[2] = false;
		} else {
			name_valid.hide();
			submit[2] = true;
		}
		
	});
	
	// 비밀번호 유효성 체크
	$('#memberVO input[name=mem_pw], #modify input[name=mem_pw]').on('change', function() {
		
		var regExp = /^(?=.*[A-Za-z])(?=.*\d).{8,20}$/;
		var password = $(this).val();
		var password_valid = $('#password_valid');
		
		if(!regExp.test(password)) {
			password_valid.show();
			submit[3] = false;
		} else {
			password_valid.hide();
			submit[3] = true;
		}
		
	});
	
	// 비밀번호 확인 체크
	$('#memberVO input[id=mem_pw_confirm], #modify input[name=mem_pw_confirm]').on('change', function() {
		
		var pw = $('input[name=mem_pw]').val();
		var pw_cf = $(this).val();
		var pw_cf_valid = $('#password_confirm_valid');
		
		if(!(pw === pw_cf)) {
			pw_cf_valid.show();
			submit[4] = false;
		} else {
			pw_cf_valid.hide();
			submit[4] = true;
		}
		
	});
	
	// 전화번호 유효성 체크
	$('#memberVO input[name=mem_tel], #modify input[name=mem_tel]').on('change', function() {
		
		var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
		var phone = $(this).val();
		var phone_valid = $('#phone_valid');
		
		if(!regExp.test(phone)) {
			phone_valid.show();
			submit[5] = false;
		} else {
			phone_valid.hide();
			submit[5] = true;
		}
		
	});
	
// ************** 메뉴 관련 시작 ************** 

	var menu_name = $('#menu_name');
	var url = $('#url');
	
	// 메뉴삭제
	$(document).on('click', '.del_menu', function() {
		
		var menu_no = $(this).prop('id').split('_')[1];
		
		$('.menu_add').hide();
		$('.menu_del').show();
		
		$('#menu_dialog').dialog({
			modal: true,
			resizable: false,
			title: menu_no + ' ' + $(this).text(),
			buttons: {
				'확인': function() { 
					$.ajax({
						url: ctx + '/menu/del',
						type: 'POST',
						data: 'menu_no=' + menu_no,
						dataType: 'text',
						success: function(menu_no) { // 자바스크립트에서 false로 반환되는 것은 "", null, undefined, 0, NaN이고 나머진 true
							if(menu_no) {
								$.dialogDelMenu(menu_no);
							} else {
								alert('error');
							}
							$('#menu_dialog').dialog('close');
						},
						error: function() {
							console.log('error');
						}
					});
				},
				'취소': function() {
					$(this).dialog('close');
				}
			},
			close: function() {
				menu_name.val('');
				url.val('');
			}
		});
	});
	
	// jquery 태그 쓸려면 $()
	// 순수 스크립트 this.innerHTML or innerText
	// jquery $(this).html() or text()
//	$('.add_menu').click(function() { // 동적으로 생성된 버튼이라서 click 이벤트가 안됨
	// 메뉴 추가
	$(document).on('click', '.add_menu', function() {

		var menu_no = $(this).prop('id').split('_')[1];
		
		$('.menu_add').show();
		$('.menu_del').hide();
		
		$('#menu_dialog').dialog({
			modal: true,
			resizable: false,
			title: menu_no + '의 하위 메뉴 ' + $(this).text(),
			buttons: {
				'확인': function() { 
					var menu_data = {
							'menu_name': menu_name.val(),
							'menu_parent': menu_no,
							'url': url.val()
					};
					$.ajax({
						url: ctx + '/menu/add',
						type: 'POST',
						data: menu_data,
						dataType: 'json',
						success: function(menu) { // 자바스크립트에서 false로 반환되는 것은 "", null, undefined, 0, NaN이고 나머진 true
//							console.log(menu);
							if(menu) {
								$.dialogAddMenu(menu);
							} else {
								alert('error');
							}
							$('#menu_dialog').dialog('close');
						},
						error: function() {
							console.log('error');
						}
					});
				},
				'취소': function() {
					$(this).dialog('close');
				}
			},
			close: function() {
				menu_name.val('');
				url.val('');
			}
		});
		
	});
	
// ************** 메뉴 관련 끝 ************** 밑에 더 있음
		
// ************** 멤버리스트 관련 시작 **************

	$('#member_list_reset, #member_list_del').on('click', function() {
		var action;
		var no = $(this).val();
		if($(this).prop('id').match('member_list_reset')) {
			$('.member_list_reset').show();
			$('.member_list_del').hide();
			action = 'member_manage/reset';
		} else if($(this).prop('id').match('member_list_del')) {
			$('.member_list_reset').hide();
			$('.member_list_del').show();
			action = 'member_manage/delete';
		} 
		$('#member_list_diglog').dialog({
			title: action,
			modal: true,
			buttons: {
				확인: function() {
					$(location).prop('href', ctx + '/' + action + '?no=' + no);
				},
				'취소': function() {
					$(this).dialog('close');
					$(".ui-dialog-buttonset", $(this).parent()).hide(); 
				}
			}
		});
	});
	
	// 처음에 DB에 있는 권한리스트 가져와서 출력(함수로 만들 필요도 없네!!)
	if($(location).prop('pathname').match(ctx + '/member_manage')) {
		$.ajax({
			url: ctx + '/member_manage/auth',
			type: 'post',
			dataType: 'json',
			success: function(auth) {
				$.authList(auth);
			}
		});
	};
	
	$('.auth').on('change', function() {
		$.ajax({
			url: ctx + '/member_manage/changeAuth',
			type: 'post',
			data: 'mem_no=' + $(this).prop('title') + '&auth_no=' + $(this).val(),
			dataType: 'text',
			success: function(result) {
				alert('권한이 변경되었습니다.');
			}
		});
	});
	
// ************** 멤버리스트 관련 끝 **************
	
// ************** 그룹 관련 시작 ************** 
	// 내정보 그룹+ 누를경우
	$('#info_groups').click(function() {
		$(location).prop('href', '/nos.mm/group');
	});
	
	// 그룹 상세 보기 다이얼로그
	$(document).on('click', '.grp_mn', function() {

		// 그룹 추가
		if($(this).prop('id').match('grp_add')) {
			$('#grp_add_dialog').show();
			$('#grp_mn').hide();
			
			var grp_name = $('#grp_name');

			$('.grp_dialog').dialog({
				modal: true,
				width: '40%',
				height: 220,
				resizable: false,
				title: '그룹추가',
				open: function() { 
					jQuery('.ui-widget-overlay').bind('click', function() { // 모달 부분 누르면 끄기
						$('.grp_dialog').dialog('close'); 
					});
				},
				buttons: {
					'확인' : function() {
						$.ajax({
							url: ctx + '/member_manage/group/add',
							type: 'POST',
							data: 'mn_group_name=' + grp_name.val(),
							dataType: 'json',
							success: function(group) { // 자바스크립트에서 false로 반환되는 것은 "", null, undefined, 0, NaN이고 나머진 true
								$.addGroup(group);
								$('.grp_dialog').dialog('close');
							},
							error: function() {
								console.log('error');
							}
						});
					}
				},
				close: function() {
					$(this).children('table').children('tbody').remove();
					$(".ui-dialog-buttonset", $(this).parent()).hide(); 
					grp_name.val("");
				}
			});
		} else { // 그룹 상세 보기
			$('#grp_add_dialog').hide();
			$('#grp_mn').show();
			
			// mn_group_no 읽어오기
			var grp_no = $(this).prop('id').split('_')[2]; 
			
			// mn_group_name 읽어오기
			var grp_name = $(this).children('.group_name').text();
			
			$.ajax({
				url: ctx + '/group/manage',
				type: 'POST',
				data: 'mn_group_no=' + grp_no,
				dataType: 'json',
				success: function(group) { // 자바스크립트에서 false로 반환되는 것은 "", null, undefined, 0, NaN이고 나머진 true
					$.dialogGroup(group, grp_no);
					
				},
				error: function() {
					console.log('error');
				}
			});
			
			$('.grp_dialog').dialog({
				
				modal: true,
				width: '40%',
				height: 300,
				resizable: false,
				title: grp_name,
				open: function() { 
					jQuery('.ui-widget-overlay').bind('click', function() { // 모달 부분 누르면 끄기
						$('.grp_dialog').dialog('close'); 
					});
				},
				close: function() {
					$(this).children('table').children('tbody').remove();
				}
			});
		}
	});
	
	
	// 그룹 멤버 삭제
	$(document).on('click', '.del_mem', function() {
		// 그룹 멤버 삭제용 그룹 번호
		var group_no = $('#group_no').val();
		
		var mem_data = $(this);
		var mem_no = $(this).prop('id').split('_')[2];
		
		// 삭제 다시 확인
		if($(this).text().match('정말 삭제?')) {
			$.ajax({
				url: ctx + '/member_manage/group/member/del',
				type: 'post',
				data: 'mem_no=' + mem_no + '&grp_no=' + group_no,
				dataType: 'json',
				success: function(data) {
					if(data) {
						mem_data.parent().parent().remove();
					} else {
						console.log('error : delete fail!!');
					}
				},
				error: function(e) {
					console.log(e);
				}
			});
		} else {
			$(this).text('정말 삭제?');
		}
	});
	
	// 그룹 멤버 추가
	$(document).on('click', '.add_mem', function() {
		$('#grp_mn').append('<tr><td><input type="text" class="form-control border-input" id="mem_id"></td>'
//											+ '<td><input type="text" id="mem_name" readonly="readonly" onfocus="this.blur()" tabindex="-1">'
											+ '<td><select name="mem_name" class="form-control border-input" id="mem_name"><option value=1>-----select-----</option> '
											+ '<input type="text" id="mem_no" hidden=""></td>'
											+ '<td><button type="button" class="add_chk btn btn-xs btn-primary">추가</button></tr>');
	});
	
	// 그룹 멤버 추가시 이메일로 회원인지 확인
	$(document).on('change', '#mem_id', function() {
		console.log($(this).val());
		$.ajax({
			url: ctx + '/member_manage/group/member/check',
			type: 'post',
			data: 'mem_id=' + $(this).val(),
			dataType: 'json',
			success: function(email) {
				var html = '<option value=0>- 선택 -</option>';
				for(var i = 0; i < email.length ; i++){
//					console.log("i"+i);
//					console.log(email[i]);
//					console.log(email[i].MEM_ID);
					html += '<option value=' + email[i].MEM_NO + '>'+ email[i].MEM_ID +'</option>';
					$('#mem_name').html(html);
				}
				
				if(email) {
					console.log(email);
					$('#mem_name').val(email.mem_name);
					$('#mem_no').val(email.mem_no);
				} else {
					$('#mem_name').val('없음');
				}
			},
			error: function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
	
	// 그룹멤버 이름으로 확힌후 이메일 클릭시 
	$(document).on('change', '#mem_name', function() {
		console.log($(this).val());
		$('#mem_no').val($(this).val());
		
	});
	
	// 그룹 멤버 확인후 추가시
	$(document).on('click', '.add_chk', function() {
		if(!$('#mem_name').val().match('없음')) {
			$.ajax({
				url: ctx + '/member_manage/group/member/add',
				type: 'post',
				data: 'mem_id=' + $('#mem_id').val() + '&mem_name=' + $('#mem_name').val() + '&mem_no=' + $('#mem_no').val() + '&group_no=' + $('#group_no').val(),
				dataType: 'json',
				success: function(member) { 
					if(member) {
						$('#mem_name').parent().parent().remove();
						$.addMem(member);
					} else {
						console.log('error');
					}
				},
				error: function(e) {
					console.log(e);
				}
			});
		};
	});
});

$.dialogGroup = function(grp_data, grp_no) {
	var data = grp_data.mem_list; // 그룹 데이터
	var dialog = $('.grp_dialog'); // 그룹 다이얼로그
	var table = dialog.children('table:eq(0)');
	var adminCheck = $('.grp_mn').prop('id').split('_')[1];
	
	$.each(data, function(key, value) {
		if(adminCheck.match('admin')) {
			table.append('<tr><td>' + value.MEM_NAME + '</td>' + '<td>' + value.MEM_ID + '</td>'
					+ '<td><button type="button" id="del_mem_' + value.MEM_NO + '"class="del_mem btn btn-xs btn-danger">삭제</button></td></tr>');
		} else {
			table.append('<tr><td>' + value.MEM_ID + '</td>' + '<td>' + value.MEM_NAME + '</td></tr>');
		}
	});
	if(adminCheck.match('admin')) {
		table.append('<tr><td><button type="button" class="add_mem btn btn-xs btn-primary">추가</button><button type="button" class="del_group btn btn-xs btn-danger">그룹삭제</button><input hidden="" id="group_no" value="' + grp_no + '"></td></tr>')
	}
};

//그룹삭제 
$(document).on('click', '.del_group', function() {
	if(confirm('정말 삭제하시겠습니까?')==true){
//		alert('삭제되엇습니다.'+$('#group_no').val());
		$.ajax({
			url: ctx + '/member_manage/group/delete',
			type: 'post',
			data: 'group_no=' + $('#group_no').val(),
			dataType: 'json',
			success: function(member) { 
//				alert('정말삭제되엇습니다.'+$('#group_no').val());				
				
				window.location.reload();
			},
			error: function(e) {
				alert('실패하였습니다.');
				console.log(e);
				return;
			}
		});
	}else{
		return;
	}
	
});


// 그룹추가
$.addGroup = function(group) {
	$('.groupBox').append('<div class="group col-lg-3 col-md-5"><div class="card group">'
			+ '<div class="content"><ul class="list-unstyled team-members"><li><div class="row">'
			+ '<div class="col-xs-3"><div class="avatar">'
			+ '<img src="../img/add.png" alt="Circle Image" class="img-circle img-no-padding img-responsive">'
			+ '</div></div><div class="header grp_mn group_manage" id="group_admin_'
			+ group.mn_group_no + '">' 
			+ '<h4 class="title group_name">'
			+ group.mn_group_name + '</h4></div></div></li></ul></div></div></div>')};

// 그룹에 멤버 추가
$.addMem = function(member) {
	var dialog = $('.grp_dialog'); // 그룹 다이얼로그
	var table = dialog.children('table:eq(0)');
	
	$.ajax({
		url: ctx + '/member_manage/group/member/add/after',
		type: 'post',
		data: 'mem_no=' + member.mem_no ,
		dataType: 'json',
		success: function(member) { 
			if(member) {
				$('#mem_name').parent().parent().remove();
				table.prepend('<tr><td>' + member.MEM_NAME + '</td>' + '<td>' + member.MEM_ID + '</td>'
						+ '<td><button type="button" id="del_mem_' + member.MEM_NO + '"class="del_mem btn btn-xs btn-danger">삭제</button></td></tr>');
			} else {
				console.log('error');
			}
		},
		error: function(e) {
			console.log(e);
		}
	});
	
}
//************** 그룹 관련 끝 **************

// 메뉴 추가
$.dialogAddMenu = function(menu_data) {
	var menu = menu_data;
	$('#menu_' + menu.menu_parent).append('<h6 id="menu_' + menu.menu_no +'">' + menu.menu_name
						+ '<input type="text" hidden="" value="' + menu.menu_no + '">'
						+ '<button type="button" id="add_' + menu.menu_no + '" class="add_menu btn btn-xs btn-primary">추가</button>'
						+ '<button type="button" id="del_' + menu.menu_no + '"class="del_menu btn btn-xs btn-danger">삭제</button>'
						+ '</h6>');
};

// 메뉴 삭제
$.dialogDelMenu = function(menu_data) {
	$('#menu_' + menu_data).remove();
};

// 권한 출력
$.authList = function(auth) {
	$.each(auth, function(i, v) {
		$('.auth').append('<option value="' + v.AUTH_NO + '">' + v.AUTH_NAME + '</option>');
	});
};

//function page_redirect(id, url) {
//	document.${id }.
//}