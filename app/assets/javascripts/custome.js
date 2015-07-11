function send_customer() {
	var customer_id = $('#group_customer_id').val();
    $.get('/groups/customers?customer_id='+customer_id,function(){});
}

$(function () {
	$('input').iCheck({
		checkboxClass: 'icheckbox_square-blue',
		radioClass: 'iradio_square-blue',
	    increaseArea: '20%' // optional
	});
});

function flash_msg(msg, type) {
    setTimeout(function() {
        toastr.options = {
            closeButton: true,
            showMethod: 'slideDown',
            timeOut: 3000
        };

        if (type == 'error'){
          toastr.error(msg);
        }else{
          toastr.success(msg);
        }

    }, 1000);
}

datatable = function(){
  $('.datatable').dataTable({"order": [[0, 'desc']]});
}
$(document).ready(datatable);
