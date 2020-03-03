let wallets = {};

$(document).ready(function () {
    let passwordBlock = $('.lk-config_pass');

    function updateWallets(){
        let walletsInput = $('input[name="wallets"]');

        $('.wallet').each(function () {
            let wallet = $(this).find('p').text();
            let type = $(this).find('.delete').data('type');
            if (wallet !== '') {
                wallets[type.toLocaleLowerCase()] = wallet;
            }
        });

        $('input[name="config_purse_input"]').each(function () {
            let wallet = $(this).val();
            let type = $(this).closest('.lk-config_purse').find('select[name="config_purse"]').val();

            if (type != '0') {
                wallets[type.toLocaleLowerCase()] = wallet;
            }
        });

        walletsInput.val(JSON.stringify(wallets));

        if (Object.keys(wallets).length > 0 && wallets.constructor === Object) {
            passwordBlock.removeClass('disabled').addClass('error');
            if ($('input[name="password"]').val().length > 3) {
                passwordBlock.removeClass('error');
            }
        }

        console.log(wallets);
    }

    $('input[name="password"]').on('keyup', function () {
        if ($(this).val().length > 3) {
            passwordBlock.removeClass('error');
        } else{
            passwordBlock.addClass('error');
        }
    });

    $('input[name="config_purse_input"]').on('keyup', function () {
        let val = $(this).val();
        let alreadyAdded = $(this).data('added');

        if (val !== '' && alreadyAdded !== true) {
            $(this).closest('.lk-config_purse').next().css('display', 'block');

            $(this).data('added', true);
        }

        updateWallets();
    });

    $('.wallet .delete').on('click', function () {
        let type = $(this).data('type');
        delete wallets[type];

        $(this).closest('.wallet').remove();

        const optionType = type.toLocaleUpperCase();
        const optionText = allWallets[optionType];
        $('.lk-config_purse select').each(function () {
            $(this).append('<option value="'+optionType+'" data-image="/template/img/'+type+'.png">'+optionText+'</option>');
        });

        updateWallets();
    })

});