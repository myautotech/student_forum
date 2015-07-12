$.validator.addMethod("exactlength", function(value, element, param) {
 return this.optional(element) || value.length == param;
}, $.validator.format("Please enter exactly {0} characters."));

$(function(){
	var valid_name = {required: true,lettersonly: true},
	valid_text = {required: true},
	valid_contact = {required: true, number: true, exactlength: 10},
	valid_email = {required: true, email: true},
	valid_password = {required: true, minlength: 8},
	valid_confirm_pass = {required: true, equalTo: '#user_password'},
	valid_image = {accept: 'jpg|jpeg|png|gif'},
	valid_img_vd = {accept: 'jpg|jpeg|png|gif'},
	valid_pin = {required: true, number: true, exactlength: 6};
	$('#customer_form').validate({
		rules: {
		'customer[name]': valid_text,
		'customer[street]': valid_text,
		'customer[city]': valid_name,
		'customer[state]': valid_name,
		'customer[country]': valid_name,
		'customer[pincode]': valid_pin,
		'customer[email]': valid_email,
		'customer[contact_no]': valid_contact,
		'customer[logo]': valid_image,
		'user[first_name]': valid_name,
		'user[last_name]': valid_name,
		'user[contact_no]': valid_contact,
		'user[email]': valid_email,
		'user[password]': valid_password
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
    $('#user_form').validate({
		rules: {
		'user[first_name]': valid_name,
		'user[last_name]': valid_name,
		'user[contact_no]': valid_contact,
		'user[email]': valid_email,
		'user[password]': valid_password,
		'user[password_confirmation]': valid_confirm_pass,
		'user[image]': valid_image,
		'user[customer_id]': valid_text
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
	$('#group_form').validate({
		rules: {
		'group[name]': valid_text,
		'group[image]': valid_image,
		'group[customer_id]': valid_text,
		'user[id]': valid_text
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
	$('#category_form').validate({
		rules: {
		'category[name]': valid_text
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
	$('#post_form').validate({
		rules: {
		'post[title]': valid_text,
		'post[content]': valid_text,
		'files[]': valid_img_vd
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
	$('#document_form').validate({
		rules: {
		'document[title]': valid_text
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
});