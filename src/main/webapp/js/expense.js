var expenseIdx = 0;
var totalSum = 0;
$(document).on('change', '#category', function() {
	var type = $(this).val();
	expenseIdx = 0;
	
	ex(type);
	
	$('ul[id^="notice"]').addClass('hidden');
	$('#notice_' + type).removeClass('hidden');
	addExpense();
});


$(window).load(function() {
	if($("#mode").val() == "insert") {
		addExpense();
	}
	else {
		var type = $('#category').val();
		
		$('#notice_' + type).removeClass('hidden');
		
		ex(type);
		$(".dtlData").each(function() {
			addExpense($(this).data());
		});
	}
});

function ex(type) {
	var ex = "";
	// 복리후생비(EX01) / 교통비 및 기타비용(EX02)
	if(type == 'EX01' || type == 'EX02') {
		ex = "<table class=\"listTable table table-bordered\" id=\"expenseArea\">";
		ex += "		<colgroup>";
		ex += "			<col width=\"10%\"/>";
		ex += "			<col width=\"11%\"/>";
		ex += "			<col width=\"*\"/>";
		ex += "			<col width=\"10%\"/>";
		ex += "			<col width=\"10%\"/>";
		ex += "			<col width=\"15%\"/>";
		ex += "		</colgroup>";
		ex += "		<tr>";
		ex += "			<th>일자</th>";
		ex += "			<th>용도</th>";
		ex += "			<th>내역</th>";
		ex += "			<th>인원</th>";
		ex += "			<th>금액</th>";
		ex += "			<th>비고</th>";
		ex += "		</tr>";
		ex += "	</table>";
		
	// 대중교통비(EX03)
	} else if(type == 'EX03') {
		ex = "<table class=\"listTable table table-bordered\" id=\"expenseArea\">";
		ex += "		<colgroup>";
		ex += "			<col width=\"10%\"/>";
		ex += "			<col width=\"20%\"/>";
		ex += "			<col width=\"20%\"/>";
		ex += "			<col width=\"20%\"/>";
		ex += "			<col width=\"10%\"/>";
		ex += "			<col width=\"20%\"/>";
		ex += "		</colgroup>";
		ex += "		<tr>";
		ex += "			<th>일자</th>";
		ex += "			<th>방문회사/목적</th>";
		ex += "			<th>교통수단</th>";
		ex += "			<th>방문장소</th>";
		ex += "			<th>구분</th>";
		ex += "			<th>금액</th>";
		ex += "		</tr>";
		ex += "	</table>";
	}
	
	$('#content').html(ex);
}

function addExpense(data) {
	if(!data) {
		data = "";
	}
	expenseIdx++;

	var type = $('#category').val();
	var _html = "";
	
	// 복리후생비(EX01)
	if(type == 'EX01') {
		_html = "	<tr id=\"expenseContainer" + expenseIdx + "\">";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.dtm : '') + "\"type=\"text\" name=\"dtm\" id=\"dtm" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\" readonly /></td>";
		_html += "       <td style=\"padding: 0;\">";
		_html += "			<select style=\"background-color:#fff; display:inline; margin:0; padding:0; \" name=\"usage\" id=\"usage" + expenseIdx + "\" class=\"form-control\" required>";
		_html += "				<option value=\"\">- 선택 -</option>";
		$(".useEx01").each(function() {
			_html += "           <option value=\"" + $(this).data().value + "\" " + (data ? (data.usage == $(this).data().value ? 'selected' : '') : '') + ">" + $(this).data().value + "</option>";
		});
//		_html += "				<option value=\"회식비\"" + (data ? (data.usage == '회식비'? 'selected' : '') : '') + ">회식비</option>";
//		_html += "				<option value=\"식대비\"" + (data ? (data.usage == '식대비'? 'selected' : '') : '') + ">식대비</option>";
//		_html += "				<option value=\"숙박비\"" + (data ? (data.usage == '숙박비'? 'selected' : '') : '') + ">숙박비</option>";
//		_html += "				<option value=\"통신비\"" + (data ? (data.usage == '통신비'? 'selected' : '') : '') + ">통신비</option>";
//		_html += "				<option value=\"소모품비\"" + (data ? (data.usage == '소모품비'? 'selected' : '') : '') + ">소모품비</option>";
//		_html += "				<option value=\"복리후생비\"" + (data ? (data.usage == '복리후생비'? 'selected' : '') : '') + ">복리후생비</option>";
		_html += "			</select>";
		_html += "		 </td>";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.content : '') + "\"type=\"text\" name=\"content\" id=\"content" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.person : '') + "\"type=\"number\" name=\"person\" id=\"person" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.money : '') + "\"type=\"text\" name=\"money\" id=\"money" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
		_html += "       <td style=\"padding: 0;\">";
		_html += "			<select style=\"background-color:#fff; display:inline; margin:0; padding:0; width:70%; \" name=\"etc\" id=\"etc" + expenseIdx + "\" class=\"form-control\" required>";
		_html += "				<option value=\"\">- 선택 -</option>";
		_html += "				<option value=\"개인카드\"" + (data ? (data.etc == '개인카드'? 'selected' : '') : '') + ">개인카드</option>";
		_html += "				<option value=\"법인카드\"" + (data ? (data.etc == '법인카드'? 'selected' : '') : '') + ">법인카드</option>";
		_html += "				<option value=\"현금\"" + (data ? (data.etc == '현금'? 'selected' : '') : '') + ">현금</option>";
		_html += "			</select>";
		
		/*_html += "           <select name=\"approver\" class=\"expense form-control\" id=\"approver" + expenseIdx + "\" style=\"width:20%; display:inline-block;\">";
		_html += "               <option value=\"\">- 선택 -</option>";
		$(".approversData").each(function() {
			var tmps = $(this).val().split("|");
			_html += "           <option value=\"" + tmps[0] + "\" " + (tmps[0]==selectedIdx?"selected":"") + ">" + tmps[1] + "</option>";
		});
		_html += "           </select>";*/
		if(expenseIdx == 1) {
			_html += "       <i class=\"fas fa-plus-circle\" style=\"cursor:pointer;\" data-idx=\"" + expenseIdx + "\"></i></td>";		
		}
		else {
			_html += "       <i class=\"fas fa-minus-circle\"cursor:pointer;\" data-idx=\"" + expenseIdx + "\"></i></td>";
		}
		
		_html += "   </tr>";
		
		// 교통비 및 기타비용(EX02)
	} else if(type == 'EX02') {
			_html = "	<tr id=\"expenseContainer" + expenseIdx + "\">";
			_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.dtm : '') + "\"type=\"text\" name=\"dtm\" id=\"dtm" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\" readonly /></td>";
			_html += "       <td style=\"padding: 0;\">";
			_html += "			<select style=\"background-color:#fff; display:inline; margin:0; padding:0; \" name=\"usage\" id=\"usage" + expenseIdx + "\" class=\"form-control\" required>";
			_html += "				<option value=\"\">- 선택 -</option>";
			$(".useEx02").each(function() {
				_html += "           <option value=\"" + $(this).data().value + "\" " + (data ? (data.usage == $(this).data().value ? 'selected' : '') : '') + ">" + $(this).data().value + "</option>";
			});
//			_html += "				<option value=\"교통비\"" + (data ? (data.usage == '교통비'? 'selected' : '') : '') + ">교통비</option>";
//			_html += "				<option value=\"유류대\"" + (data ? (data.usage == '유류대'? 'selected' : '') : '') + ">유류대</option>";
//			_html += "				<option value=\"주차비\"" + (data ? (data.usage == '주차비'? 'selected' : '') : '') + ">주차비</option>";
//			_html += "				<option value=\"접대비\"" + (data ? (data.usage == '접대비'? 'selected' : '') : '') + ">접대비</option>";
			_html += "			</select>";
			_html += "		 </td>";
			_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.content : '') + "\"type=\"text\" name=\"content\" id=\"content" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
			_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.person : '') + "\"type=\"number\" name=\"person\" id=\"person" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
			_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.money : '') + "\"type=\"text\" name=\"money\" id=\"money" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
			_html += "       <td style=\"padding: 0;\">";
			_html += "			<select style=\"background-color:#fff; display:inline; margin:0; padding:0; width:70%; \" name=\"etc\" id=\"etc" + expenseIdx + "\" class=\"form-control\" required>";
			_html += "				<option value=\"\">- 선택 -</option>";
			_html += "				<option value=\"개인카드\"" + (data ? (data.etc == '개인카드'? 'selected' : '') : '') + ">개인카드</option>";
			_html += "				<option value=\"법인카드\"" + (data ? (data.etc == '법인카드'? 'selected' : '') : '') + ">법인카드</option>";
			_html += "				<option value=\"현금\"" + (data ? (data.etc == '현금'? 'selected' : '') : '') + ">현금</option>";
			_html += "			</select>";
			
			/*_html += "           <select name=\"approver\" class=\"expense form-control\" id=\"approver" + expenseIdx + "\" style=\"width:20%; display:inline-block;\">";
		_html += "               <option value=\"\">- 선택 -</option>";
		$(".approversData").each(function() {
			var tmps = $(this).val().split("|");
			_html += "           <option value=\"" + tmps[0] + "\" " + (tmps[0]==selectedIdx?"selected":"") + ">" + tmps[1] + "</option>";
		});
		_html += "           </select>";*/
			if(expenseIdx == 1) {
				_html += "       <i class=\"fas fa-plus-circle\" style=\"cursor:pointer;\" data-idx=\"" + expenseIdx + "\"></i></td>";		
			}
			else {
				_html += "       <i class=\"fas fa-minus-circle\"cursor:pointer;\" data-idx=\"" + expenseIdx + "\"></i></td>";
			}
			
			_html += "   </tr>";
			
	// 대중교통비(EX03)
	} else if(type == 'EX03') {
		_html = "	<tr id=\"expenseContainer" + expenseIdx + "\">";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.dtm : '') + "\"type=\"text\" name=\"dtm\" id=\"dtm" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\" readonly/></td>";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.purpose : '') + "\" type=\"text\" name=\"purpose\" id=\"purpose" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.usage : '') + "\" type=\"text\" name=\"usage\" id=\"usage" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.content : '') + "\" type=\"text\" name=\"content\" id=\"content" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; \" class=\"form-control\"/></td>";
		_html += "       <td style=\"padding: 0;\">"; 
		_html += "			<select style=\"background-color:#fff; display:inline; margin:0; padding:0; \" name=\"etc\" id=\"etc" + expenseIdx + "\" class=\"form-control\" required>";
		_html += "				<option value=\"\">- 선택 -</option>";
		_html += "				<option value=\"왕복\"" + (data ? (data.etc == '왕복'? 'selected' : '') : '') + ">왕복</option>";
		_html += "				<option value=\"편도\"" + (data ? (data.etc == '편도'? 'selected' : '') : '') + ">편도</option>";
		_html += "			</select>";
		_html += "		 </td>";
		_html += "       <td style=\"padding: 0;\"><input value=\"" + (data ? data.money : '') + "\" type=\"text\" name=\"money\" id=\"money" + expenseIdx + "\" style=\"background-color:#fff; display:inline; margin:0; padding:0; text-align:center; width:50%; \" class=\"form-control\"/>";
		if(expenseIdx == 1) {
			_html += "       <i class=\"fas fa-plus-circle\" style=\"cursor:pointer;\" data-idx=\"" + expenseIdx + "\"></i></td>";		
		}
		else {
			_html += "       <i class=\"fas fa-minus-circle\" style=\"cursor:pointer;\" data-idx=\"" + expenseIdx + "\"></i></td>";
		}
		
		_html += "   </tr>";
	
	// 선택없음
	} else {
		$('#content').html("구분을 선택해주세요.");
	}
	
	// 합계
	var _sum = "	<tr id=\"sum\">";
	_sum += "          <td colspan=\"5\" style=\"text-align:right; padding-right: 10px;\">합계</td>";
	_sum += "          <td style=\"padding-right: 0px;\"><input id=\"sumTd\" class=\"form-control\" readonly style=\"margin-bottom: 0px; text-align: center;\"/></td>";
	_sum += "       </tr>";
	$('#sum').remove();
	$("#expenseArea").append(_html);
	$("#expenseArea").append(_sum);
	
	datePickerOption.minDate = '-1 Y';
	datePickerOption.dateFormat = 'mm/dd';
	$("#dtm" + expenseIdx).datepicker(datePickerOption);
	
	if(!data) {
		$("#dtm" + expenseIdx).datepicker('setDate', '-1M');
	}
}


$(document).on('keyup', 'input[name=money]', function() {
	var money = $(this).val().replace(/[^0-9]/g, '');
	$(this).val(Number(money).toLocaleString());
});
$(document).on('focusout', 'input[name=money]', function() {
	totalSum = 0;
	$('input[name=money]').each(function() {
		totalSum += Number($(this).val().replace(/[^0-9]/g, ''));
	});
	$('#sumTd').val(totalSum.toLocaleString());
});
$(document).on('click', 'i', function() {
	totalSum = 0;
	setTimeout(function() {
		$('input[name=money]').each(function() {
			totalSum += Number($(this).val() ? $(this).val().replace(/[^0-9]/g, '') : 0);
		});
	}, 100);
	
	setTimeout(function() {
		$('#sumTd').val(totalSum.toLocaleString());
	}, 100);
	
});

function isDtm() {
	var isSelected = true;
	$("input[name=dtm]").each(function(i, v) {
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}

function isUsage() {
	var isSelected = true;
	$("select[name=usage]").each(function(i, v) {
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}

function isContent() {
	var isSelected = true;
	$("input[name=content]").each(function(i, v) {
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}

function isPerson() {
	var isSelected = true;
	$("input[name=person]").each(function(i, v) {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}

function isMoney() {
	var isSelected = true;
	$("input[name=money]").each(function(i, v) {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}

function isEtc() {
	var isSelected = true;
	$("input[name=etc]").each(function(i, v) {
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}

function isPurpose() {
	var isSelected = true;
	$("input[name=purpose]").each(function(i, v) {
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}

$(document).on("click", "#expenseArea i", function() {
	if($(this).data("idx") == 1) {
		addExpense();
	}
	else {
		$("#expenseContainer" + $(this).data("idx")).remove();
	}
});