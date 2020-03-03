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
    let history_selects_num = [];

    let bs_selects_val = []; 
    let bs_selects_data = []; 
    let bs_selects_text = [];    

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

            let type = $(this).val();

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

                    selectors.closest('.form-row').next().find('select').prop('disabled', true);
                    selectors.closest('.form-row').next().addClass('blocked'); 

                            $(this).find('option').each(function () 
                                {
                                    let value = $(this).attr('value');

                                    if (type !== '1') 
                                        {
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
                                                            if($(this).val() !== bs_selects_val[i])
                                                                {
                                                                    selectors.append($('<option value="' + bs_selects_val[i] + '" data-image="' + bs_selects_data[i] + '">' + bs_selects_text[i] + '</option>'));
                                                                }
                                                        }
                                                    bs_selects_val = []; 
                                                    bs_selects_data = []; 
                                                    bs_selects_text = [];
                                                }

                                            $(this).prop('disabled', false);              
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
                }
            
            if (history_selects_val[num_current+2] != '' && history_selects_val[num_current+2] != null && history_selects_val[num_current+2] !== undefined)
                {
                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+2] + '">' + history_selects_text[num_current+2] + '</option>'));
                    
                    history_selects_val.splice($.inArray(history_selects_val[num_current+2], history_selects_val), 1); // это удаление элемент массива                      
                    history_selects_data.splice($.inArray(history_selects_data[num_current+2], history_selects_data), 1);
                    history_selects_text.splice($.inArray(history_selects_text[num_current+2], history_selects_text), 1);
                }

            if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                {
                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                    
                    history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                    history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                    history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                }

            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                {
                    $('#crypto_1 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));

                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
                }

            history_selects_val = []; 
            history_selects_data = []; 
            history_selects_text = []; 

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
                                       
                                    $('#crypto_1 option[value=' + history_selects_val[num_current] + ']').remove();
                                    $('#crypto_2 option[value=' + history_selects_val[num_current] + ']').remove();
                                    $('#crypto_3 option[value=' + history_selects_val[num_current] + ']').remove();

                                    $('#crypto_0').prop("disabled", true); 
                                }                             
                        }
                    else
                        {
                            $('#crypto_0').prop("disabled", false);

                            if (history_selects_val[num_current+3] != '' && history_selects_val[num_current+3] != null && history_selects_val[num_current+3] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+3]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+2] + '">' + history_selects_text[num_current+2] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+3], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+3], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+3], history_selects_text), 1);
                                }

                            if (history_selects_val[num_current+2] != '' && history_selects_val[num_current+2] != null && history_selects_val[num_current+2] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+2]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+2] + '">' + history_selects_text[num_current+2] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+2], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+2], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+2], history_selects_text), 1);
                                }

                            if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+1]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                                }

                            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_1 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));

                                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
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
                                      
                                    $('#crypto_2 option[value=' + history_selects_val[num_current] + ']').remove();
                                    $('#crypto_3 option[value=' + history_selects_val[num_current] + ']').remove();

                                    $('#crypto_1').prop("disabled", true); 
                                }                             
                        }
                    else
                        {
                            $('#crypto_1').prop("disabled", false);
                            
                            if (history_selects_val[num_current+2] != '' && history_selects_val[num_current+2] != null && history_selects_val[num_current+2] !== undefined)
                                {   
                                    delete wallets[history_selects_val[num_current+2]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    history_selects_val.splice($.inArray(history_selects_val[num_current+2], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+2], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+2], history_selects_text), 1);
                                }

                            if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+1]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current+1] + '" data-image="' + history_selects_data[num_current+1] + '">' + history_selects_text[num_current+1] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                                }

                            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_2 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
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
                                      
                                    $('#crypto_3 option[value=' + history_selects_val[num_current] + ']').remove();

                                    $('#crypto_2').prop("disabled", true); 
                                }                             
                        }
                 
                    else
                        {
                            $('#crypto_2').prop("disabled", false);
                            
                            if (history_selects_val[num_current+1] != '' && history_selects_val[num_current+1] != null && history_selects_val[num_current+1] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current+1]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    history_selects_val.splice($.inArray(history_selects_val[num_current+1], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current+1], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current+1], history_selects_text), 1);
                                }

                            if (history_selects_val[num_current] != '' && history_selects_val[num_current] != null && history_selects_val[num_current] !== undefined)
                                {
                                    delete wallets[history_selects_val[num_current]];
                                    $('input[name="prices"]').val(JSON.stringify(wallets));

                                    $('#crypto_3 :first').after($('<option value="' + history_selects_val[num_current] + '" data-image="' + history_selects_data[num_current] + '">' + history_selects_text[num_current] + '</option>'));
                                    
                                    history_selects_val.splice($.inArray(history_selects_val[num_current], history_selects_val), 1); // это удаление элемент массива                      
                                    history_selects_data.splice($.inArray(history_selects_data[num_current], history_selects_data), 1);
                                    history_selects_text.splice($.inArray(history_selects_text[num_current], history_selects_text), 1);
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
                                }
                            
                        }
                });

         
})
