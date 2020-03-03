let recaptchaKey = '6LdbHqQUAAAAAKcAUzTuTpXco5C6tUSB6Zn7U0qJ';

function recaptchaLoaded() {
    $('.recaptcha-container').each(function () {
        let params = {
            sitekey: recaptchaKey
        };

        let callback = $(this).data('callback');
        if (callback !== undefined) params.callback = function () {
            $(document).trigger(callback)
        };

        let id = grecaptcha.render($(this)[0], params);
        $(this).data('id', id);
    });
}

$(function() {

    $('form:not(.no-ajax)').on('submit', function (event) {
        event.preventDefault();

        let valid = true;
        let hasCaptcha = false;
        const form = $(this);

        const url = form.attr('action');
        const method = form.attr('method');

        const button = form.find('button[type="submit"]');
        const button_text = button.text();

        const showAfterScreen = (form.hasClass('after-screen'));

        form.find('input[required], textarea.g-recaptcha-response').each(function () {
            if ($(this).val() === ''){
                $(this).css('border', '1px solid red');
                valid = false;
            }

            if ($(this).hasClass('g-recaptcha-response')) hasCaptcha = true;
        });

        if ($(this).hasClass('no-valid')) {
            valid = false;
        }

        if (valid) {
            $.ajax({
                url: url,
                method: method,
                dataType: 'json',
                data: form.serialize(),
                beforeSend: function () {
                    form.find('input:visible').attr('disabled', '');
                    button.text(glossary.main[4]);
                }
            }).done(function (data) {

                if (data.ok !== undefined && data.ok === true) {
                    if (data.redirect !== undefined){
                        location.href = data.redirect;
                    } else if (data.reload === true) {
                        if (data.result.new_advert_id !== undefined) {
                            location.href = '/advert.php?id=' + data.result.new_advert_id;
                        } else{
                            location.reload();
                        }
                    } else if (showAfterScreen) {
                        form.fadeOut(300, function () {
                            form.next().fadeIn(300);
                        })
                    }
                } else{
                    if (data.error !== undefined){
                        alert(data.error);
                    } else{
                        alert(glossary.functions.ajax_forms[0]);
                    }
                    if (hasCaptcha) {
                        grecaptcha.reset(form.find('.recaptcha-container').data('id'));
                        form.removeClass('captcha-ready');
                        form.find('button[type="submit"]').prop('disabled', true);
                    }
                }

                console.log(data);

            }).fail(function (data) {

                alert(glossary.functions.ajax_forms[1]);
                console.log(data);

            }).always(function (data) {

                form.find('input:visible').removeAttr('disabled');
                button.text(button_text);

                console.log(data);
            });
        }
    });
});