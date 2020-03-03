$(function () {
    $(".sort_selector").on('change', function (){
        let sort = $(this).val();

        let url = new URL(location.href);
        url.searchParams.set('sort', sort);

        location.href = url.href;
    });
});