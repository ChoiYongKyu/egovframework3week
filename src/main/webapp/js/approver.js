var approverIdx = 0;
$(window).load(function() {
	if($("#mode").val() == "insert") {
		addApprover();
	}
	else {
		$(".decidingOfficerData").each(function() {
			addApprover($(this).val());
		});
	}
});

function addApprover(selectedIdx) {
	if(selectedIdx === undefined) {
		selectedIdx = "";
	}

	approverIdx++;

	var _html = "<div id=\"approverContainer" + approverIdx + "\" style=\"overflow:hidden;\">";
	_html += "       <div style=\"float:left; width:100%; padding-right:48px;\">";
	_html += "           <select name=\"approver\" class=\"approver form-control\" id=\"approver" + approverIdx + "\" style=\"width:100%\">";
	_html += "               <option value=\"\">- 선택 -</option>";
	$(".approversData").each(function() {
		var tmps = $(this).val().split("|");
		_html += "           <option value=\"" + tmps[0] + "\" " + (tmps[0]==selectedIdx?"selected":"") + ">" + tmps[1] + "</option>";
	});
	_html += "           </select>";
	_html += "       </div>";
	_html += "       <div style=\"float:right; margin-top:-42px;\">";
	if(approverIdx == 1) {
		_html += "       <i class=\"fas fa-plus-circle\" style=\"font-size:2.3em; cursor:pointer;\" data-idx=\"" + approverIdx + "\"></i>";		
	}
	else {
		_html += "       <i class=\"fas fa-minus-circle\" style=\"font-size:2.3em; cursor:pointer;\" data-idx=\"" + approverIdx + "\"></i>";
	}
	
	_html += "       </div>";
	_html += "   </div>";

	$("#approverArea").append(_html);
}

function isSelectedApprover() {
	var isSelected = true;
	$(".approver").each(function(i, v) {
		if($(this).val() == "") {
			isSelected = false;
		}
	});
	return isSelected;
}


$(document).on("click", "#approverArea i", function() {
	if($(this).data("idx") == 1) {
		addApprover();
	}
	else {
		$("#approverContainer" + $(this).data("idx")).remove();
	}
});