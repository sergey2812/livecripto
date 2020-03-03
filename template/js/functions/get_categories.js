function getData(type, value) {
    return $.ajax({
        url: '/ajax/sections/get_' + type + '.php',
        type: 'POST',
        dataType: 'JSON',
        data: { id: value },
    });
}
$(function () {

    $('.section_select, .category_select').on('change', function () 
    {

        if ($(this).val() !== '' || $(this).val() !== undefined)
            {

                $(this).removeAttr('style');

                let target = $($(this).data('target'));
                let type = $(this).data('type');
                let value = $(this).val();

                if (value > 0){

                    getData(type, value)
                        .done(function(data) {
                            target.find('option').remove();
                            if (data.ok === true && data.result !== undefined) {

                                if (type === 'categories'){
                                    let subcats_select = target.data('target');
                                    if (subcats_select !== undefined) {
                                        $(subcats_select).find('option').remove();
                                        //$(subcats_select).append('<option value="">'+ glossary.functions.get_categories[1] +'</option>');
                                    }
                                }

                                target.find('option').remove();
                                target.append('<option value="" selected disabled>' + glossary.functions.get_categories[1] + '</option>');
                                data.result.forEach(function (item) {
                                    target.append('<option value="'+item.id+'">'+item.name+'</option>');
                                });
                            } else{
                                if (data.error !== undefined) {
                                    alert(data.error);
                                } else{
                                    alert(glossary.functions.get_categories[0]);
                                }
                            }
                        })
                        .fail(function() {
                            console.log("error");
                        })
                        .always(function(data) {
                            console.log(data);
                        });
                } else{

                    if (type === 'categories'){
                        let subcats_select = target.data('target');
                        if (subcats_select !== undefined) {
                            $(subcats_select).find('option').remove();
                            $(subcats_select).append('<option value="">'+ glossary.functions.get_categories[1] +'</option>');
                        }
                    }
                    target.find('option').remove();
                }

            } 
        else
            {
                $(this).css('border', '1px solid red');
            }

    });    

    $('.obj-filter-block_body.section-filter, .obj-filter-block_body.category-filter, .obj-filter-block_body.subcategory-filter').on('change', 'input[type="radio"]', function () 
    {

        if ($(this).closest('.obj-filter-block_body').hasClass('section-filter')) 
            {               
                if ($(this).is(':checked'))
                    {     
                        $("#category_block").css("display", "block");
                    }
                else
                    {
                        $("#category_block").css("display", "none");
                        $("#subcategory_block").css("display", "none");
                    }

                $('.obj-filter-block_body.category-filter').empty();
                $('.obj-filter-block_body.subcategory-filter').empty();                    
            }
        
        if ($(this).closest('.obj-filter-block_body').hasClass('category-filter')) 
            {
                if ($(this).is(':checked'))
                    {     
                        $("#subcategory_block").css("display", "block");
                    }
                else
                    {
                        $("#subcategory_block").css("display", "none");
                    }                

                $('.obj-filter-block_body.subcategory-filter').empty();
            }

        let div = $(this).closest('.obj-filter-block_body');
        let value = $(this).val();
        let type = div.data('type');
        let target = $('#' + div.data('target'));

        div.find('input').removeClass('checked');

        if (value !== '' && value !== undefined && $(this).is(':checked'))
            {
                $(this).addClass('checked');
                getData(type, value)
                    .done(function(data) {
                        target.empty();

                        if (data.ok === true && data.result !== undefined) {

                            let name = (type === 'categories') ? 'category' : 'subcategory';

                            data.result.forEach(function (item) {
                                target.append('<div><input type="radio" name="'+name+'" value="'+item.id+'"><label>'+item.name+'</label></div>');
                            });
                        }
                    })
                    .fail(function() {
                        console.log("error");                        
                    })
                    .always(function(data) {
                        console.log(data);
                    });
            }

            
            $('.obj-filter-block_body.section-filter > div, .obj-filter-block_body.category-filter > div, .obj-filter-block_body.subcategory-filter > div').on('click', function () 
            {
                let input = $(this).find('input');
               
                if (input.hasClass('checked') && input.is(':checked')) 
                    {
                        input.removeClass('checked');
                        input.prop('checked', false);
                        input.trigger('change');
                    }

            });                       
    });
});