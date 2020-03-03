$(function()
    {                

        $("#location_country").on('change', function() 
          {         
            let country_select = $("#location_country").val();
              
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
                        $('#city-new-add').removeClass("required");
                    }
                else
                    {
                        $('#city-new-add').prop("disabled", false);   //поле для добавления нового города
                        $('#city-new-add').addClass('required-field'); 
                        $('#city-new-add').addClass('required');
                        $('#city-new-add').prop("required", true);
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
    })  