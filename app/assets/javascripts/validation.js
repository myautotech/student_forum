var valid_name = {required: true,lettersonly: true},
valid_text = {required: true},
valid_contact = {required: true, number: true},
valid_email = {required: true, email: true},
valid_password = {required: true, minlength: 8},
valid_confirm_pass = {required: true, equalTo: '#user_password'},
valid_image = {accept: 'jpg|jpeg|png|gif'},
valid_pin = {required: true, number: true},
validation = function(){
	$('#customer_form').validate({
		debug: true,
		rules: {
		'customer[name]': valid_text,
		'customer[street]': valid_name,
		'customer[city]': valid_name,
		'customer[state]': valid_name,
		'customer[street]': valid_name,
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
		debug: true,
		rules: {
		'user[first_name]': valid_name,
		'user[last_name]': valid_name,
		'user[contact_no]': valid_contact,
		'user[email]': valid_email,
		'user[password]': valid_password,
		'user[password_confirmation]': valid_confirm_pass,
		'user[image]': valid_image
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
	$('#group_form').validate({
		debug: true,
		rules: {
		'group[name]': valid_text,
		'group[image]': valid_image
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
	$('#post_form').validate({
		debug: true,
		rules: {
		'post[title]': valid_text,
		'post[content]': valid_text,
		'post[image]': valid_image
		},
		submitHandler: function(form) { 
			if ($(form).valid()) form.submit(); return false; 
		}
	});
}
$(document).ready(validation);
$(document).on('page:load',validation);

function readFile(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('.image').attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}