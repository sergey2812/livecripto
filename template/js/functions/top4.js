$(function()
{
    let price_massive = {};
    let crypto_code = '';
    let crypto_price = '';

    let clients_wallets_top4_prices = {};

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

    let position_top = 0; 
    let page_top = 0;
    let nm_days = 0;   

    let top_client_update = '';

    const params = new Map(location.search.slice(1).split('&').map(kv => kv.split('=')))
    var abc = params.has('adverts');
    if (abc == true)
        {
            var adverts = params.get('adverts');
            if (adverts == 'all')
                {
                    alert("Ваша заявка отправлена администратору! В течение суток на Вашу почту придет уведомление о решении администратора о размещении Вашего объявления в ТОП");
                    history.pushState(null, null, '/dashboard.php?page=my_adverts');
                }
            if (adverts == 'has')
                {
                    alert("Такая заявка уже была отправлена администратору ранее! Для новой заявки измените параметры или дождитесь уведомления администратора!");
                    history.pushState(null, null, '/dashboard.php?page=my_adverts');
                }
        }

    $("li a.open-forms.top").on('click', function () 
        {
            
            $('button.btn-submit.open-forms.top').prop('disabled', true);

            $(document).on('readyCaptchaTop4', function () {
                let form = $('form#top4');
                form.addClass('captcha-ready');

                if (form.hasClass('captcha-ready')) {
                    form.find('button.btn-submit.open-forms.top').prop('disabled', false);
                } else{
                    form.find('button.btn-submit.open-forms.top').prop('disabled', true);
                }
            });

            id_advert = $(this).data('advert-id');
            id_country = $(this).data('country-id');
            id_city = $(this).data('city-id');

            $("input[name='top_advert_id']").val(id_advert);
            $("input[name='top_country_id']").val(id_country);
            $("input[name='top_city_id']").val(id_city);
            
            $("input[name='top_client_country_id']").val(id_country);
            $("input[name='top_client_city_id']").val(id_city);             

            active_section_id = $(this).data('section-id'); 
            active_category_id = $(this).data('category-id');
            active_subcategory_id = $(this).data('subcategory-id');                     

            $("input[name='top_section_id']").val(active_section_id);
            $("input[name='top_category_id']").val(active_category_id);
            $("input[name='top_subcategory_id']").val(active_subcategory_id);

            $("input[name='top_client_section_id']").val(active_section_id);
            $("input[name='top_client_category_id']").val(active_category_id);
            $("input[name='top_client_subcategory_id']").val(active_subcategory_id);
            
            $(".per-popup_t").html('Оплата за размещение в ТОП');
            $("#per").attr("action", "/ajax/top4/clients_data_top4_to_db.php");

            $("select[name='nm_day']").empty();
            $("select[name='nm_day']").append('<option value="0" disabled selected>Не выбрано</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="5">5</option><option value="10">10</option><option value="15">15</option><option value="30">30</option>');

            $("select[name='str']").empty();
            $("select[name='str']").append('<option value="0" disabled selected>Не выбрано</option><option value="1">Главная Весь Мир</option><option value="2">Главная по стране</option><option value="3">Главная по городу</option>');

            $("select[name='top4']").empty();
            $("select[name='top4']").append('<option value="0" disabled selected>Не выбрано</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>'); 

            $("select[name='nm_day'] option[value='0']").attr("selected", "selected");
            $("select[name='str'] option[value='0']").attr("selected", "selected");
            $("select[name='top4'] option[value='0']").attr("selected", "selected");

            $("select[name='str']").attr("disabled", true);
            $("select[name='top4']").attr("disabled", true);            
           
        }); 

    $("select[name='section']").on('change', function () 
        {            
            $("select[name='category']").attr("disabled", false); 
            $("select[name='category']").removeClass('blocked');
            $("select[name='subcategory']").addClass('blocked'); 
            $("select[name='subcategory']").attr("disabled", true);

            if ($(this).find('option:selected').val() == '') 
                {
                    $("select[name='category']").append('<option value="" selected>Не выбрано</option>');

                    active_section_id = 0;                     

                    $("input[name='top_section_id']").val(active_section_id);

                    $("input[name='top_client_section_id']").val(active_section_id);                    
                }
            else
                {
                    active_section_id = $(this).find('option:selected').val();                     

                    $("input[name='top_section_id']").val(active_section_id);

                    $("input[name='top_client_section_id']").val(active_section_id);                    
                }

            active_category_id = 0;                     

            $("input[name='top_category_id']").val(active_category_id);

            $("input[name='top_client_category_id']").val(active_category_id);

            active_subcategory_id = 0;                     

            $("input[name='top_subcategory_id']").val(active_subcategory_id);

            $("input[name='top_client_subcategory_id']").val(active_subcategory_id); 

        });    

    $("select[name='category']").on('change', function () 
        {            
            $("select[name='subcategory']").attr("disabled", false); 
            $("select[name='subcategory']").removeClass('blocked');     

            active_category_id = $(this).find('option:selected').val();                     

            $("input[name='top_category_id']").val(active_category_id);

            $("input[name='top_client_category_id']").val(active_category_id);

            active_subcategory_id = 0;                     

            $("input[name='top_subcategory_id']").val(active_subcategory_id);

            $("input[name='top_client_subcategory_id']").val(active_subcategory_id); 

        }); 

    $("select[name='subcategory']").on('change', function () 
        {            
            active_subcategory_id = $(this).find('option:selected').val();                     

            $("input[name='top_subcategory_id']").val(active_subcategory_id);

            $("input[name='top_client_subcategory_id']").val(active_subcategory_id);                    
        });

    $("select[name='nm_day']").on('change', function () 
        {            
            nm_days = $(this).find('option:selected').val();
            $("input[name='top_days_num']").val(nm_days);
            $("input[name='top_client_days_num']").val(nm_days);
  
            $("select[name='str']").empty();
            $("select[name='str']").append('<option value="0" disabled selected>Не выбрано</option><option value="1">Главная Весь Мир</option><option value="2">Главная по стране</option><option value="3">Главная по городу</option>');

            $("select[name='top4']").empty();
            $("select[name='top4']").append('<option value="0" disabled selected>Не выбрано</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>'); 

            $("select[name='str']").attr("disabled", false); 
            $("select[name='top4']").attr("disabled", true);         
        });

    $("select[name='str']").on('change', function () 
        {            
            page_top = $(this).find('option:selected').val();
            $("input[name='top_page_type']").val(page_top);
            $("input[name='top_client_page_type']").val(page_top);

            $("select[name='top4']").empty();
            $("select[name='top4']").append('<option value="0" disabled selected>Не выбрано</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>');

            $("select[name='top4']").attr("disabled", false);           
        });

    $("select[name='top4']").on('change', function () 
        {            
            position_top = $(this).find('option:selected').val();
            $("input[name='top_position_num']").val(position_top);
            $("input[name='top_client_position_num']").val(position_top);

// здесь д.б. код получения цен за размещение в ТОП, вычисления стоимости за Х дней и помещения результата в скрытый input
            if (page_top == 3)
                {                    
                    id_city = $("input[name='top_city_id']").val();
                    $("input[name='top_client_city_id']").val(id_city);
                }
            else
                {                   
                    id_city = 0;
                    $("input[name='top_client_city_id']").val(id_city);
                }
            if (page_top == 1)
                {                  
                    id_country = $("input[name='top_world_id']").val();
                    $("input[name='top_client_country_id']").val(id_country);
                }
            else
                {                   
                    id_country = $("input[name='top_country_id']").val();
                    $("input[name='top_client_country_id']").val(id_country);
                }

            $.ajax({
                url: '/ajax/sections/get_top4_prices.php',
                type: 'POST',
                dataType: 'JSON',
                data: { active_section_id: active_section_id, active_category_id: active_category_id, active_subcategory_id: active_subcategory_id, id_country: id_country, id_city: id_city, position_top: position_top },
            })
                .done(function(data) 
                {
                    console.log("success");
                 
                    $.each(data, function( key, value ) 
                        {
                            var calculate = data[key]*nm_days;
                            data[key] = calculate;                            
                        });
                    $('input[name="top_calculate_price"]').val(JSON.stringify(data));
                    $('.per-popup_right input[name="top_calculate_price"]').val(JSON.stringify(data));
                })
                    .fail(function() 
                    {
                        console.log("error");
                        data = [];
                        $('input[name="top_calculate_price"]').val(JSON.stringify(data));
                        $('.per-popup_right input[name="top_calculate_price"]').val(JSON.stringify(data));
                        alert('ЦЕН по указанным параметрам в БД НЕТ!');
                        $("button.btn-submit.open-forms.top").attr("disabled", true);
                    })
                    .always(function() 
                    {
                        console.log("complete");
                    }); 
            
        }); 


    $('button.btn-submit.open-forms.top').on('click', function () 
        {
            var wallet_price = JSON.parse($('input[name="top_calculate_price"]').val());

            var crypto_type = '';
            var crypto_price = 0;

            $.each(wallet_price, function( key, value ) 
                {
                    $("li a.select-payment-wallet.secure-deal").each(function() {

                        crypto_type = $(this).data('type');
                        crypto_price = $(this).find('span.calculate_price_top');

                        if (crypto_type == key)
                            {
                                crypto_price.text(wallet_price[key]);

                                clients_wallets_top4_prices[key] = wallet_price[key];
                                
                                $('input[name="clients_wallets_top4_prices"]').val(JSON.stringify(clients_wallets_top4_prices));
                            }
                    });      
                });
                    
        });


    $("li a.select-payment-wallet.secure-deal").on('click', function () 
        {
            var buyer_wallet_address = $(this).data('buyer-wallet');
            var service_wallet_address = $(this).data('service-wallet');
            id_user = $("input[name='top_user_id']").val();  
            top_client_update = $("input[name='top_client_update']").val();

            var wallet_price = JSON.parse($('input[name="clients_wallets_top4_prices"]').val());

            var crypto_type = $(this).data('type');

            var clients_pay = {};

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

            $('button.btn-submit.pay_is_over.secure-deal').prop('disabled', true);

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