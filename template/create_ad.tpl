{include file='elements/main/header.tpl'}

<script src="{$template}/js/functions/upload_image.js"></script>
<script src="{$template}/js/functions/get_categories.js"></script>
{* <script src="{$template}/js/functions/wallets_json.js"></script> *}
<script src="{$template}/js/helpers/create_ad.js"></script>
{* <script src="{$template}/js/helpers/city_ad.js"></script> *}

<script>
    $(function ()
    {
        $("[data-tooltip]").mousemove(function (eventObject) {

            $data_tooltip = $(this).attr("data-tooltip");
            
            $("#tooltip-new").text($data_tooltip)
                         .css({ 
                             "top" : eventObject.pageY + 45,
                            "left" : eventObject.pageX - 25
                         })
                         .show();

        }).mouseout(function () {

            $("#tooltip-new").hide()
                         .text("")
                         .css({
                             "top" : 0,
                            "left" : 0
                         });
        });
    });
</script>

{if $edit_mode}
    <script>
    $(function () 
    {  
        const userWallets = [{foreach from=$user->getWallets() item=$wallet key=$type}'{$type}', {/foreach}];
        // кошельки в системе полный список
        const allWallets = {
            {foreach from=$currencies item=$cur}
                '{$cur['code']}': '{$cur['name']}',
            {/foreach}
        };
        const allWallets_name_min = {
            {foreach from=$all_cryptos item=$cur}
                '{$cur['code']}': '{$cur['bs_min_price']}',
            {/foreach}
        };

        // кошельки в системе список без нулевых кошельков
        const allWallets_without = {
            {foreach from=$all_cryptos_bs item=$cur}
                '{$cur['code']}': '{$cur['name']}',
            {/foreach}
        };
        const allWallets_name_min_without = {
            {foreach from=$all_cryptos_bs item=$cur}
                '{$cur['code']}': '{$cur['bs_min_price']}',
            {/foreach}
        };

        let wallets = {};
        let option_list = [];
        
        let edit_bs_selects_val = []; 
        let edit_bs_selects_data = []; 
        let edit_bs_selects_text = []; 
        let edit_bs_selects_min_price = [];

        let edit_bs_selects_val_min = [];
        let edit_bs_selects_data_min = [];
        let edit_bs_selects_text_min = [];
        let edit_bs_selects_min_price_min = [];

        let edit_ps_selects_val_min = [];
        let edit_ps_selects_data_min = [];
        let edit_ps_selects_text_min = [];
        let edit_ps_selects_min_price_min = [];               

        let edit_2ps_selects_val_min = [];
        let edit_2ps_selects_data_min = [];
        let edit_2ps_selects_text_min = [];
        let edit_2ps_selects_min_price_min = [];        

        let tresh_ps_selects_val = []; 
        let tresh_ps_selects_data = []; 
        let tresh_ps_selects_text = []; 
        let tresh_ps_selects_min_price = []; 

        let edit_ps_selects_val = []; 
        let edit_ps_selects_data = []; 
        let edit_ps_selects_text = []; 
        let edit_ps_selects_min_price = [];

        let edit_history_selects_val = []; 
        let edit_history_selects_data = []; 
        let edit_history_selects_text = [];                            
        let edit_history_selects_min_price = [];

        let edit_ps_to_bs_code = [];
        let edit_ps_to_bs_name = [];
        let edit_ps_to_bs_min_price = [];        

        let num_current = 0;

        let deal_type = 0;

        if ($("input[name='photos']").val() !== "")
            {
                wallets = JSON.parse($("input[name='prices']").val());
                console.log(wallets);
            }

        $(".wallet_type").val();

        $("input.wallet").keyup(function () 
            {
                UpdateWalletObject();
            });

        function UpdateWalletObject() 
        {
            wallets = {};

            $('.wallet').each(function () 
                {
                    const input = $(this);
                    let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                    if (wallet_type != '' && wallet_type != '0') 
                        {
                            wallets[wallet_type] = input.val();

                            $('input[name="prices"]').val(JSON.stringify(wallets));
                        }
                });

            console.log(wallets);
        }

        let secure_deal_selector = $('select[name="secure_deal"]');
        let crypto_selector = $('select[name="add_obj_select_crypto"]');
        let size = $('select[name="add_obj_select_crypto"]').size();
        deal_type = $('select[name="secure_deal"]').val();       

        crypto_selector.each(function () 
            {
                let crypto_id = $(this).attr('id');
                num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                if (deal_type == 1) 
                    {
                        $(this).closest('.form-row').find('input.wallet').attr('data-secure-deal', 1);
                    } 
                else
                    {
                        $(this).closest('.form-row').find('input.wallet').attr('data-secure-deal', 0);
                    }                
                
                let selected_val = $(this).find('option:selected').val();

                if (selected_val != 0)
                    {
                        $(this).prop("disabled", true);
                    }
                else
                    {
                        $(this).closest('.form-row').next().find('select').prop('disabled', true);
                        $(this).closest('.form-row').next().addClass('blocked'); 
                    }   

                $(this).find('option').each(function () 
                    {
                        let value = $(this).attr('value');

                        if (deal_type !== '1') 
                            {
                                let found = false;

                                $.each(userWallets, function (index, type) {

                                    if (type.toLocaleUpperCase() == value) found = true;
                                });

                                if (!found) 
                                {
                                    if($(this).val() != 0)
                                        {                                                           
                                            if (!tresh_ps_selects_val.includes($(this).val())) 
                                                {
                                                    tresh_ps_selects_val.push($(this).val());
                                                    tresh_ps_selects_data.push($(this).data('image'));
                                                    tresh_ps_selects_text.push($(this).text());
                                                    tresh_ps_selects_min_price.push($(this).data('min-price'));
                                                }

                                            $(this).remove();  // .prop('disabled', true);
                                        }
                                } 
                                else
                                {                                
                                    if($(this).val() == selected_val)
                                        {                                                         
                                            if (!edit_ps_selects_val.includes($(this).val())) 
                                                {
                                                    edit_ps_selects_val.push($(this).val());
                                                    edit_ps_selects_data.push($(this).data('image'));
                                                    edit_ps_selects_text.push($(this).text());
                                                    edit_ps_selects_min_price.push($(this).data('min-price'));

                                                    edit_history_selects_val.push($(this).val());
                                                    edit_history_selects_data.push($(this).data('image'));
                                                    edit_history_selects_text.push($(this).text());
                                                    edit_history_selects_min_price.push($(this).data('min-price'));
                                                }

                                            for (let i = num_current; i < size; i++)  
                                                {
                                                    $('#crypto_' + (i) + '').closest('.form-row').next().find('select option[value="'+selected_val+'"]').remove(); 
                                                }
                                        }

                                    if ($(this).data('min-price') == 0)
                                        {                                           
                                            if (!edit_ps_selects_val_min.includes($(this).val())) 
                                                {
                                                    edit_ps_selects_val_min.push($(this).val());
                                                    edit_ps_selects_data_min.push($(this).data('image'));
                                                    edit_ps_selects_text_min.push($(this).text());
                                                    edit_ps_selects_min_price_min.push($(this).data('min-price'));

                                                    edit_2ps_selects_val_min.push($(this).val());
                                                    edit_2ps_selects_data_min.push($(this).data('image'));
                                                    edit_2ps_selects_text_min.push($(this).text());
                                                    edit_2ps_selects_min_price_min.push($(this).data('min-price'));
                                                }
                                        }
                                }
                            } 
                        else
                            {
                                if($(this).val() == selected_val && $(this).val() != 0)
                                    {                                                         
                                        if (!edit_bs_selects_val.includes($(this).val())) 
                                            {
                                                edit_bs_selects_val.push($(this).val());
                                                edit_bs_selects_data.push($(this).data('image'));
                                                edit_bs_selects_text.push($(this).text());
                                                edit_bs_selects_min_price.push($(this).data('min-price'));

                                                edit_history_selects_val.push($(this).val());
                                                edit_history_selects_data.push($(this).data('image'));
                                                edit_history_selects_text.push($(this).text());
                                                edit_history_selects_min_price.push($(this).data('min-price'));
                                            }
                                // удаляем крипты выбранные при размещении объявления
                                        for (let i = num_current; i < size; i++)  
                                            {
                                                $('#crypto_' + (i) + '').closest('.form-row').next().find('select option[value="'+selected_val+'"]').remove(); 
                                            }
                                    }
                                // удаляем крипты с нулевыми кошельками
                                if ($(this).data('min-price') == 0)
                                    {
                                        if (!edit_bs_selects_val_min.includes($(this).val())) 
                                            {
                                                edit_bs_selects_val_min.push($(this).val());
                                                edit_bs_selects_data_min.push($(this).data('image'));
                                                edit_bs_selects_text_min.push($(this).text());
                                                edit_bs_selects_min_price_min.push($(this).data('min-price'));
                                            }
                                        $(this).remove();
                                    }                                                  
                            }                                
                    });
            }); 

        $('input[name="price_0"]').on('blur', function () 
            {
                const input = $('input[name="price_0"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[0]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_1"]').on('blur', function () 
            {
                const input = $('input[name="price_1"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[1]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_2"]').on('blur', function () 
            {
                const input = $('input[name="price_2"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[2]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_3"]').on('blur', function () 
            {
                const input = $('input[name="price_3"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[3]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });                                                         

        $('select[name="secure_deal"]').on('change', function () 
            {               
                let selectors = $('select[name="add_obj_select_crypto"]');
                wallets = {};
                $('input[name="prices"]').val(JSON.stringify(wallets));
                num_current = 0;

                $("#crypto_0").find('option').first().remove();

                $("#crypto_0").prepend($('<option value="0" selected>Добавить</option>'));                
                deal_type = $(this).val();                

                selectors.each(function () 
                    {
                        let crypto_id = $(this).attr('id');
                        num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                        if (deal_type == 1) 
                            {
                                $(this).closest('.form-row').find('input.wallet').attr('data-secure-deal', 1);
                            } 
                        else
                            {
                                $(this).closest('.form-row').find('input.wallet').attr('data-secure-deal', 0);
                            }
                        
                        selectors.closest('.form-row').next().find('select').prop('disabled', true);
                        selectors.closest('.form-row').next().addClass('blocked');

                        let s = tresh_ps_selects_val.length;

                        if (deal_type == 1) // это БС
                            {
                                if (s > 0)
                                    {
                                        // полагается, что здесь список tresh_ps_selects_val заполнен, а значит надо восстанавливать option's из массивов для режима БС. И обнулять массивы для режима ПС !!!!
                                        for (let i = 0; i < s; i++)  
                                            {                                                
                                                if (tresh_ps_selects_min_price[i] != 0)
                                                    {
                                                        $(this).append($('<option value="' + tresh_ps_selects_val[i] + '" data-image="' + tresh_ps_selects_data[i] + '" data-min-price="' + tresh_ps_selects_min_price[i] + '">' + tresh_ps_selects_text[i] + '</option>'));
                                                    }
                                                else
                                                    {
                                                        if (!edit_bs_selects_val_min.includes($(this).val())) 
                                                            {
                                                                edit_bs_selects_val_min.push($(this).val());
                                                                edit_bs_selects_data_min.push($(this).data('image'));
                                                                edit_bs_selects_text_min.push($(this).text());
                                                                edit_bs_selects_min_price_min.push($(this).data('min-price'));
                                                            }
                                          
                                                        edit_ps_selects_val_min = edit_2ps_selects_val_min.slice();
                                                        edit_ps_selects_data_min = edit_2ps_selects_data_min.slice();
                                                        edit_ps_selects_text_min = edit_2ps_selects_text_min.slice();
                                                        edit_ps_selects_min_price_min = edit_2ps_selects_min_price_min.slice();
                                                    }
                                            }

                                        $(this).find('option').each(function () 
                                            {
                                                if ($(this).data('min-price') == 0)
                                                    {
                                                        if (!edit_bs_selects_val_min.includes($(this).val())) 
                                                            {
                                                                edit_bs_selects_val_min.push($(this).val());
                                                                edit_bs_selects_data_min.push($(this).data('image'));
                                                                edit_bs_selects_text_min.push($(this).text());
                                                                edit_bs_selects_min_price_min.push($(this).data('min-price'));
                                                            }
                                                        $(this).remove();
                                                    } 
                                            });                                            
                                    }
                            // это переход из ПС в БС по кнопке
                                
                                $(this).find('option').each(function () 
                                    { 
                                        if ($(this).val() != 0) 
                                            {
                                                $(this).remove();
                                            }         
                                    });

                                $.each(allWallets_without, function( key, value ) 
                                    {
                                        if (!edit_ps_to_bs_code.includes(key)) 
                                            {
                                                edit_ps_to_bs_code.push(key);
                                                edit_ps_to_bs_name.push(allWallets_without[key]);
                                            }                                           
                                   });

                                $.each(allWallets_name_min_without, function( key, value ) 
                                    {
                                        if (!edit_ps_to_bs_min_price.includes(allWallets_name_min_without[key])) 
                                            {
                                                edit_ps_to_bs_min_price.push(allWallets_name_min_without[key]);
                                            }                                             
                                   });
                                let n = edit_ps_to_bs_code.length;
                                $(this).find('option').each(function () 
                                    {                                        
                                        for (let i = 0; i < n; i++)  
                                            {
                                                $(this).after($('<option value="' + edit_ps_to_bs_code[i] + '" data-image="/template/img/'+edit_ps_to_bs_code[i].toLowerCase()+'.png' +'" data-min-price="' + edit_ps_to_bs_min_price[i] + '">' + edit_ps_to_bs_name[i] + '</option>'));
                                            }                                              
                                    });                                                                   
                                
                            }
                        else    
                            {   // это переход с ПС на БС и обратно
                                if (s > 0)
                                    {
                                        // полагается, что здесь список tresh_ps_selects_val заполнен, а значит надо удалять option's из селектов для режима ПС !!!!
                                        $(this).find('option').each(function () 
                                            { 
                                                for (let i = 0; i < s; i++)  
                                                    {
                                                       if ($(this).val() == tresh_ps_selects_val[i]) 
                                                        {
                                                            $(this).remove();
                                                        }  
                                                    }                                                    
                                            });

                                        $(this).find('option').each(function () 
                                            { 
                                                let size = edit_ps_selects_val_min.length;
                                                if (size != 0)
                                                    {
                                                        for (let i =0; i < size; i++)  
                                                            {
                                                                
                                                                $(this).after($('<option value="' + edit_ps_selects_val_min[i] + '" data-image="' + edit_ps_selects_data_min[i] + '" data-min-price="' + edit_ps_selects_min_price_min[i] + '">' + edit_ps_selects_text_min[i] + '</option>'));
                                                            }
                                                    }
                                                edit_ps_selects_val_min = [];
                                                edit_ps_selects_data_min = [];
                                                edit_ps_selects_text_min = [];
                                                edit_ps_selects_min_price_min = [];                                                    
                                            });                                              
                                    }
                                // это переход с БС на ПС и обратно по кнопке

                                let n = userWallets.length;
                                $(this).find('option').each(function () 
                                    { 
                                        if ($(this).val() != 0) 
                                            {
                                                $(this).remove();
                                            }         
                                    });

                                $(this).find('option').each(function () 
                                    { 
                                        let option = $(this);
                                        for (let i = 0; i < n; i++)  
                                            {  
                                                $.each(allWallets, function( key, value ) 
                                                    {
                                                        if (key == userWallets[i].toUpperCase())
                                                            {
                                                                $.each(allWallets_name_min, function( key, value ) 
                                                                {
                                                                    if (key == userWallets[i].toUpperCase())
                                                                        {
                                                                            option.after($('<option value="' + userWallets[i].toUpperCase() + '" data-image="/template/img/'+userWallets[i]+'.png' +'" data-min-price="' + allWallets_name_min[key] + '">' + allWallets[key] + '</option>'));
                                                                        }
                                                                });
                                                            }
                                                    });  
                                            }         
                                    });                                
                            }

                    });

                $('.val-select_price').each(function() 
                    {
                        $(this).val('');
                    }); 

                if (edit_history_selects_val[num_current+3] != '' && edit_history_selects_val[num_current+3] != null && edit_history_selects_val[num_current+3] !== undefined)
                    {                            
                        edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+3], edit_history_selects_val), 1); // это удаление элемент массива                      
                        edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+3], edit_history_selects_data), 1);
                        edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+3], edit_history_selects_text), 1);
                        edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+3], edit_history_selects_min_price), 1);
                    }
                
                if (edit_history_selects_val[num_current+2] != '' && edit_history_selects_val[num_current+2] != null && edit_history_selects_val[num_current+2] !== undefined)
                    {
                        $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current+1] + '" data-image="' + edit_history_selects_data[num_current+2] + '" data-min-price="' + edit_history_selects_min_price[num_current+2] + '">' + edit_history_selects_text[num_current+2] + '</option>'));
                        
                        edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+2], edit_history_selects_val), 1); // это удаление элемент массива                      
                        edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+2], edit_history_selects_data), 1);
                        edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+2], edit_history_selects_text), 1);
                        edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+2], edit_history_selects_min_price), 1);
                    }

                if (edit_history_selects_val[num_current+1] != '' && edit_history_selects_val[num_current+1] != null && edit_history_selects_val[num_current+1] !== undefined)
                    {
                        $('#crypto_2 :first').after($('<option value="' + edit_history_selects_val[num_current+1] + '" data-image="' + edit_history_selects_data[num_current+1] + '" data-min-price="' + edit_history_selects_min_price[num_current+1] + '">' + edit_history_selects_text[num_current+1] + '</option>'));
                        $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current+1] + '" data-image="' + edit_history_selects_data[num_current+1] + '" data-min-price="' + edit_history_selects_min_price[num_current+1] + '">' + edit_history_selects_text[num_current+1] + '</option>'));
                        
                        edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+1], edit_history_selects_val), 1); // это удаление элемент массива                      
                        edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+1], edit_history_selects_data), 1);
                        edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+1], edit_history_selects_text), 1);
                        edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+1], edit_history_selects_min_price), 1);
                    }

                if (edit_history_selects_val[num_current] != '' && edit_history_selects_val[num_current] != null && edit_history_selects_val[num_current] !== undefined)
                    {
                        $('#crypto_1 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));
                        $('#crypto_2 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));
                        $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));

                        edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current], edit_history_selects_val), 1); // это удаление элемент массива                      
                        edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current], edit_history_selects_data), 1);
                        edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current], edit_history_selects_text), 1);
                        edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current], edit_history_selects_min_price), 1);
                    }

                edit_history_selects_val = []; 
                edit_history_selects_data = []; 
                edit_history_selects_text = []; 
                edit_history_selects_min_price = []; 

        $('input[name="price_0"]').on('blur', function () 
            {
                const input = $('input[name="price_0"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[0]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_1"]').on('blur', function () 
            {
                const input = $('input[name="price_1"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[1]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_2"]').on('blur', function () 
            {
                const input = $('input[name="price_2"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[2]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_3"]').on('blur', function () 
            {
                const input = $('input[name="price_3"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (deal_type == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[edit_history_selects_val[3]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });                                          

            }); // конец $('select[name="secure_deal"]').on('change', function ()

        $("#crypto_0").on('change', function () 
            {
                let crypto_id = $(this).attr('id');
                num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                let selected_current_val = $(this).find('option:selected').val();

                if (selected_current_val != '' && selected_current_val != 0)
                    { 
                        if (!edit_history_selects_val.includes(selected_current_val)) 
                            {
                                edit_history_selects_val.push(selected_current_val);
                                edit_history_selects_data.push($(this).find('option:selected').data('image'));
                                edit_history_selects_text.push($(this).find('option:selected').text());
                                edit_history_selects_min_price.push($(this).find('option:selected').data('min-price'));
                                   
                                $('#crypto_1 option[value=' + edit_history_selects_val[num_current] + ']').remove();
                                $('#crypto_2 option[value=' + edit_history_selects_val[num_current] + ']').remove();
                                $('#crypto_3 option[value=' + edit_history_selects_val[num_current] + ']').remove();

                                $('#crypto_0').prop("disabled", true); 

                                let min_price = $(this).find('option:selected').data('min-price');

                                let wallet_type = $(this).find('option:selected').val();

                                var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                                
                                $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                                $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                                $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                                var a = $(this).closest('.form-row').find('input.wallet');

                                    if (a.attr('data-secure-deal') == 0)
                                        {
                                            a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                            
                                        }                                 
                            }                             
                    }
                else
                    {
                        $('#crypto_0').prop("disabled", false);
                        $('#crypto_1').prop("disabled", true);
                        $('#crypto_2').prop("disabled", true);
                        $('#crypto_3').prop("disabled", true);

                        $("#crypto_0").find('option').first().remove();
                        $("#crypto_0").prepend($('<option value="0" selected>Добавить</option>'));

                        wallets = {};
                        $('input[name="prices"]').val(JSON.stringify(wallets));

                        if (edit_history_selects_val[num_current+3] != '' && edit_history_selects_val[num_current+3] != null && edit_history_selects_val[num_current+3] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current+3]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current+2] + '" data-image="' + edit_history_selects_data[num_current+2] + '" data-min-price="' + edit_history_selects_min_price[num_current+2] + '">' + edit_history_selects_text[num_current+2] + '</option>'));
                                
                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+3], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+3], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+3], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+3], edit_history_selects_min_price), 1);
                            }

                        if (edit_history_selects_val[num_current+2] != '' && edit_history_selects_val[num_current+2] != null && edit_history_selects_val[num_current+2] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current+2]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current+2] + '" data-image="' + edit_history_selects_data[num_current+2] + '" data-min-price="' + edit_history_selects_min_price[num_current+2] + '">' + edit_history_selects_text[num_current+2] + '</option>'));
                                
                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+2], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+2], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+2], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+2], edit_history_selects_min_price), 1);
                            }

                        if (edit_history_selects_val[num_current+1] != '' && edit_history_selects_val[num_current+1] != null && edit_history_selects_val[num_current+1] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current+1]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                $('#crypto_2 :first').after($('<option value="' + edit_history_selects_val[num_current+1] + '" data-image="' + edit_history_selects_data[num_current+1] + '" data-min-price="' + edit_history_selects_min_price[num_current+1] + '">' + edit_history_selects_text[num_current+1] + '</option>'));
                                $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current+1] + '" data-image="' + edit_history_selects_data[num_current+1] + '" data-min-price="' + edit_history_selects_min_price[num_current+1] + '">' + edit_history_selects_text[num_current+1] + '</option>'));
                                
                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+1], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+1], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+1], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+1], edit_history_selects_min_price), 1);
                            }

                        if (edit_history_selects_val[num_current] != '' && edit_history_selects_val[num_current] != null && edit_history_selects_val[num_current] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                $('#crypto_1 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));
                                $('#crypto_2 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));
                                $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));

                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current], edit_history_selects_min_price), 1);
                            }
    //alert(edit_history_selects_val);                        
                    }
            }); 

        $("#crypto_1").on('change', function () 
            {
                let crypto_id = $(this).attr('id');
                num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                let selected_current_val = $(this).find('option:selected').val();

                if (selected_current_val != '' && selected_current_val != 0)
                    { 
                        if (!edit_history_selects_val.includes(selected_current_val)) 
                            {
                                edit_history_selects_val.push(selected_current_val);
                                edit_history_selects_data.push($(this).find('option:selected').data('image'));
                                edit_history_selects_text.push($(this).find('option:selected').text());
                                edit_history_selects_min_price.push($(this).find('option:selected').data('min-price'));
                                  
                                $('#crypto_2 option[value=' + edit_history_selects_val[num_current] + ']').remove();
                                $('#crypto_3 option[value=' + edit_history_selects_val[num_current] + ']').remove();

                                $('#crypto_1').prop("disabled", true); 

                                let min_price = $(this).find('option:selected').data('min-price');

                                let wallet_type = $(this).find('option:selected').val();

                                var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                                
                                $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                                $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                                $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                                var a = $(this).closest('.form-row').find('input.wallet');

                                    if (a.attr('data-secure-deal') == 0)
                                        {
                                            a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                            
                                        }                                 
                            }                             
                    }
                else
                    {
                        $('#crypto_1').prop("disabled", false);
                        $('#crypto_2').prop("disabled", true);
                        $('#crypto_3').prop("disabled", true);
                       
                        if (edit_history_selects_val[num_current+2] != '' && edit_history_selects_val[num_current+2] != null && edit_history_selects_val[num_current+2] !== undefined)
                            {   
                                delete wallets[edit_history_selects_val[num_current+2]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+2], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+2], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+2], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+2], edit_history_selects_min_price), 1);
                            }

                        if (edit_history_selects_val[num_current+1] != '' && edit_history_selects_val[num_current+1] != null && edit_history_selects_val[num_current+1] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current+1]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current+1] + '" data-image="' + edit_history_selects_data[num_current+1] + '" data-min-price="' + edit_history_selects_min_price[num_current+1] + '">' + edit_history_selects_text[num_current+1] + '</option>'));
                                
                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+1], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+1], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+1], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+1], edit_history_selects_min_price), 1);
                            }

                        if (edit_history_selects_val[num_current] != '' && edit_history_selects_val[num_current] != null && edit_history_selects_val[num_current] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                $('#crypto_2 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));
                                $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));
                                
                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current], edit_history_selects_min_price), 1);
                            }
    //alert(edit_history_selects_val);                        
                    }
            });


        $("#crypto_2").on('change', function () 
            {
                let crypto_id = $(this).attr('id');
                num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                let selected_current_val = $(this).find('option:selected').val();

                if (selected_current_val != '' && selected_current_val != 0)
                    { 
                        if (!edit_history_selects_val.includes(selected_current_val)) 
                            {
                                edit_history_selects_val.push(selected_current_val);
                                edit_history_selects_data.push($(this).find('option:selected').data('image'));
                                edit_history_selects_text.push($(this).find('option:selected').text());
                                edit_history_selects_min_price.push($(this).find('option:selected').data('min-price'));
                                  
                                $('#crypto_3 option[value=' + edit_history_selects_val[num_current] + ']').remove();

                                $('#crypto_2').prop("disabled", true);

                                let min_price = $(this).find('option:selected').data('min-price');

                                let wallet_type = $(this).find('option:selected').val();

                                var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                                
                                $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                                $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                                $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                                var a = $(this).closest('.form-row').find('input.wallet');

                                    if (a.attr('data-secure-deal') == 0)
                                        {
                                            a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                            
                                        }                                                           
                            }                             
                    }
             
                else
                    {
                        $('#crypto_2').prop("disabled", false);
                        $('#crypto_3').prop("disabled", true);
                       
                        if (edit_history_selects_val[num_current+1] != '' && edit_history_selects_val[num_current+1] != null && edit_history_selects_val[num_current+1] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current+1]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current+1], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current+1], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current+1], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current+1], edit_history_selects_min_price), 1);
                            }

                        if (edit_history_selects_val[num_current] != '' && edit_history_selects_val[num_current] != null && edit_history_selects_val[num_current] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                $('#crypto_3 :first').after($('<option value="' + edit_history_selects_val[num_current] + '" data-image="' + edit_history_selects_data[num_current] + '" data-min-price="' + edit_history_selects_min_price[num_current] + '">' + edit_history_selects_text[num_current] + '</option>'));
                                
                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current], edit_history_selects_min_price), 1);
                            }
    //alert(edit_history_selects_val);                        
                    }
                  
            });            

        $("#crypto_3").on('change', function () 
            {
                let crypto_id = $(this).attr('id');
                num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                let selected_current_val = $(this).find('option:selected').val();

                if (selected_current_val != '' && selected_current_val != 0)
                    { 
                        $('#crypto_3').prop("disabled", true);

                        edit_history_selects_val.push(selected_current_val);
                        edit_history_selects_data.push($(this).find('option:selected').data('image'));
                        edit_history_selects_text.push($(this).find('option:selected').text());
                        edit_history_selects_min_price.push($(this).find('option:selected').data('min-price'));

                        let min_price = $(this).find('option:selected').data('min-price');

                        let wallet_type = $(this).find('option:selected').val();

                        var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                        
                        $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                        $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                        $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                        var a = $(this).closest('.form-row').find('input.wallet');

                            if (a.attr('data-secure-deal') == 0)
                                {
                                    a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                    
                                }                                              
                    }
                else
                    {
                        $('#crypto_3').prop("disabled", false);

                        if (edit_history_selects_val[num_current] != '' && edit_history_selects_val[num_current] != null && edit_history_selects_val[num_current] !== undefined)
                            {
                                delete wallets[edit_history_selects_val[num_current]];
                                $('input[name="prices"]').val(JSON.stringify(wallets));

                                edit_history_selects_val.splice($.inArray(edit_history_selects_val[num_current], edit_history_selects_val), 1); // это удаление элемент массива                      
                                edit_history_selects_data.splice($.inArray(edit_history_selects_data[num_current], edit_history_selects_data), 1);
                                edit_history_selects_text.splice($.inArray(edit_history_selects_text[num_current], edit_history_selects_text), 1);
                                edit_history_selects_min_price.splice($.inArray(edit_history_selects_min_price[num_current], edit_history_selects_min_price), 1);
    //alert(edit_history_selects_val);                            
                            }
                        
                    }
            });


    })
    </script>

{else}

    <script>
    $(function () 
    {  
        const userWallets = [{foreach from=$user->getWallets() item=$wallet key=$type}'{$type}', {/foreach}];
        const allWallets = {
            {foreach from=$currencies item=$cur}
                '{$cur['code']}': '{$cur['name']}',
            {/foreach}
        };

        let wallets = {};
        let option_list = [];
        
        let history_selects_val = []; 
        let history_selects_data = []; 
        let history_selects_text = []; 
        let history_selects_min_price = []; 
        let history_selects_num = [];

        let bs_selects_val = []; 
        let bs_selects_data = []; 
        let bs_selects_text = [];  
        let bs_selects_min_price = [];

        let bs_selects_val_min = []; 
        let bs_selects_data_min = []; 
        let bs_selects_text_min = [];  
        let bs_selects_min_price_min = [];         

        let type_deal = 0;  

        let num_current = 0;

        if ($("input[name='photos']").val() !== "")
            {
                wallets = JSON.parse($("input[name='prices']").val());
                console.log(wallets);
            }

        $(".wallet_type").val();

        $("input.wallet").keyup(function () 
            {
                
                UpdateWalletObject();                
            });

        function UpdateWalletObject() 
        {
            wallets = {};

            $('.wallet').each(function () 
                {
                    const input = $(this);

                    let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                    if (wallet_type != '' && wallet_type != '0') 
                        {

                            wallets[wallet_type] = input.val();

                            $('input[name="prices"]').val(JSON.stringify(wallets));
                        }
                });

            console.log(wallets);
        }                                               

        $('select[name="secure_deal"]').on('change', function () 
            {
                let selectors = $('select[name="add_obj_select_crypto"]');
                wallets = {};
                $('input[name="prices"]').val(JSON.stringify(wallets));
                num_current = 0;

                type_deal = $(this).val();
 
                selectors.each(function () 
                    {
                        let crypto_id = $(this).attr('id');
                        num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a
                        
                        let firstOption = $(this).find('option').first();
                       
                        if ($(this).is('[disabled]')) 
                            {
                                firstOption.text('');
                            } 
                        else
                            {
                                firstOption.text('Добавить');
                            }

                        if (type_deal == 1) 
                            {
                                $(this).closest('.form-row').find('input.wallet').attr('data-secure-deal', 1);
                            } 
                        else
                            {
                                $(this).closest('.form-row').find('input.wallet').attr('data-secure-deal', 0);
                            }                            

                        selectors.closest('.form-row').next().find('select').prop('disabled', true);
                        selectors.closest('.form-row').next().addClass('blocked'); 

                                $(this).find('option').each(function () 
                                    {
                                        let value = $(this).attr('value');

                                        if (type_deal !== '1') 
                                            {                                   
                                                
                                                let size = bs_selects_val_min.length;
                                                if (size != 0)
                                                    {
                                                        // полагается, что здесь список bs_selects_val заполнен, а значит надо восстанавливать option's из массивов для режима БС. И обнулять массивы для режима ПС !!!!
                                                        for (let i =0; i < size; i++)  
                                                            {
                                                                if($(this).val() !== bs_selects_val_min[i])
                                                                    {
selectors.append($('<option value="' + bs_selects_val_min[i] + '" data-image="' + bs_selects_data_min[i] + '" data-min-price="' + bs_selects_min_price_min[i] + '">' + bs_selects_text_min[i] + '</option>'));
                                                                    }
                                                            }
                                                        bs_selects_val_min = []; 
                                                        bs_selects_data_min = []; 
                                                        bs_selects_text_min = [];
                                                        bs_selects_min_price_min = [];
                                                    }

                                                let found = false;

                                                $.each(userWallets, function (index, type) {

                                                    if (type.toLocaleUpperCase() == value) found = true;
                                                });

                                                if (!found) 
                                                {
                                                    if($(this).val() != 0)
                                                        {                                    
                                                           
                                                            if (!bs_selects_val.includes($(this).val())) 
                                                                {
                                                                    bs_selects_val.push($(this).val());
                                                                    bs_selects_data.push($(this).data('image'));
                                                                    bs_selects_text.push($(this).text());
                                                                    bs_selects_min_price.push($(this).data('min-price'));
                                                                }

                                                            $(this).remove();  // .prop('disabled', true);
                                                        }
                                                } 
                                                else
                                                {
                                                    $(this).prop('disabled', false);
                                                }
                                            } 
                                        else
                                            {
                                           
                                                let size = bs_selects_val.length;
                                                if (size != 0)
                                                    {
                                                        // полагается, что здесь список bs_selects_val заполнен, а значит надо восстанавливать option's из массивов для режима БС. И обнулять массивы для режима ПС !!!!
                                                        for (let i =0; i < size; i++)  
                                                            {
                                                                if($(this).val() !== bs_selects_val[i] && bs_selects_min_price[i] !== 0)
                                                                    {
selectors.append($('<option value="' + bs_selects_val[i] + '" data-image="' + bs_selects_data[i] + '" data-min-price="' + bs_selects_min_price[i] + '">' + bs_selects_text[i] + '</option>'));
                                                                    }
                                                            }
                                                        bs_selects_val = []; 
                                                        bs_selects_data = []; 
                                                        bs_selects_text = [];
                                                        bs_selects_min_price = [];
                                                    }

                                                if ($(this).data('min-price') == 0)
                                                    {
                                                        if (!bs_selects_val_min.includes($(this).val())) 
                                                            {
                                                                bs_selects_val_min.push($(this).val());
                                                                bs_selects_data_min.push($(this).data('image'));
                                                                bs_selects_text_min.push($(this).text());
                                                                bs_selects_min_price_min.push($(this).data('min-price'));
                                                            }
                                                        $(this).remove();
                                                    }                                                       
                                            }                  
                                    });  

                            $(this).select2();
                    });

                $('.val-select_price').each(function() 
                    {
                        $(this).val('');
                    }); 

                if (history_selects_val[num_current+3] != '' && history_selects_val[num_current+3] != null && history_selects_val[num_current+3] !== undefined)
                    {                            
                        history_selects_val.splice($.inArray(history_selects_val[num_current+3], history_selects_val), 1); // это удаление элемент массива                      
                        history_selects_data.splice($.inArray(history_selects_data[num_current+3], history_selects_data), 1);
                        history_selects_text.splice($.inArray(history_selects_text[num_current+3], history_selects_text), 1);
                        history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+3], history_selects_min_price), 1);
                    }
                
                if (history_selects_val[num_current+2] != '' && history_selects_val[num_current+2] != null && history_selects_val[num_current+2] !== undefined)
                    {
                        $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+2] + '" data-min-price="' + history_selects_min_price[num_current+2] + '">' + history_selects_text[num_current+2] + '</option>'));
                        
                        history_selects_val.splice($.inArray(history_selects_val[num_current+2], history_selects_val), 1); // это удаление элемент массива                      
                        history_selects_data.splice($.inArray(history_selects_data[num_current+2], history_selects_data), 1);
                        history_selects_text.splice($.inArray(history_selects_text[num_current+2], history_selects_text), 1);
                        history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+2], history_selects_min_price), 1);
                    }

                if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                    {
                        $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '" data-min-price="' + history_selects_min_price[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                        $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '" data-min-price="' + history_selects_min_price[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                        
                        history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                        history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                        history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                        history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+1], history_selects_min_price), 1);
                    }

                if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                    {
                        $('#crypto_1 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                        $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                        $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));

                        history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                        history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                        history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
                        history_selects_min_price.splice($.inArray(history_selects_min_price[num_current], history_selects_min_price), 1);
                    }

                history_selects_val = []; 
                history_selects_data = []; 
                history_selects_text = [];
                history_selects_min_price  = [];     

        $('input[name="price_0"]').on('blur', function () 
            {
                const input = $('input[name="price_0"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (type_deal == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[history_selects_val[0]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_1"]').on('blur', function () 
            {
                const input = $('input[name="price_1"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (type_deal == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[history_selects_val[1]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_2"]').on('blur', function () 
            {
                const input = $('input[name="price_2"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (type_deal == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[history_selects_val[2]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });

        $('input[name="price_3"]').on('blur', function () 
            {
                const input = $('input[name="price_3"]');
                let min_price = input.closest('.form-row').find('select.wallet_type option:selected').data('min-price');
                let wallet_type = input.closest('.form-row').find('select.wallet_type option:selected').val();

                if (type_deal == 1)
                    {
                        if (input.val() < min_price) 
                            {
                                input.val(min_price);

                                delete wallets[history_selects_val[3]];
                
                                wallets[wallet_type] = input.val();

                                $('input[name="prices"]').val(JSON.stringify(wallets));
                            }
                    }
            });                          

        }); // конец $('select[name="secure_deal"]').on('change', function ()

            $("#crypto_0").on('change', function () 
                {
                    let crypto_id = $(this).attr('id');
                    num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                    let selected_current_val = $(this).find('option:selected').val();      

                    if (selected_current_val != '' && selected_current_val != 0)
                        { 
                            if (!history_selects_val.includes($(this).find('option:selected').val())) 
                                {
                                    history_selects_val.push($(this).find('option:selected').val());
                                    history_selects_data.push($(this).find('option:selected').data('image'));
                                    history_selects_text.push($(this).find('option:selected').text());
                                    history_selects_min_price.push($(this).find('option:selected').data('min-price'));
                                       
                                    $('#crypto_1 option[value=' + history_selects_val[num_current] + ']').remove();
                                    $('#crypto_2 option[value=' + history_selects_val[num_current] + ']').remove();
                                    $('#crypto_3 option[value=' + history_selects_val[num_current] + ']').remove();

                                    $('#crypto_0').prop("disabled", true);

                                    let min_price = $(this).find('option:selected').data('min-price');

                                    let wallet_type = $(this).find('option:selected').val();

                                    var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                                    
                                    $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                                    $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                                    $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                                    var a = $(this).closest('.form-row').find('input.wallet');

                                        if (a.attr('data-secure-deal') == 0)
                                            {
                                                a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                                
                                            }                       
                                }                             
                        }
                    else
                        {
                            $('#crypto_0').prop("disabled", false);
                            $('#crypto_1').prop("disabled", true);
                            $('#crypto_2').prop("disabled", true);
                            $('#crypto_3').prop("disabled", true);
                                    
                            wallets = {};
                            $('input[name="prices"]').val(JSON.stringify(wallets));

                            if (history_selects_val[num_current+3] != '' && history_selects_val[num_current+3] != null && history_selects_val[num_current+3] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+3]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+2] + '" data-image="' + history_selects_data[num_current+2] + '" data-min-price="' + history_selects_min_price[num_current+2] + '">' + history_selects_text[num_current+2] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+3], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+3], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+3], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+3], history_selects_min_price), 1);
                                }

                            if (history_selects_val[num_current+2] != '' && history_selects_val[num_current+2] != null && history_selects_val[num_current+2] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+2]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+2] + '" data-image="' + history_selects_data[num_current+2] + '" data-min-price="' + history_selects_min_price[num_current+2] + '">' + history_selects_text[num_current+2] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+2], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+2], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+2], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+2], history_selects_min_price), 1);
                                }

                            if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+1]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '" data-min-price="' + history_selects_min_price[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '" data-min-price="' + history_selects_min_price[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+1], history_selects_min_price), 1);
                                }

                            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_1 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));

                                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current], history_selects_min_price), 1);
                                }
                        }
                }); 
  
            $("#crypto_1").on('change', function () 
                {
                    let crypto_id = $(this).attr('id');
                    num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                    let selected_current_val = $(this).find('option:selected').val();

                    if (selected_current_val != '' && selected_current_val != 0)
                        { 
                            if (!history_selects_val.includes($(this).find('option:selected').val())) 
                                {
                                    history_selects_val.push($(this).find('option:selected').val());
                                    history_selects_data.push($(this).find('option:selected').data('image'));
                                    history_selects_text.push($(this).find('option:selected').text());
                                    history_selects_min_price.push($(this).find('option:selected').data('min-price'));
                                      
                                    $('#crypto_2 option[value=' + history_selects_val[num_current] + ']').remove();
                                    $('#crypto_3 option[value=' + history_selects_val[num_current] + ']').remove();

                                    $('#crypto_1').prop("disabled", true); 

                                    let min_price = $(this).find('option:selected').data('min-price');

                                    let wallet_type = $(this).find('option:selected').val();

                                    var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                                    
                                    $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                                    $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                                    $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                                    var a = $(this).closest('.form-row').find('input.wallet');

                                        if (a.attr('data-secure-deal') == 0)
                                            {
                                                a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                                
                                            } 
                                }                             
                        }
                    else
                        {
                            $('#crypto_1').prop("disabled", false);
                            $('#crypto_2').prop("disabled", true);
                            $('#crypto_3').prop("disabled", true);
                            
                            if (history_selects_val[num_current+2] != '' && history_selects_val[num_current+2] != null && history_selects_val[num_current+2] !== undefined)
                                {   
                                    delete wallets[history_selects_val[num_current+2]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    history_selects_val.splice($.inArray(history_selects_val[num_current+2], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+2], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+2], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+2], history_selects_min_price), 1);
                                }

                            if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+1]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '" data-min-price="' + history_selects_min_price[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+1], history_selects_min_price), 1);
                                }

                            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current], history_selects_min_price), 1);
                                }
                        }
                });

            $("#crypto_2").on('change', function () 
                {
                    let crypto_id = $(this).attr('id');
                    num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                    let selected_current_val = $(this).find('option:selected').val();

                    if (selected_current_val != '' && selected_current_val != 0)
                        { 
                            if (!history_selects_val.includes($(this).find('option:selected').val())) 
                                {
                                    history_selects_val.push($(this).find('option:selected').val());
                                    history_selects_data.push($(this).find('option:selected').data('image'));
                                    history_selects_text.push($(this).find('option:selected').text());
                                    history_selects_min_price.push($(this).find('option:selected').data('min-price'));
                                      
                                    $('#crypto_3 option[value=' + history_selects_val[num_current] + ']').remove();

                                    $('#crypto_2').prop("disabled", true); 

                                    let min_price = $(this).find('option:selected').data('min-price');

                                    let wallet_type = $(this).find('option:selected').val();

                                    var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                                    
                                    $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                                    $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                                    $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                                    var a = $(this).closest('.form-row').find('input.wallet');

                                        if (a.attr('data-secure-deal') == 0)
                                            {
                                                a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                                
                                            } 

                                }                             
                        }
                 
                    else
                        {
                            $('#crypto_2').prop("disabled", false);
                            $('#crypto_3').prop("disabled", true);
                            
                            if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+1]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current+1], history_selects_min_price), 1);
                                }

                            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '" data-min-price="' + history_selects_min_price[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current], history_selects_min_price), 1);
                                }
                        }
                });            

            $("#crypto_3").on('change', function () 
                {
                    let crypto_id = $(this).attr('id');
                    num_current = Number.parseInt(crypto_id.charAt(7)); // номер текущего select'a

                    let selected_current_val = $(this).find('option:selected').val();

                    if (selected_current_val != '' && selected_current_val != 0)
                        { 
                            $('#crypto_3').prop("disabled", true);

                            history_selects_val.push($(this).find('option:selected').val());
                            history_selects_data.push($(this).find('option:selected').data('image'));
                            history_selects_text.push($(this).find('option:selected').text());
                            history_selects_min_price.push($(this).find('option:selected').data('min-price'));
                        
                            let min_price = $(this).find('option:selected').data('min-price');

                            let wallet_type = $(this).find('option:selected').val();

                            var str_tooltip = 'Стоимость товара в единицах этой крипты должна быть не меньше ' + min_price + ' ' + wallet_type;
                            
                            $(this).closest('.form-row').find('input.wallet').attr('data-tooltip', str_tooltip);

                            $(this).closest('.form-row').find('input.wallet').attr('data-min-price', min_price);

                            $(this).closest('.form-row').find('input.wallet').attr('data-wallet-type', wallet_type);

                            var a = $(this).closest('.form-row').find('input.wallet');

                                if (a.attr('data-secure-deal') == 0)
                                    {
                                        a.attr('data-tooltip', 'Впишите стоимость вашего товара!')
                                        
                                    }                                                          
                        }
                    else
                        {
                            $('#crypto_3').prop("disabled", false);

                            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
                                    history_selects_min_price.splice($.inArray(history_selects_min_price[num_current], history_selects_min_price), 1);
                                }
                            
                        }
                });
              
})

    </script>
{/if}


<script>
$(function()
    {  
        const form = $('.form-row.photos');

        $("#type_deal").on('change', function() 
            {
                form.find('.photos-block > div:first-child').removeClass('disabled').addClass('active');
            });

        $("#location_country").on('change', function() 
          {         
            let country_select = $(this).val();
             
            if (country_select != '')
               {
                    var citySelect = $('#location_city');
                    
                    citySelect.html(''); // очищаем список городов

                        $.ajax({
                            url: '/ajax/sections/get_country_id.php',
                            type: 'POST',
                            dataType: 'JSON',
                            data: { country_id: country_select },
                        })
                            .done(function(data) 
                            {
                                console.log("success");

 //                               citySelect.html(''); // очищаем список городов
                                
                                // заполняем список городов новыми пришедшими данными
                                citySelect.append('<option value="Выберите город" data-first="true" selected disabled>Выберите город</option>');
                                citySelect.append('<option value="Добавьте город">Добавить новый, если нет в списке</option>');
                                
                                $.each(data, function(i) 
                                {
                                    citySelect.append('<option value="' + data[i].id + '">' + data[i].name + '</option>');
                             
                                });


                            })
                                .fail(function() 
                                {
                                    console.log("error");

                                        citySelect.html(''); // очищаем список городов
                                        
                                        // заполняем список городов новыми пришедшими данными
                                        citySelect.append('<option value="Выберите город" data-first="true" selected disabled>Выберите город</option>');
                                        citySelect.append('<option value="Добавьте город">Добавить новый, если нет в списке</option>');

                                        citySelect.append('<option value=""></option>');

                                })
                                .always(function() 
                                {
                                    console.log("complete");
                                });

                        $(".map_sd--city").css("display", "block"); // появляется поле с выбором города
                        
                        $('#city-new-add').prop("disabled", false);
                        $('#city-new-add').addClass('required-field');
                        

                        $('#location_city').prop("disabled", false);                //скрываем поле для добавления нового города
                        $('#location_city').addClass('required-field');
                        $('#location_city').addClass('required');
                        $('#location_city').prop("required", true);                   
                }

                else 
                    { 
                        $(".map_sd--city").css("display", "none");
                        $('#city-new-add').prop("disabled", true);
                        $('#city-new-add').removeClass('required-field');
                        $('#location_city').removeClass('required-field');
                        $('#location_city').removeClass('required');
                        
                    }
            });       

            $("#location_city").on('change', function() 
            {         
                if ($("#location_city").val() != 'Добавьте город' && $("#location_city").val() != 'Выберите город' && $("#location_city").val() != null)
                    {  
                        $("#city-new-add").val('');                        // очищаем новое поле от содержимого при скрытии поля                
                        $('#city-new-add').prop("disabled", true);                   //скрываем поле для добавления нового города
                        $('#city-new-add').removeClass('required-field');
                        
                    }
                else
                    {
                        $('#city-new-add').prop("disabled", false);   //поле для добавления нового города
                        $('#city-new-add').addClass('required-field'); 
                        
                        
                        $('#location_city option:contains("Или")').prop('selected', false);
                        $('#location_city option:contains("Выберите")').prop('selected', true);
                        $('#city-new-add').trigger('change');
                    }

            });                       

            $("#city-new-add").on('change', function() 
            {         
                if ($("#city-new-add").val() != '')
                    {               
                        $('#location_city').prop("disabled", true);                //скрываем поле для добавления нового города
                        $('#location_city').removeClass('required-field'); 
                        $('#location_city').removeClass("required");
                        
                    }
                else
                    {             
                        $('#location_city').prop("disabled", false);                //скрываем поле для добавления нового города
                        $('#location_city').addClass('required-field');

                        setTimeout(function () 
                            {   
                                $('#location_city').trigger('change');
                            }, 1000); 
                    }
            });

        $("#city-new-add").keyup(function () 
            {
                if (!isNaN($(this).val()))  
                    {
                        alert('В названии должны быть только буквы!');
                        $(this).val('');
                        
                    }
            });                        
    })  
</script>


<div class="in">
    <div class="container">
        <h1 class="title-page">{if $edit_mode}Редактировать{else}Разместить{/if} объявление</h1>
        <form class="add-object{if $edit_mode} edit_mode{/if}" action="/ajax/adverts/{if $edit_mode}update_advert{else}add_advert{/if}.php" method="post">
            {if !$edit_mode}
                <input type="hidden" name="photos" value="{if $edit_mode}{htmlspecialchars(json_encode($advert->getPhotos()))}{/if}">
            {/if}
            <input type="hidden" name="prices" value="{if $edit_mode}{htmlspecialchars(json_encode($advert->getPrices()))}{/if}" required>
            {if $edit_mode}
                <input type="hidden" name="advert_id" value="{$advert->getId()}">
            {/if}
            <div class="row">
                <div class="col-xs-9 create-ad__body">
                    {if !$edit_mode}
                        <div class="form-row add_obj_cats" data-step="1">
                            <label>Раздел<span>*</span></label>
                            <select name="section" id="section" class="required-field filter_select_objects selectSomething nosearch section_select" data-target="#category" data-type="categories">
                                <option value="" disabled selected>Не выбрано</option>
                                {foreach from=$sections item=$section}
                                    <option value="{$section->getId()}">{$section->getName()}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-row blocked add_obj_cats" data-step="2">
                            <label>Категория<span>*</span></label>
                            <select name="category" class="required-field filter_select_objects selectSomething category_select" id="category" data-target="#subcategory" data-type="subcategories" disabled>
                                <option value=""></option>
                            </select>
                        </div>
                        <div class="form-row blocked add_obj_cats" data-step="3">
                            <label>Подкатегория<span>*</span></label>
                            <select name="subcategory" class="required-field filter_select_objects selectSomething" id="subcategory" disabled>
                                <option value=""></option>
                            </select>
                        </div>
                        <div class="form-row" data-step="4">
                            <label>Название товара<span>*</span> <span data-toggleAll="tooltip" data-trigger="click" title="Название должно соответствовать <a href='/pages.php?page=cookie_policy' target='_blank'>Правилам</a> и <a href='/pages.php?page=cookie_policy' target='_blank'>Политике сайта ZaCrypto</a> и не превышать 42 символов">
                                    <i class="form-info"></i>
                                </span>
                            </label>
                            <input class="required-field" type="text" name="name" maxlength="42" {if $edit_mode}value="{htmlspecialchars($advert->getName())}"{/if}>
                        </div>
                        <div class="form-row condition" data-step="5">
                            <label>Состояние<span>*</span></label>
                            <select name="condition" class="required-field filter_select_objects nosearch" required>
                                <option value="0" selected disabled></option>
                                <option value="1">Новое</option>
                                <option value="2">Б/У</option>
                            </select>
                        </div>
                        <div class="form-row description" data-step="6">
                            <label>Описание<span>*</span> <span data-toggleAll="tooltip" data-trigger="click" title="Описание должно соответствовать <a href='/pages.php?page=cookie_policy' target='_blank'>Правилам</a> и <a href='/pages.php?page=cookie_policy' target='_blank'>Политике сайта ZaCrypto</a> и не превышать 1000 символов">
                                    <i class="form-info"></i>
                                </span>
                            </label>
                            <textarea class="required-field" name="description" maxlength="1000" required>{if $edit_mode}{htmlspecialchars($advert->getName())}{/if}</textarea>
                        </div>
                    {/if}
                    <div class="form-row">
                        <div class="row">
                            <div class="col-xs-9">
                                <div class="form-row val-block val-block_close" data-step="7">
                                    <label>Способ перевода<span>*</span>
                                        <span data-toggleAll="tooltip" data-trigger="click" title="Выбирая Безопасную сделку Вы подтверждаете, что ознакомились с <a href='/pages.php?page=cookie_policy' target='_blank'>Правилами</a> и <a href='/pages.php?page=cookie_policy' target='_blank'>Политикой сайта ZaCrypto</a>">
                                            <i class="form-info"></i>
                                        </span>
                                    </label>
                                    <select name="secure_deal" class="required-field filter_select_objects nosearch" required>
                                        <option value="" selected disabled></option>
                                        <option value="1" {if $edit_mode && $advert->getSecureDeal()}selected{/if}>Безопасная сделка</option>
                                        <option value="0" {if $edit_mode && !$advert->getSecureDeal()}selected{/if}>Прямая сделка</option>
                                    </select>
                                </div>
                                <div>
                                    {if $edit_mode}
                                        {$key = 0}
                                        {foreach from=$advert->getPrices() item=$price key=$type}
                                            <div class="form-row val-block val-select" data-step="8">
                                                <label>Выбор крипты</label>
                                                <select id="crypto_{$key}" name="add_obj_select_crypto" class="filter_select_objects add_obj_select_crypto wallet_type {if $key == 0}required-field{/if}">
                                                <option value="0"></option>
                                                {if $advert->getSecureDeal()}
                                                    {foreach from=$all_cryptos_bs item=$crypto}
                                                    <option value="{$crypto['code']}" data-image="{$template}/img/{mb_strtolower({$crypto['code']})}.png" data-min-price="{$crypto['bs_min_price']}"{if $crypto['code'] == mb_strtoupper($type)} selected{/if}>{$crypto['name']}</option>
                                                    {/foreach}
                                                {else}
                                                    {foreach from=$all_cryptos item=$crypto}
                                                    <option value="{$crypto['code']}" data-image="{$template}/img/{mb_strtolower({$crypto['code']})}.png" data-min-price="{$crypto['bs_min_price']}"{if $crypto['code'] == mb_strtoupper($type)} selected{/if}>{$crypto['name']}</option>
                                                    {/foreach}
                                                {/if}
                                                </select>
                                                <input type="text" name="price_{$key}" class="val-select_price wallet {if $key == 0}required-field{/if}" maxlength="8" value="{$price}" data-tooltip="Вы можете изменить стоимость товара и тип крипты." data-min-price="" data-wallet-type="" data-secure-deal="">
                                            </div>
                                            {$key = $key + 1}
                                        {/foreach}
                                    {else}

                                    <div class="form-row val-block val-select" data-step="8">
                                            <label>Выбор крипты<span>*</span> <span data-toggleAll="tooltip" data-trigger="click" title="Выбрать можно только криптовалюты внесенные в Ваш <a href='/dashboard.php?page=wallets' target='_blank'>Адрес кошельков</a>">
                                                <i class="form-info"></i>
                                            </span>
                                            </label>
                                            <select id="crypto_0" name="add_obj_select_crypto" class="required-field filter_select_objects add_obj_select_crypto wallet_type" required {if !$edit_mode}disabled{/if}>
                                                
                                                <option value="0"></option>
                                                {foreach from=$all_cryptos item=$crypto}
                                                    <option value="{$crypto['code']}" data-image="{$template}/img/{mb_strtolower({$crypto['code']})}.png" data-min-price="{$crypto['bs_min_price']}">{$crypto['name']}</option>
                                                {/foreach}
                                            </select>
                                            <input type="text" name="price_0" class="required-field val-select_price wallet" maxlength="8" data-tooltip="" data-min-price="" data-wallet-type="" data-secure-deal="">
                                        </div>
                                    {/if}
                                    {$count = 3}
                                    {if $edit_mode}
                                        {$count = $count - count($advert->getPrices()) + 1}
                                    {/if}
                                    {for $i=1 to $count}
                                        
                                        {$blocked = ($i == 1 AND !$edit_mode)}

                                        <div class="form-row {if $blocked}blocked{/if} val-block val-select">
                                        
                                            <label>Выбор крипты</label>
                                            <select id="crypto_{if $edit_mode}{$key}{else}{$i}{/if}" name="add_obj_select_crypto" class="filter_select_objects add_obj_select_crypto filter_select_objects_custom wallet_type" {if !$edit_mode}disabled{/if}>
                                               
                                                <option value="0"></option>

                                                {foreach from=$all_cryptos item=$crypto}
                                                    <option value="{$crypto['code']}" data-image="{$template}/img/{mb_strtolower({$crypto['code']})}.png" data-min-price="{$crypto['bs_min_price']}">{$crypto['name']}</option>
                                                {/foreach}

                                            </select>
                                            <input type="text" name="price_{if $edit_mode}{$key}{else}{$i}{/if}" class="val-select_price wallet" maxlength="8" data-tooltip="" data-min-price="" data-wallet-type="" data-secure-deal="">
                                        </div>
                                        {if $edit_mode}{$key = $key + 1}{/if}
                                    {/for}
                                </div>
                            </div>
                            <div class="col-xs-3">
                                {include file='elements/main/rates.tpl'}
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="form-row type_sd" data-step="9">
                        <label>Тип сделки<span>*</span> <span data-toggleAll="tooltip" data-trigger="click" title="<p class='white'>Передача через сеть позволяет передать товар или оказать услугу дистанционно</p><p class='white'>Для личной встречи - советуем использовать английскую версию наименования выбранного места сделки</p>">
                                <i class="form-info"></i>
                            </span>
                        </label>
                      
                        <select id="type_deal" name="without_location" class="required-field filter_select_objects nosearch" required>
                            <option value="" selected disabled></option>
                            <option value="0" {if $edit_mode && $advert->getLocation()->getId() >= 1} selected{/if}>Личная встреча</option>
                            <option value="1" {if $edit_mode && $advert->getLocation()->getId() < 1} selected{/if}>Передача через сеть</option>
                        </select>
                    </div>

                    
                    <div class="form-row map_sd" data-step="8" {if $edit_mode && $advert->getLocation()->getId() >= 1}style="display: block;"{else}style="display: none;"{/if}>
                        <label>Место сделки<span>*</span> <span data-toggleAll="tooltip" data-trigger="click" title="Обязательно укажите Страну и Город для продажи товара или оказания услуги. Город можно выбрать из списка или вписать от руки в дополнительное поле.">
                                <i class="form-info"></i>
                            </span>
                        </label>
                        <select id="location_country" name="location" class="filter_select_objects country_select" data-target="filter_city">
                            <option value="Выберите страну" data-first="true" selected disabled>{t}Выберите страну{/t}</option>

                            {if !$edit_mode}
                            {foreach from=$locations item=$location}
                                <option value="{$location->getId()}">{$location->getName()}</option>
                            {/foreach}
                            {else}
                            
                            {foreach from=$locations item=$location}
<option value="{$location->getId()}" {if $location->getId() == $advert->getLocation()->getId()}selected{/if}>{$location->getName()}</option>
                            {/foreach}
                            
                            {/if}
                        </select>

                        <div class="form-row map_sd--city" {if $edit_mode && $advert->getLocation()->getId() >= 1}style="display: block;"{else}style="display: none;"{/if}>
                            <label></label>
                            <select id="location_city" name="location_name" id="filter_city" class="filter_select_objects">
                                    <option value="Выберите город" data-first="true" selected disabled>{t}Выберите город{/t}</option>
                                    <option value="Добавьте город">{t}Или добавьте новый, если нет в списке{/t}</option>

                            {if !$edit_mode}
                                <option value=""></option>
                            {else}
                            
                            {foreach from=$country->GetCitiesOfCountry($advert->getLocation()->getId()) item=$city}
                <option value="{$city->getId()}" {if $city->getName() == $advert->getLocationName()}selected{/if}>{$city->getName()}</option>  
                            {/foreach} 
                            
                            {/if}
                            </select>

                            <label></label>
                            <input id="city-new-add" type="text" name="location_name_new" maxlength="42" placeholder="Или впишите название нового города здесь" class="" {if $edit_mode && $advert->getLocation()->getId() >= 1}disabled{/if}>
                            
                        </div>                        
                    </div>

                    {if !$edit_mode}
                        <div class="form-row photos" data-step="10">
                            <label>Фотографии<span>*</span> <span data-toggleAll="tooltip" data-trigger="click" title="<p class='white'>Вы можете загрузить до 5 фотографий в формате JPG или PNG</p><p class='white'>Максимальный размер фото - 5MB</p>">
                                    <i class="form-info"></i>
                                </span>
                            </label>

                            <div class="photos-block">
                                {for $i=0 to 4}
                                    <div class="photo-photo_{$i} disabled">
                                        <div id="photo_close_{$i}" class="close-select photo_photo_close" style="display: none; vertical-align: middle; margin: -6px -31px 0px 0px; background: white; border-style: solid; border-color: #C33; border-radius: 100%; border-width: 1.0px; z-index: 25; cursor: pointer; padding: 0px 6.5px;"></div>
                                        <input id="file_{$i}" type="file" name="{if $i == 0}main_photo{else}item_photo{/if}" class="{if $i == 0} required-field{/if}" accept="image/*">

                                        <label id="photo_label_{$i}">
                                            <svg version="1.1" class="icon-photo" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                 viewBox="0 0 640 492" enable-background="new 0 0 640 492" xml:space="preserve">
                                                <g>
                                                    <g>
                                                        <path fill="#B5C6D5" d="M576,493.1c-170,0-340,0-510,0c-0.9-0.3-1.8-0.8-2.8-0.9c-36.8-6.4-62.2-36.3-62.2-73.4
                                                            c-0.1-81.7-0.2-163.3,0.2-245c0-8.7,1.7-17.7,4.5-25.9c10.5-29.9,37.9-48.3,71.1-48.4c30.5-0.1,61-0.1,91.5,0.1
                                                            c4,0,5.8-1.3,7.5-4.8c9.3-19,18.6-38,28.3-56.7c4-7.8,8.6-15.5,13.8-22.5C225.4,5.6,235.8,1,248.3,1c48.5,0.1,97,0.1,145.5,0
                                                            c12.4,0,22.5,4.5,30,14.1c4.6,5.9,8.6,12.3,12,18.9c10.4,20.1,20.4,40.4,30.4,60.7c1.7,3.5,3.6,4.7,7.6,4.7
                                                            c30.5-0.2,61-0.2,91.5-0.1c35.6,0.2,64.2,21.6,73.2,54.6c0.9,3.3,1.7,6.7,2.5,10c0,88,0,176,0,264c-0.4,1.2-0.8,2.5-1.1,3.7
                                                            c-6,29.3-23.2,48.7-51.5,58.1C584.4,491.3,580.2,492,576,493.1z M468.8,296.3c0-81.4-66.1-147.4-147.7-147.5
                                                            c-81.6-0.1-147.8,65.9-147.9,147.3c-0.1,81.4,66.1,147.8,147.4,147.9C402.4,444,468.8,377.8,468.8,296.3z M75,148.8
                                                            c-13.7-0.1-24.9,11-24.8,24.6c0.1,13.4,11.1,24.4,24.5,24.5c13.6,0.1,24.7-11.1,24.7-24.8C99.4,159.6,88.6,148.8,75,148.8z"/>
                                                        <path fill="#B5C6D5" d="M321,222.4c40.6,0,73.9,33.1,73.9,73.7c0.1,40.9-33.2,74-74.1,73.9c-40.6-0.1-73.7-33.2-73.6-73.9
                                                            C247.2,255.6,280.3,222.5,321,222.4z"/>
                                                    </g>
                                                </g>
                                            </svg>
                                            <svg version="1.1" class="icon-plus" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                 viewBox="0 0 238.1 238.1" enable-background="new 0 0 238.1 238.1" xml:space="preserve">
                                                <path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#3A4B5F" stroke-width="10" stroke-miterlimit="10" d="M119,9.6
                                                    c60.5,0,109.5,49,109.5,109.5c0,60.5-49,109.5-109.5,109.5c-60.5,0-109.5-49-109.5-109.5C9.6,58.6,58.6,9.6,119,9.6z"/>
                                                <g>
                                                    <g>
                                                        <polygon fill-rule="evenodd" clip-rule="evenodd" fill="#3A4A5E" points="176,113 125.1,113 125.1,62.1 113,62.1 113,113 62,113
                                                            62,125.1 113,125.1 113,176 125.1,176 125.1,125.1 176,125.1      "/>
                                                    </g>
                                                </g>
                                            </svg>
                                        </label>
                                        <div id="photos-block_result_{$i}" class="photos-block_result"></div>
                                        
                                        {if $i == 0}<span>Главное фото</span>{/if}
                                    </div>
                                {/for}
                            </div>
                        </div>
                    {/if}
                    <div class="text-center">
                        <button class="btn-add" type="submit" disabled>
                            <svg version="1.1" class="btn-add_left" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 viewBox="0 0 366.9 306.5" enable-background="new 0 0 366.9 306.5" xml:space="preserve">
                    <path fill="#fff" fill-rule="evenodd" clip-rule="evenodd" d="M32.9,243.8H2.6v-8.3h43v7.1l-31.3,38.1v0.2H46v8.4H1.6v-7L32.9,244V243.8
                        L32.9,243.8z M90.6,289.3h-7.9v-5.5c-3.4,4.1-7.9,6.1-13.6,6.1c-4.3,0-7.8-1.2-10.6-3.6c-2.8-2.4-4.2-5.6-4.2-9.7
                        c0-4,1.5-7.1,4.5-9.1c3-2,7-3,12.1-3H82V263c0-5.4-3-8.2-9.1-8.2c-3.8,0-7.8,1.4-11.9,4.2l-3.9-5.4c5-4,10.6-5.9,17-5.9
                        c4.8,0,8.8,1.2,11.8,3.7c3.1,2.4,4.6,6.3,4.6,11.5V289.3L90.6,289.3z M82,274.1v-3.5h-9.7c-6.2,0-9.3,2-9.3,5.9c0,2,0.8,3.5,2.3,4.6
                        c1.5,1.1,3.7,1.6,6.4,1.6c2.7,0,5.2-0.8,7.2-2.3C80.9,278.8,82,276.7,82,274.1L82,274.1z M129.6,281.1c3.1,0,5.8-0.5,8.1-1.6
                        c2.3-1.1,4.6-2.7,7.1-5l5.9,6c-5.7,6.3-12.6,9.5-20.8,9.5c-8.1,0-14.9-2.6-20.3-7.9c-5.4-5.2-8.1-11.9-8.1-19.9s2.7-14.7,8.2-20
                        c5.5-5.3,12.4-8,20.7-8s15.3,3.1,20.9,9.2l-5.8,6.3c-2.6-2.5-5-4.2-7.3-5.2c-2.3-1-5-1.5-8.1-1.5c-5.4,0-10,1.8-13.7,5.3
                        c-3.7,3.5-5.5,8-5.5,13.5c0,5.5,1.8,10,5.5,13.7C120.2,279.2,124.6,281.1,129.6,281.1L129.6,281.1z M183.2,256.4
                        c-4.3,0-7.5,1.4-9.6,4.2c-2.2,2.8-3.2,6.5-3.2,11.2v17.6h-8.6v-41h8.6v8.2c1.4-2.6,3.3-4.7,5.7-6.3c2.4-1.6,4.9-2.5,7.6-2.5l0.1,8.7
                        C183.5,256.4,183.3,256.4,183.2,256.4L183.2,256.4z M198.6,305.7c-3.8,0-7.1-1.4-10.2-4.1l3.9-7c1.8,1.7,3.7,2.5,5.6,2.5
                        c1.9,0,3.5-0.7,4.7-2.1c1.2-1.4,1.8-2.9,1.8-4.5c0-0.7-5.5-14.8-16.6-42.2h9.2l12.3,30.2l12.3-30.2h9.2L211,297
                        c-1.2,2.7-2.9,4.8-5.1,6.3C203.7,304.9,201.3,305.7,198.6,305.7L198.6,305.7z M260.8,247.7c5.5,0,10.2,1.9,14.1,5.7
                        c3.9,3.8,5.9,8.9,5.9,15.2S278.8,280,275,284c-3.9,4-8.4,5.9-13.6,5.9s-9.8-2.3-13.9-6.8v21.1h-8.6v-55.9h8.6v7.2
                        C250.9,250.3,255.3,247.7,260.8,247.7L260.8,247.7z M247.3,268.9c0,3.9,1.2,7.1,3.5,9.6c2.4,2.5,5.2,3.7,8.6,3.7s6.3-1.2,8.9-3.7
                        c2.5-2.5,3.8-5.7,3.8-9.6c0-3.9-1.2-7.2-3.7-9.8c-2.5-2.6-5.4-3.9-8.9-3.9c-3.4,0-6.3,1.3-8.7,3.9
                        C248.5,261.7,247.3,265,247.3,268.9L247.3,268.9z M302.5,255.3v20.8c0,2,0.5,3.5,1.5,4.7c1,1.2,2.5,1.7,4.3,1.7
                        c1.8,0,3.6-0.9,5.3-2.7l3.5,6.1c-3,2.7-6.4,4.1-10.1,4.1c-3.7,0-6.8-1.3-9.4-3.8c-2.6-2.5-3.9-6-3.9-10.3v-20.6h-5.2v-6.9h5.2v-12.9
                        h8.6v12.9h10.8v6.9H302.5L302.5,255.3z M334.5,278.5c2.4,2.5,5.5,3.7,9.3,3.7c3.8,0,6.8-1.2,9.3-3.7c2.4-2.5,3.7-5.7,3.7-9.7
                        c0-4-1.2-7.2-3.7-9.7c-2.4-2.5-5.5-3.7-9.3-3.7c-3.8,0-6.8,1.2-9.3,3.7c-2.4,2.5-3.7,5.7-3.7,9.7C330.8,272.8,332.1,276,334.5,278.5
                        L334.5,278.5z M359.2,283.8c-4.1,4.1-9.2,6.1-15.4,6.1c-6.2,0-11.3-2-15.4-6.1c-4.1-4.1-6.2-9.1-6.2-15c0-5.9,2.1-10.9,6.2-15
                        c4.1-4.1,9.2-6.1,15.4-6.1c6.2,0,11.3,2,15.4,6.1c4.1,4.1,6.2,9.1,6.2,15C365.4,274.7,363.3,279.7,359.2,283.8z"/>
                                <g id="заливка">
                                    <circle fill="#FFFFFF" cx="182.5" cy="107" r="94"/>
                                </g>
                                <linearGradient id="SVGID_1_" gradientUnits="userSpaceOnUse" x1="83.3569" y1="132.4621" x2="202.9493" y2="12.8697">
                                    <stop  offset="0" style="stop-color:#74B3C9"/>
                                    <stop  offset="1" style="stop-color:#83CCA8"/>
                                </linearGradient>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="url(#SVGID_1_)" d="M209,5.5c7.6,20.8,11.2,42.3,11.2,63.6
                        c-30.9,0.9-61.2,9.5-88.1,25c-18.4,10.6-35.2,24.6-49.4,41.5c-4.9-17.1-5.5-35.7-0.8-54.2C96.1,25.3,153-8.7,209,5.5z"/>
                                <linearGradient id="SVGID_2_" gradientUnits="userSpaceOnUse" x1="142.8249" y1="185.0545" x2="181.3025" y2="146.5768">
                                    <stop  offset="0" style="stop-color:#437085"/>
                                    <stop  offset="1" style="stop-color:#23465F"/>
                                </linearGradient>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="url(#SVGID_2_)" d="M197.9,157.8c18.4,10.6,38.9,18.2,60.7,22
                        c-25.2,25.9-63.1,38.1-100.7,28.6c-37.6-9.5-65.2-38.1-75.1-72.9c14.2-16.9,31-30.9,49.4-41.5c4.2,6.8,8.8,13.3,13.8,19.5
                        l-26.5,26.5c-3.1,3.1-3.1,8.2,0,11.3l0,0c3.1,3.1,8.2,3.1,11.3,0l25.8-25.8c2.8,2.9,5.6,5.6,8.5,8.3l-11.5,11.5
                        c-3.1,3.1-3.1,8.2,0,11.3l0,0c3.1,3.1,8.2,3.1,11.3,0l12.5-12.5C183.9,149.2,190.8,153.7,197.9,157.8z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="#234557" d="M132.2,94.1c4.2,6.8,8.8,13.3,13.9,19.5l-5.8,5.8
                        c-32.9,0.7-57.4,16.3-57.5,16.2C96.9,118.6,113.8,104.7,132.2,94.1z"/>
                                <linearGradient id="SVGID_3_" gradientUnits="userSpaceOnUse" x1="190.9279" y1="135.5302" x2="255.2277" y2="71.2304">
                                    <stop  offset="0" style="stop-color:#467388"/>
                                    <stop  offset="1" style="stop-color:#85C9A1"/>
                                </linearGradient>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="url(#SVGID_3_)" d="M209,5.5c37.6,9.5,65.2,38.2,75.1,72.9
                        c4.9,17.1,5.5,35.7,0.8,54.2c-4.7,18.5-14,34.6-26.4,47.3c-21.8-3.8-42.2-11.4-60.7-22c14.7-27.3,22.4-57.8,22.4-88.8
                        C220.2,47.8,216.6,26.2,209,5.5z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="#5A9685" d="M209,5.5c7.6,20.8,11.2,42.3,11.2,63.6
                        c-10.4,0.3-20.7,1.5-30.8,3.5C209.8,43.4,209,6.4,209,5.5C209,5.5,209,5.5,209,5.5z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="#38616F" d="M258.6,179.9c-21.8-3.8-42.2-11.4-60.7-22
                        c4.8-8.9,8.9-18.2,12.1-27.7C227.2,162.3,258.6,179.9,258.6,179.9z"/>
                    </svg>
                            Готово!
                            <svg version="1.1" class="btn-add_right" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 viewBox="0 0 366.9 306.5" enable-background="new 0 0 366.9 306.5" xml:space="preserve">
                    <path fill="#fff" fill-rule="evenodd" clip-rule="evenodd" d="M32.9,243.8H2.6v-8.3h43v7.1l-31.3,38.1v0.2H46v8.4H1.6v-7L32.9,244V243.8
                        L32.9,243.8z M90.6,289.3h-7.9v-5.5c-3.4,4.1-7.9,6.1-13.6,6.1c-4.3,0-7.8-1.2-10.6-3.6c-2.8-2.4-4.2-5.6-4.2-9.7
                        c0-4,1.5-7.1,4.5-9.1c3-2,7-3,12.1-3H82V263c0-5.4-3-8.2-9.1-8.2c-3.8,0-7.8,1.4-11.9,4.2l-3.9-5.4c5-4,10.6-5.9,17-5.9
                        c4.8,0,8.8,1.2,11.8,3.7c3.1,2.4,4.6,6.3,4.6,11.5V289.3L90.6,289.3z M82,274.1v-3.5h-9.7c-6.2,0-9.3,2-9.3,5.9c0,2,0.8,3.5,2.3,4.6
                        c1.5,1.1,3.7,1.6,6.4,1.6c2.7,0,5.2-0.8,7.2-2.3C80.9,278.8,82,276.7,82,274.1L82,274.1z M129.6,281.1c3.1,0,5.8-0.5,8.1-1.6
                        c2.3-1.1,4.6-2.7,7.1-5l5.9,6c-5.7,6.3-12.6,9.5-20.8,9.5c-8.1,0-14.9-2.6-20.3-7.9c-5.4-5.2-8.1-11.9-8.1-19.9s2.7-14.7,8.2-20
                        c5.5-5.3,12.4-8,20.7-8s15.3,3.1,20.9,9.2l-5.8,6.3c-2.6-2.5-5-4.2-7.3-5.2c-2.3-1-5-1.5-8.1-1.5c-5.4,0-10,1.8-13.7,5.3
                        c-3.7,3.5-5.5,8-5.5,13.5c0,5.5,1.8,10,5.5,13.7C120.2,279.2,124.6,281.1,129.6,281.1L129.6,281.1z M183.2,256.4
                        c-4.3,0-7.5,1.4-9.6,4.2c-2.2,2.8-3.2,6.5-3.2,11.2v17.6h-8.6v-41h8.6v8.2c1.4-2.6,3.3-4.7,5.7-6.3c2.4-1.6,4.9-2.5,7.6-2.5l0.1,8.7
                        C183.5,256.4,183.3,256.4,183.2,256.4L183.2,256.4z M198.6,305.7c-3.8,0-7.1-1.4-10.2-4.1l3.9-7c1.8,1.7,3.7,2.5,5.6,2.5
                        c1.9,0,3.5-0.7,4.7-2.1c1.2-1.4,1.8-2.9,1.8-4.5c0-0.7-5.5-14.8-16.6-42.2h9.2l12.3,30.2l12.3-30.2h9.2L211,297
                        c-1.2,2.7-2.9,4.8-5.1,6.3C203.7,304.9,201.3,305.7,198.6,305.7L198.6,305.7z M260.8,247.7c5.5,0,10.2,1.9,14.1,5.7
                        c3.9,3.8,5.9,8.9,5.9,15.2S278.8,280,275,284c-3.9,4-8.4,5.9-13.6,5.9s-9.8-2.3-13.9-6.8v21.1h-8.6v-55.9h8.6v7.2
                        C250.9,250.3,255.3,247.7,260.8,247.7L260.8,247.7z M247.3,268.9c0,3.9,1.2,7.1,3.5,9.6c2.4,2.5,5.2,3.7,8.6,3.7s6.3-1.2,8.9-3.7
                        c2.5-2.5,3.8-5.7,3.8-9.6c0-3.9-1.2-7.2-3.7-9.8c-2.5-2.6-5.4-3.9-8.9-3.9c-3.4,0-6.3,1.3-8.7,3.9
                        C248.5,261.7,247.3,265,247.3,268.9L247.3,268.9z M302.5,255.3v20.8c0,2,0.5,3.5,1.5,4.7c1,1.2,2.5,1.7,4.3,1.7
                        c1.8,0,3.6-0.9,5.3-2.7l3.5,6.1c-3,2.7-6.4,4.1-10.1,4.1c-3.7,0-6.8-1.3-9.4-3.8c-2.6-2.5-3.9-6-3.9-10.3v-20.6h-5.2v-6.9h5.2v-12.9
                        h8.6v12.9h10.8v6.9H302.5L302.5,255.3z M334.5,278.5c2.4,2.5,5.5,3.7,9.3,3.7c3.8,0,6.8-1.2,9.3-3.7c2.4-2.5,3.7-5.7,3.7-9.7
                        c0-4-1.2-7.2-3.7-9.7c-2.4-2.5-5.5-3.7-9.3-3.7c-3.8,0-6.8,1.2-9.3,3.7c-2.4,2.5-3.7,5.7-3.7,9.7C330.8,272.8,332.1,276,334.5,278.5
                        L334.5,278.5z M359.2,283.8c-4.1,4.1-9.2,6.1-15.4,6.1c-6.2,0-11.3-2-15.4-6.1c-4.1-4.1-6.2-9.1-6.2-15c0-5.9,2.1-10.9,6.2-15
                        c4.1-4.1,9.2-6.1,15.4-6.1c6.2,0,11.3,2,15.4,6.1c4.1,4.1,6.2,9.1,6.2,15C365.4,274.7,363.3,279.7,359.2,283.8z"/>
                                <g id="заливка">
                                    <circle fill="#FFFFFF" cx="182.5" cy="107" r="94"/>
                                </g>
                                <linearGradient id="SVGID_1_" gradientUnits="userSpaceOnUse" x1="83.3569" y1="132.4621" x2="202.9493" y2="12.8697">
                                    <stop  offset="0" style="stop-color:#74B3C9"/>
                                    <stop  offset="1" style="stop-color:#83CCA8"/>
                                </linearGradient>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="url(#SVGID_1_)" d="M209,5.5c7.6,20.8,11.2,42.3,11.2,63.6
                        c-30.9,0.9-61.2,9.5-88.1,25c-18.4,10.6-35.2,24.6-49.4,41.5c-4.9-17.1-5.5-35.7-0.8-54.2C96.1,25.3,153-8.7,209,5.5z"/>
                                <linearGradient id="SVGID_2_" gradientUnits="userSpaceOnUse" x1="142.8249" y1="185.0545" x2="181.3025" y2="146.5768">
                                    <stop  offset="0" style="stop-color:#437085"/>
                                    <stop  offset="1" style="stop-color:#23465F"/>
                                </linearGradient>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="url(#SVGID_2_)" d="M197.9,157.8c18.4,10.6,38.9,18.2,60.7,22
                        c-25.2,25.9-63.1,38.1-100.7,28.6c-37.6-9.5-65.2-38.1-75.1-72.9c14.2-16.9,31-30.9,49.4-41.5c4.2,6.8,8.8,13.3,13.8,19.5
                        l-26.5,26.5c-3.1,3.1-3.1,8.2,0,11.3l0,0c3.1,3.1,8.2,3.1,11.3,0l25.8-25.8c2.8,2.9,5.6,5.6,8.5,8.3l-11.5,11.5
                        c-3.1,3.1-3.1,8.2,0,11.3l0,0c3.1,3.1,8.2,3.1,11.3,0l12.5-12.5C183.9,149.2,190.8,153.7,197.9,157.8z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="#234557" d="M132.2,94.1c4.2,6.8,8.8,13.3,13.9,19.5l-5.8,5.8
                        c-32.9,0.7-57.4,16.3-57.5,16.2C96.9,118.6,113.8,104.7,132.2,94.1z"/>
                                <linearGradient id="SVGID_3_" gradientUnits="userSpaceOnUse" x1="190.9279" y1="135.5302" x2="255.2277" y2="71.2304">
                                    <stop  offset="0" style="stop-color:#467388"/>
                                    <stop  offset="1" style="stop-color:#85C9A1"/>
                                </linearGradient>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="url(#SVGID_3_)" d="M209,5.5c37.6,9.5,65.2,38.2,75.1,72.9
                        c4.9,17.1,5.5,35.7,0.8,54.2c-4.7,18.5-14,34.6-26.4,47.3c-21.8-3.8-42.2-11.4-60.7-22c14.7-27.3,22.4-57.8,22.4-88.8
                        C220.2,47.8,216.6,26.2,209,5.5z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="#5A9685" d="M209,5.5c7.6,20.8,11.2,42.3,11.2,63.6
                        c-10.4,0.3-20.7,1.5-30.8,3.5C209.8,43.4,209,6.4,209,5.5C209,5.5,209,5.5,209,5.5z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="#38616F" d="M258.6,179.9c-21.8-3.8-42.2-11.4-60.7-22
                        c4.8-8.9,8.9-18.2,12.1-27.7C227.2,162.3,258.6,179.9,258.6,179.9z"/>
                    </svg>
                        </button>
                        {if !$edit_mode}
                            <div class="btn-add_text">
                                Ваше объявление будет размещено после модерации администрацией ZaCrypto
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="col-xs-offset-1 col-xs-2 create-ad__adv">
                    <div class="advertising_pages">
                    <div class="advertising-item">
                        {if !empty($adsBlock9)}
                            {$adsBlock9}
                        {else}
                            <div class="advertising-item_head text-center">
                                <span>Номер 8-800</span>
                                <img src="img/r-icon.png" alt="">
                                <p>без абонентской<br> платы</p>
                            </div>
                            <div class="advertising-item_foot">
                                <b>Номер 8800 от Ростелекома</b>
                                <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                            </div>                        
                        {/if}
                    </div>
                    <div class="advertising-item">
                        {if !empty($adsBlock10)}
                            {$adsBlock10}
                        {else}
                            <div class="advertising-item_head text-center">
                                <span>Номер 8-800</span>
                                <img src="img/r-icon.png" alt="">
                                <p>без абонентской<br> платы</p>
                            </div>
                            <div class="advertising-item_foot">
                                <b>Номер 8800 от Ростелекома</b>
                                <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                            </div>                        
                        {/if}
                    </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<div id="tooltip-container">
    <div id="tooltip-new"></div>
</div>
{include file='elements/main/footer.tpl'}