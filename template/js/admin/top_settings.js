$(function(){

    function UpdateType(input, type) {
        let input_info = input.attr('name').split('_');
        input_info[2] = type;
        let new_name = input_info.join('_');
        input.attr('name', new_name);
    }

    $(".top_price_input").on('change', function () {

        let input_info = $(this).attr('name').split('_');

    });

    $(".top_price_type").on('change', function () {

        let value = $(this).val();
        let input = $(this).closest('.price_line').find('input.top_price_input');

        UpdateType(input, value);

    });

    $(".accept_to_childs").on('click', function () {

        let childs = $(this).data('childs');
        let parent_block = $(this).closest('.price_block');

        let prices = [];

        parent_block.find('.price_line').each(function () {

            let object = {};

            let price = $(this).find('input.top_price_input').val();
            let type = $(this).find('select.top_price_type').val();

            object.price = price;
            object.type = type;

            prices.push(object);

        });

        $(childs).each(function () { //each .price_block

            $(this).find('.price_line').each(function (index) { //each .price_line

                let input = $(this).find('input.top_price_input');
                let select = $(this).find('select.top_price_type');

                UpdateType(input, prices[index].type);
                input.val(prices[index].price);
                select.val(prices[index].type);

            })

        });

    });

    $(".add_new_price").on('click', function () {

        let parent_div = $(this).closest('.price_block');
        let last_div = parent_div.find('.price_line').last();

        let div = last_div.clone();

        last_div.after(div);

    })

});