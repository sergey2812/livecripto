$(function () {

    $(".show_hiden_text").on('click', function (e) {

        e.preventDefault();

       let text = $(this).data('text');
       let target = $(this).data('target');
       target = $(target);

       target.text(text);
       $(this).remove();

    });

});