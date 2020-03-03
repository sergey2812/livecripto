$(function () {

    $.validateForm = function(form) {
        let valid = true;

        form.find('input:required, textarea.g-recaptcha-response').each(function() {
            if ($(this).val() === '') {
                valid = true;
            }
        });

        return valid;
    };

});