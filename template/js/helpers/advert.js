$(document).ready(function () {

    let modal = $("#success");

    $(".open-forms[href='#success']").on('click', function (e) {

        let type = $(this).data('type');
        let price = $(this).closest('.product-price_item').find('span').text();
        price = parseInt(price);
        let buyer_wallet = user_wallets[type];

        let qr_code = GetQRCode(type, buyer_wallet, price);

        if (buyer_wallet === undefined) {
            e.preventDefault();
            alert(glossary.helpers[0] + ' ' + type.toUpperCase() + ' ' + glossary.helpers[1]);
            location.reload();
        } else{
            modal.find('.modal_item_price').html(price + ' ' + type.toUpperCase());
            modal.find('.modal_author_wallet').html(author_wallets[type]);
            modal.find('.modal_buyer_wallet').html(buyer_wallet);
            modal.find('.modal_buyer_wallet_input').val(buyer_wallet);
            modal.find('.modal_buyer_type_input').val(type);
            modal.find('.qr_code_image').attr('src', qr_code);
        }
    });

    function GetQRCode(type, wallet, amount){
        let link = 'https://chart.googleapis.com/chart?cht=qr&chs=198x198&chld=M|0&chl=';

        if (type === 'btc') {
            link += 'bitcoin:' + wallet + '?amount=' + amount;
        } else if(type === 'eth') {
            link += 'ethereum:' + wallet + '?value=' + amount;
        } else if(type === 'ltc') {
            link += 'litecoin:' + wallet + '?value=' + amount;
        } else{
            link += 'https://ripple.com//send?to=' + wallet + '&amount=' + amount;
        }

        return link;
    }

});