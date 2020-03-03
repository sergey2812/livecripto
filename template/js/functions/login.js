function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}

$(document).on('readyCaptchaRegister', function () {
    let form = $('form.register');
    form.addClass('captcha-ready');
    disabledRegisterButton(form);
});
$(document).on('readyCaptchaLogin', function () {
    let form = $('form.login');
    form.addClass('captcha-ready');
    disabledRegisterButton(form);
});
$(document).on('readyCaptchaForgotten', function () {
    let form = $('form.foggoten');
    form.addClass('captcha-ready');
    disabledRegisterButton(form);
});

function disabledRegisterButton(form) {
    if (!form.hasClass('no-valid') && form.hasClass('captcha-ready') && validateForm(form)) {
        form.find('button[type="submit"]').prop('disabled', false);
    } else{
        form.find('button[type="submit"]').prop('disabled', true);
    }
}

function validateForm(form) {
    let isValid = true;
    form.find('input[required]').each(function() {
        if ($(this).val() === '') isValid = false;
    });
    return isValid;
}

$(function () {
    $('form.register input[name="email"], form.register input[name="login"], form.register input[name="form_sogl"]').on('keyup, change', function () {
        let valid = true;
        const input = $(this);
        const value = input.val();
        const form = $(this).closest('form');
        
        if ($(this).attr('type') !== 'checkbox' && (value === null || value === '' || value.length <= 3)) {
            valid = false;
        } else if ($(this).attr('name') === 'email' && !validateEmail(value)) {
            console.log('email', false);
            valid = false;
        } else if ($(this).attr('name') === 'login' && value.length > 10) {
            console.log('login', false);
            valid = false;
        } else if ($(this).attr('name') === 'form_sogl' && !$(this).is(':checked')) {
            console.log('form_sogl', false);
            valid = false;
        }

        if (valid) {
            if ($(this).attr('name') !== 'form_sogl') {
                $.ajax({
                    url: '/ajax/users/can_register.php',
                    type: 'POST',
                    dataType: 'json',
                    data: {value: value},
                })
                    .done(function(data) {
                        if (data.ok) {
                            input.removeAttr('style');
                            form.removeClass('no-valid');
                            disabledRegisterButton(form);
                        } else {
                            input.css('border', '1px solid red');
                            form.addClass('no-valid');
                            disabledRegisterButton(form);
                        }
                    })
                    .fail(function(data) {
                        console.log("error");
                    })
                    .always(function(data) {
                        console.log(data);
                    });
            } else{
                input.removeAttr('style');
                form.removeClass('no-valid');
                disabledRegisterButton(form);
            }
        } else{
            input.css('border', '1px solid red');
            form.addClass('no-valid');
            disabledRegisterButton(form);
        }
    });

    $('form.register input[name="password"], form.register input[name="password_2"]').on('keyup', function () {
        const inputs = $('form.register input[name="password"], form.register input[name="password_2"]');
        const form = $(this).closest('form');

        const pas1 = $('form.register input[name="password"]').val();
        const pas2 = $('form.register input[name="password_2"]').val();

        if (pas1 !== pas2 || pas1.length < 7 || !/[a-z]/.test(pas1) || !/[A-Z]/.test(pas1) || !/[!»№%:,.;()]/.test(pas1)) {
            inputs.css('border', '1px solid red');
            form.addClass('no-valid');
            disabledRegisterButton(form);
        } else{
            inputs.removeAttr('style');
            form.removeClass('no-valid');
            disabledRegisterButton(form);
        }
    });

    $('form.login input').on('keyup', function () {
        let valid = true;
        const input = $(this);
        const value = input.val();
        const form = $(this).closest('form');

        if (value === null || value === '' || value.length < 7) {
            valid = false;
        } else if ($(this).attr('name') === 'login' && !validateEmail(value)) {
            valid = false;
        } else if ($(this).attr('name') === 'password' && value.length < 3) {
            valid = false;
        }

        if (valid) {
            input.removeAttr('style');
            form.removeClass('no-valid');
        } else{
            input.css('border', '1px solid red');
            form.addClass('no-valid');
        }
        disabledRegisterButton(form);
    });

    $('form.foggoten input').on('keyup', function () {
        let valid = true;
        const input = $(this);
        const value = input.val();
        const form = $(this).closest('form');

        if (value === null || value === '' || value.length <= 3) {
            valid = false;
        } else if ($(this).attr('name') === 'login' && value.length < 3) {
            valid = false;
        } else if ($(this).attr('name') === 'email' && !validateEmail(value)) {
            valid = false;
        }

        if (valid) {
            input.removeAttr('style');
            form.removeClass('no-valid');
        } else{
            input.css('border', '1px solid red');
            form.addClass('no-valid');
        }
        disabledRegisterButton(form);
    });

    $('.login-fog_pass .open-forms').on('click', function () {
        $('#foggoten .login-popup_block:nth-child(2) li').addClass('active');
    })
});