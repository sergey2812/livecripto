{include file='admin/elements/header.tpl'}

<script>
$(function()
{
//    $('.crypto-image.notedit').empty();

    let crypto_img_real_file = $("input[name='crypto_img_real_file']").val();    

    if (crypto_img_real_file != '')
        {
            $('.crypto-image.notedit').append('<img src="{$template}/img/' + crypto_img_real_file + '">');
            $('.btn.btn-success.btn-lg').prop('disabled', false);
            $("input[name='inputfile']").prop('disabled', false);
            $("input[name='crypto_image_upload']").prop('disabled', false);
        }



    $("input[name='inputfile']").on('change', function () 
        { 
            let file_puth = $(this).val();
            let file_name = $(this)[0].files[0].name;

            $("input[name='crypto_img_file']").val(file_name);
            $("input[name='crypto_img_puth']").val(file_puth);
            $("input[name='name']").removeAttr('required');
            $("input[name='code']").removeAttr('required');
            $("input[name='wallets_address']").removeAttr('required');
//            $("input[name='bs_min_price']").removeAttr('required');
            
//alert($(this).val());                
        });        

    $("[data-tooltip]").mousemove(function (eventObject) {

        $data_tooltip = $(this).attr("data-tooltip");
        
        $("#tooltip").text($data_tooltip)
                     .css({ 
                         "top" : eventObject.pageY + 45,
                        "left" : eventObject.pageX - 25
                     })
                     .show();

    }).mouseout(function () {

        $("#tooltip").hide()
                     .text("")
                     .css({
                         "top" : 0,
                        "left" : 0
                     });
    });

    $("input[name='name']").on('change', function () 
        { 
            if (!isNaN($("input[name='name']").val()))  
                {
                    // It is a number
                    alert('В названии должны быть только буквы!');
                    $("input[name='name']").val('');
                }
            else
                {
                    let str = $("input[name='name']").val(); // Вoooooo

                    $("input[name='crypto_name']").val(str[0].toUpperCase() + str.slice(1));
                    $("input[name='name']").val(str[0].toUpperCase() + str.slice(1));
                }
            
        });    

    $("input[name='code']").on('change', function () 
        {
            let code_lower = $(this).val().toLowerCase();

            let code_upper = $(this).val().toUpperCase();

//            $('.crypto-image.notedit').empty();

//            $('.crypto-image.notedit').append('<img src="{$template}/img/' + code_lower + '.png">');

            $(this).val(code_upper);

            if (!isNaN($("input[name='code']").val()))  
                {
                    // It is a number
                    alert('В коде должны быть только буквы!');
                    $("input[name='code']").val('');
                }
            else
                {
                    $("input[name='crypto_code']").val($("input[name='code']").val());
                }            
        });

    $("input[name='wallets_address']").on('change', function () 
        { 
            var valid = !/\s/.test($("input[name='wallets_address']").val())

            if (!valid)  
                {
                    // It is a number
                    alert('В адресе НЕ должно быть пробелов!');
                    $("input[name='wallets_address']").val('');
                }
            else
                {
                    $("input[name='crypto_wallet']").val($("input[name='wallets_address']").val());
                    $("input[name='inputfile']").prop('disabled', false);
                    $("input[name='crypto_image_upload']").prop('disabled', false);
                }                
        });    

    $("input[name='bs_min_price']").keyup(function () 
        { 
            if (isNaN($("input[name='bs_min_price']").val())) 
                {
                    // It isn't a number
                    alert('В поле цены должны быть только цифры или пусто!');
                    $("input[name='bs_min_price']").val('0.0');
                    $("input[name='crypto_min_price']").val('0.0');               
                }
            else
                { 
                    $("input[name='crypto_min_price']").val($("input[name='bs_min_price']").val());
                }
        });

    $("input[name='bs_min_price']").on('change', function () 
        {
            $("input[name='crypto_min_price']").val($("input[name='bs_min_price']").val());
        });

});

</script>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div class="">
                <div class="bread">
                    <a href="#">ПУ</a> > <a href="#">Настройки</a> > <a href="#">Крипты</a> > <span>Создание / редактирование крипт</span>
                </div>
                <div class="page-title">
                    <h3>Создание / редактирование крипт</h3>
                </div>
                <div class="back_btn_wallet">
                        <a href="/admin/settings.php?type=wallets" class="btn btn-default btn-md">Вернуться назад, в список крипт</a>
                    </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <form method="POST" class="form-horizontal form-label-left">
                                    <table class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th colspan="3">Крипта</th>
                                        <th rowspan="2">Адрес кошелька</th>
                                        <th rowspan="2">Минимальная<br>цена для БС</th>   
                                    </tr>
                                    <tr>
                                        <th>Знак</th>
                                        <th class="name_new_col">Название</th>
                                        <th class="code_new_col">Код</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                    {if $edit_mode}
                                        <th class="crypto-image-col">
                                            <div class="crypto-image edit">
                                                <img src="{$template}/img/{if $edit_mode}{$crypto_row = $cryptos->GetCryptoById($crypto_id)}{mb_strtolower($crypto_row->getCode())}{/if}.png">
                                            </div>
                                        </th>
                                    {else}
                                        <th class="crypto-image-col">                        
                                        
                                            <div class="crypto-image notedit"></div>

                                        </th>
                                    {/if}
                                        <th>
                                            {if $edit_mode}                                            
                                                <div class="marketing-create__right wallets_new">
                                                    <input type="text" class="form-control" value="{if $edit_mode}{$crypto_row = $cryptos->GetCryptoById($crypto_id)}{$crypto_row->getName()}{/if}" name="name" placeholder="впишите название" data-tooltip="Впишите название крипты. Используйте только английские буквы. Начинайте с Заглавной буквы. Название может содержать 1-3 коротких слова. Пример названия: Bitcoin или Tether или Ethereum Classic и т.д." required>
                                                </div>
                                            {else}
                                                <div class="marketing-create__right wallets_new">
                                                    <input type="text" class="form-control" value="{if isset($crypto_name)}{$crypto_name}{/if}" name="name" placeholder="Пример:    Bitcoin" data-tooltip="Впишите название крипты. Используйте только английские буквы. Начинайте с Заглавной буквы. Название может содержать 1-3 коротких слова. Пример названия: Bitcoin или Tether или Ethereum Classic и т.д." required>
                                                </div>
                                            {/if}                                            
                                        </th>

                                        <th>
                                            <div class="marketing-create__right wallets_new">
                                                <input type="text" class="form-control" value="{if $edit_mode}{$crypto_row = $cryptos->GetCryptoById($crypto_id)}{$crypto_row->getCode()}{elseif isset($crypto_code) AND !$edit_mode}{$crypto_code}{/if}" name="code" placeholder="BTC" data-tooltip="Впишите код крипты. Код - это аббревиатура от названия. Код совпадает с названием файла с эмблемой крипты. При правильном указании кода Вы сразу увидите в первом поле таблицы значок крипты. Используйте только английские буквы верхнего регистра. Код должен быть непрерывным в виде одного короткого слова. Пример кода: BTC или USDT или XRP и т.д." required>
                                            </div>
                                        </th>

                                        <th class="wallets_new_col">
                                            <div class="marketing-create__right wallets_new">
                                                <input type="text" class="form-control" value="{if $edit_mode}{$crypto_row = $cryptos->GetCryptoById($crypto_id)}{$crypto_row->getWalletsAddress()}{elseif isset($crypto_wallet) AND !$edit_mode}{$crypto_wallet}{/if}" name="wallets_address" placeholder="Пример:   FGhj876fghjHGGF67fghFGH988769876" data-tooltip="Впишите адрес кошелька для данной крипты. Используйте цифры и буквы любого регистра. Адрес должен быть непрерывным в виде одной строки, то есть без пробелов. Пример адреса: FGhj876fghjHGGF67fghFGH9876KJHGcvbnm" required>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="marketing-create__right wallets_new">
                                                <input type="text" class="form-control" value="{if $edit_mode}{$crypto_row = $cryptos->GetCryptoById($crypto_id)}{$crypto_row->getBsMinPrice()}{elseif isset($crypto_min_price) AND !$edit_mode}{$crypto_min_price}{/if}" name="bs_min_price" placeholder="мин. цена для БС" data-tooltip="Впишите минимальную цену для Безопасной сделки. Используйте только цифры. Если нет ограничения, то впишите дробный ноль 0.0. Если значение дробное, то разделителем должна быть точка. Пример дробного: 0.25">
                                            </div>
                                        </th>   
                                        
                                    </tr>
                                        
                                    </tbody>
                                </table>
                                </form>
                                {if !$edit_mode}
                                <div class="crypto_upload_form">
                                    <form method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="function" value="upload">
                                        <input type="hidden" name="crypto_img_file" value=""> 
                                        <input type="hidden" name="crypto_img_puth" value="">
                                        <input type="hidden" name="crypto_img_real_file" value="{if $crypto_img_real_file != false}{$crypto_img_real_file}{/if}">
                                        <input type="hidden" name="crypto_name" value=""> 
                                        <input type="hidden" name="crypto_code" value="">
                                        <input type="hidden" name="crypto_wallet" value=""> 
                                        <input type="hidden" name="crypto_min_price" value="">

                                        <label class="crypto_upload_form_label">Выберите файл с эмблемой крипты</label>
                                        <input type="file" id="inputfile" name="inputfile" data-tooltip="Нажмите на эту кнопку и выберите файл с эмблемой крипты. После выбора файла загрузите его, нажав на кнопку ЗАГРУЗИТЬ." disabled="true"></br>
                                        <input name="crypto_image_upload" type="submit" value="Загрузить" data-tooltip="Выберите файл с эмблемой крипты, нажав на кнопку ОБЗОР. Затем, нажмите на эту кнопку для загрузки в систему выбранного файла с эмблемой крипты. После загрузки файла увидите в первом поле таблицы отображение эмблемы крипты. После отображения эмблемы крипты приступайте к заполнению полей таблицы!" disabled="true">
                                    </form>
                                </div> 
                                {/if}
                                <form method="POST" class="form-horizontal form-label-left">
                                    <input type="hidden" name="save_crypto_name" value="{if isset($crypto_name)}{$crypto_name}{/if}"> 
                                    <input type="hidden" name="save_crypto_code" value="{if isset($crypto_code)}{$crypto_code}{/if}">
                                    <input type="hidden" name="save_crypto_wallet" value="{if isset($crypto_wallet)}{$crypto_wallet}{/if}"> 
                                    <input type="hidden" name="save_crypto_min_price" value="{if isset($crypto_min_price)}{$crypto_min_price}{/if}">
                                    <div class="marketing-create__buttons">
                                        <button class="btn btn-success btn-lg" type="submit" disabled="true">Сохранить</button>
                                        
                                    </div>
                                </form>
                                
                                <input type="hidden" class="val_text" value="На данной странице отображаются все подкатегории объявлений на сайте. ">
                            </div>
                        </div>
                    </div>
                </div>    

            </div>
        </div>
    </div>
</div>
<div id="tooltip"></div>

{include file='admin/elements/footer.tpl'}