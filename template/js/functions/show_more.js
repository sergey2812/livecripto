$(function(){

    $('.show_more').on('submit', function (e) {
        e.preventDefault();

        let button = $(this).find('button');       
        let page_input = $(this).find("input[name='page']");
        let page = parseInt(page_input.val()) + 1;

        
        
          $(".show_more").animate({ bottom: "-1.15%" }, 3000 );
        

        $.ajax({
            url: '/ajax/adverts/get_next_adverts.php',
            type: 'POST',
            dataType: 'html',
            data: $(this).serialize(),
        })
            .done(function(data) {
                if (data === ''){
                    button.remove();
                } else{
                    $('.items-append-here').append(data);
                    page_input.val(page);

                    let hgtHomeAdv = $('.obj-body').height();
                    $('.obj-info').css({"height":hgtHomeAdv-125});
                    $('.obj-filter').css({ "height": hgtHomeAdv});
                }
            })
            .fail(function(data) {
                console.log(data);
            })
            .always(function(data) {
                //console.log(data);
            });

    });
});