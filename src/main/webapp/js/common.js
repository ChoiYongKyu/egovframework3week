$(function() {
	$.ajaxSetup({
				beforeSend : function() {
					var width = 0;
					var height = 0;
					var left = 0;
					var top = 0;

					width = 50;
					height = 50;

					top = ($(window).height() - height) / 2
							+ $(window).scrollTop();
					left = ($(window).width() - width) / 2
							+ $(window).scrollLeft();

					if ($("#div_ajax_load_image").length != 0) {
						$("#div_ajax_load_image").css({
							"top" : top + "px",
							"left" : left + "px"
						});
						$("#div_ajax_load_image").show();
					} else {
						$('body').append('<div class="modalfake">'
			+	'				<div id="modal-dialog" class="modal-dialog" style="width: max-content; top: 30vh;" >'
			+	'					<div class="modal-content" style="width: max-content; overflow: hidden; width: auto; background-color: transparent; box-shadow: unset; border: none;">'
			+	'					<!-- header -->'					
			+	'					<!-- body -->'
			+	'					<div class="modal-body" >'
			+	'						<img class="card card-plain" src="/nos.mm/img/loader.gif" id="modal-img" >'
			+	'					</div>'
			+	'					<!-- Footer -->'						
			+	'					</div>'
			+	'				</div>'
			+	'		</div>');
						
						
						
						
//						$('body').append('<div id="div_ajax_load_image" style="position:absolute; top:'
//												+ top
//												+ 'px; left:'
//												+ left
//												+ 'px; width:'
//												+ width
//												+ 'px; height:'
//												+ height
//												+ 'px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="..\\img\\logo.jpg" style="width:30vx; height:30vh;"></div>');
					}

				},
				complete : function() {
//					setTimeout(function() {
						$(".modalfake").hide();
//					}, 1000);
				}
		});
});


var datePickerOption = {
	dateFormat: "yy-mm-dd",
	closeText: "닫기",
	prevText: "이전달",
	nextText: "다음달",
	currentText: "오늘",
	monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
	monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
	dayNames: ["일","월","화","수","목","금","토"],
	dayNamesShort: ["일","월","화","수","목","금","토"],
	dayNamesMin: ["일","월","화","수","목","금","토"],
	weekHeader: "주",
	firstDay: 0,
	isRTL: false,
	numberOfMonths: 1,
	minDate: 0,
	showMonthAfterYear: true,
	yearSuffix: "년",
	showButtonPanel: true
};