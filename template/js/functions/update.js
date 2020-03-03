$(function()
{
    let price_massive = {};
    let crypto_code = '';
    let crypto_price = '';

    let id_country = 0;
    let id_city = '';
    let id_advert = 0;
    let id_user = 0;

    let active_section_id = 0;
    let active_category_id = 0;
    let active_subcategory_id = 0;    

    let active_section_name = '';
    let active_category_name = '';
    let active_subcategory_name = '';   

    const params = new Map(location.search.slice(1).split('&').map(kv => kv.split('=')))
    var abc = params.has('adverts');
    if (abc == true)
        {
            var adverts = params.get('adverts');
            if (adverts == 'all')
                {
                    alert("Ваша заявка отправлена администратору! В течение суток на Вашу почту придет уведомление о решении администратора по обновлению Вашего объявления в системе");
                    history.pushState(null, null, '/dashboard.php?page=my_adverts');
                }
            if (adverts == 'has')
                {
                    alert("Такая заявка уже была отправлена администратору ранее! Для новой заявки измените параметры или дождитесь уведомления администратора!");
                    history.pushState(null, null, '/dashboard.php?page=my_adverts');
                }
        }

    $("li a.open-forms.update").on('click', function () 
        {
            $('button.btn-submit.open-forms.update').prop('disabled', true);

            id_advert = $(this).data('advert-id');

            id_country = $(this).data('country-id');
            id_city = $(this).data('city-id');
            

            active_section_id = $(this).data('section-id'); 
            active_category_id = $(this).data('category-id');
            active_subcategory_id = $(this).data('subcategory-id');          
            
            active_section_name = $(this).data('section-name'); 
            active_category_name = $(this).data('category-name');
            active_subcategory_name = $(this).data('subcategory-name');

            $("div span.section").html(active_section_name);
            $("div span.category").html(active_category_name);
            $("div span.subcategory").html(active_subcategory_name);

            $("input[name='top_advert_id']").val(id_advert);
            $("input[name='top_client_country_id']").val(id_country);
            $("input[name='top_client_city_id']").val(id_city);
            $("input[name='top_client_section_id']").val(active_section_id);
            $("input[name='top_client_category_id']").val(active_category_id);
            $("input[name='top_client_subcategory_id']").val(active_subcategory_id);

            $(".per-popup_t").html('Оплата за обновление');
            $("#per").attr("action", "/ajax/top4/clients_data_update_to_db.php");

// здесь код получения цен за обновление, и помещения результата в скрытый input

            $.ajax({
                url: '/ajax/sections/get_update_prices.php',
                type: 'POST',
                dataType: 'JSON',
                data: { active_section_id: active_section_id, active_category_id: active_category_id, active_subcategory_id: active_subcategory_id, id_country: id_country, id_city: id_city },
            })
                .done(function(data) 
                {
                    console.log("success");
                 
                    $('input[name="top_calculate_price"]').val(JSON.stringify(data));

                    let crypto_type = '';
                    let crypto_price = 0;

                    let clients_update_prices = {};

                    $.each(data, function( key, value ) 
                        {
                            
                            $("li a.select-payment-wallet.secure-deal").each(function() {

                                crypto_type = $(this).data('type');
                                crypto_price = $(this).find('span.calculate_price_top');

                                if (crypto_type == key)
                                    {
                                        crypto_price.text(data[key]);

                                        clients_update_prices[key] = data[key];
                                        $('input[name="clients_wallets_top4_prices"]').val(JSON.stringify(clients_update_prices));
                                    } 
                            });     
                        });
                })
                    .fail(function() 
                    {
                        console.log("error");
                        data = [];
                        $('input[name="top_calculate_price"]').val(JSON.stringify(data));
                        alert('ЦЕН по указанным параметрам в БД НЕТ!');
                        $("button.btn-submit.open-forms.update").attr("disabled", true);
                    })
                    .always(function() 
                    {
                        console.log("complete");
                    }); 

            $(document).on('readyCaptchaUpdate', function () {
                let form = $('#update');
                form.addClass('captcha-ready');

                if (form.hasClass('captcha-ready')) {
                    form.find('button.btn-submit.open-forms.update').prop('disabled', false);
                } else{
                    form.find('button.btn-submit.open-forms.update').prop('disabled', true);
                }
            });
          
        });  

    $("li a.select-payment-wallet.secure-deal").on('click', function () 
        {
           
            let buyer_wallet_address = $(this).data('buyer-wallet');
            let service_wallet_address = $(this).data('service-wallet');
            id_user = $("input[name='top_user_id']").val();  

            let wallet_price = JSON.parse($('input[name="clients_wallets_top4_prices"]').val());

            let crypto_type = $(this).data('type');

            let clients_pay = {};

            $.each(wallet_price, function( key, value ) 
                {
                        if (crypto_type == key)
                            {                               
                                clients_pay[key] = wallet_price[key];

                                $('input[name="clients_pay_sum"]').val(wallet_price[key]);

                                $('input[name="clients_crypto_code"]').val(key.toLowerCase());                                
                                
                                $('input[name="top_calculate_price"]').val(JSON.stringify(clients_pay));
                            }      
                });                        

            $("input.buyer_wallet").val(buyer_wallet_address);
            $("input.service_wallet").val(service_wallet_address);

            $('input[name="clients_wallet_address"]').val(buyer_wallet_address);
            $('input[name="admins_wallet_address"]').val(service_wallet_address);
            
            $('.qr_code').attr('src', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chld=L|0&chl=' + service_wallet_address);

            $(document).on('readyCaptchaTop4Client', function () {
                let form = $('form#per');
                form.addClass('captcha-ready');

                if (form.hasClass('captcha-ready')) {
                    form.find('button.btn-submit.pay_is_over.secure-deal').prop('disabled', false);
                } else{
                    form.find('button.btn-submit.pay_is_over.secure-deal').prop('disabled', true);
                }
            });

        });

    $('#save').on('click', function() {
        var $tmp = $("<input>");
        $("body").append($tmp);
        $tmp.val($("#text1").val()).select();
        document.execCommand("copy");
        $tmp.remove();
        alert('Скопировано!');                
    }); 

});