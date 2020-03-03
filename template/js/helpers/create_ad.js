let map;

function initMapSelector() {
    map = new google.maps.Map(document.getElementById('map-selector'), {
        center: {lat: -34.397, lng: 150.644},
        zoom: 8
    });
}

function validateForm(form) {
    let isValid = true;
    form.find('input[required]').each(function() {
        if ($(this).val() === '') {
            isValid = false;
        }
    });
    return isValid;
}

$(function () {
    const fromEdit = $('form.add-object.edit_mode');
    fromEdit.find('input, select, textarea').on('change', function () {
        if (validateForm(fromEdit)) {
            $('button.btn-add').prop('disabled', false);
        } else{
            $('button.btn-add').prop('disabled', true)
        }
    });
    fromEdit.find('select.add_obj_select_crypto').each(function () {
        $(this).trigger('change');
    });
    fromEdit.find("button[type='submit']").prop('disabled', true);

    let nextStep = 1;
    const form = $('form.add-object:not(.edit_mode)');

    $(".wallet").on('keyup', function (event) {
        let val = $(this).val();        
        val = val.split('.');
        if (val.length > 1) {
            if (val[1].length > 8) {
                $(this).val(val[0] + '.' + val[1].slice(0, 8));
            }
        }        
    });

    form.find('input, select, textarea').each(function (i) {
        if ($(this).attr('name') !== 'photos' && $(this).attr('name') !== 'prices') {
            if (i !== 2) {
                $(this).closest('.form-row').addClass('blocked');
                $(this).prop('disabled', true);
            }
        }
    });

    form.find('input, select, textarea').on('change', function () {

        console.log('Changed', $(this).find('option:selected').text());

        if ($(this).val() !== null && $(this).val() !== '') {
            let step = parseInt($(this).closest('.form-row').data('step'));
            step += 1;
            nextStep = step;

            const nextStepDiv = $('.form-row[data-step="'+step+'"]');

            nextStepDiv.removeClass('blocked').find('input, select, textarea').prop('disabled', false);

            /*if (step === 7 || step === 9) {
                nextStepDiv.find('option:first').remove();
                nextStepDiv.find('select').prepend('<option value="" selected disabled>' + glossary.functions.get_categories[1] + '</option>');
            }*/
            
        }


    });

//    form.find('.photos-block > div input[type="file"]').on('change', function () {
//        if ($(this).val() !== '') {
//            $(this).closest('div').next('div').removeClass('blocked').addClass('active');
//        }
//    });

    $('.form-row.val-block.val-select input').on('keyup', function () {
        let value = $(this).val();

        if (value !== '') $(this).closest('div.form-row').next('.form-row').removeClass('blocked').find('select, input').prop('disabled', false);
    });


    // $(".required-field").on('change', function () {
    //     let valid = true;
    //
    //     $(".required-field").each(function () {
    //         if ($(this).val() === '' || $(this).val() === null) {
    //             valid = false;
    //             if (!$(this).prop('disabled') && $(this).closest('[data-step]').data('step') != nextStep) {
    //                 $(this).addClass('wrong-field');
    //             }
    //         } else{
    //             $(this).removeClass('wrong-field');
    //         }
    //         console.log('CHANGED:');
    //         console.log($(this));
    //         console.log('CHANGED VALUE:');
    //         console.log($(this).val());
    //         console.log('///');
    //     });
    //
    //     const button = form.find("button[type='submit']");
    //     const button2 = fromEdit.find("button[type='submit']");
    //
    //     if (valid) {
    //         console.log('VALID!!!!!!!!!');
    //         button.prop('disabled', false);
    //         button2.prop('disabled', false);
    //     } else{
    //         console.log('!!!!!!!!inVALID!!!!!!!!!');
    //         button.prop('disabled', true);
    //         button2.prop('disabled', true);
    //     }
    // });

    $('select[name="without_location"]').on('change', function() {
        if ($(this).val() === '0') {
            $('select[name="location"]').addClass('required-field');
        } else {
            $('select[name="location"]').removeClass('required-field');
        }
    });

    $('select[name="location"]').on('change', function() {
        if ($(this).val() > '0') {
            $('select[name="location_name"]').addClass('required-field');
        } else {
            $('select[name="location_name"]').removeClass('required-field');
        }
    });


    $('.required-field').on('change', function() {
       let valid = true;
       let val;
       let th;

       $('.required-field').each(function() {
           th = $(this);
           if (!th.hasClass('wallet_type')) {
               if (th.prop('name') === 'secure_deal' || th.prop('name') === 'without_location' || th.prop('name') === 'location' || th.prop('name') === 'location_name') {
                   if (th.val() === '' || th.val() === null) {
                       valid = false;
                   }
               } else {
                   if (th.val() === '' || th.val() === null || th.val() === '0') {
                       valid = false;
                   }
               }
           }
           if (valid) {
               $('.add-object').find('button[type="submit"]').prop('disabled', false);
           } else {
               $('.add-object').find('button[type="submit"]').prop('disabled', true);
           }
       });
    });
});