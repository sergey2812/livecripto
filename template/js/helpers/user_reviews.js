searchTypes = [
    {id: 0, text: 'новизне'},
    {id: 1, text: '<div class="stars" style="display: inline-block; vertical-align: text-top"><i class="star"></i><i class="star"></i><i class="star"></i><i class="star"></i><i class="star"></i></div>'},
    {id: 2, text: '<div class="score" style="display: inline-block; vertical-align: text-top"><i class="icon-like"></i></div>'},
    {id: 3, text: '<div class="score" style="display: inline-block; vertical-align: text-top"><i class="icon-dislike"></i></div>'},
];

$(function () {
    function formatOption(option) {
        if (!option.id) {
            return option.text;
        }
        return $(
            '<span>' + option.text + '</span>'
        );
    }
    function formatSelected(option) {
        if (!option.id) {
            return option.text;
        }
        return $.parseHTML(option.text);
    }

    const select = $('select[name="reviews_filter"]');

    select.select2({
        data: searchTypes,
        minimumResultsForSearch: -1,
        templateResult: formatOption,
        templateSelection: formatSelected
    });

    select.on('change', function () {
        const searchType = $(this).val(); //0 новизна, 1 рейтинг, 2 лайки, 3 дизлайки
        const parentDiv = $(this).closest('.reviews-popup').find('.reviews-popup_body');

        let divList = parentDiv.find('.reviews-item');
        divList.sort(function(a, b){
            if (searchType == '0') {
                return $(b).data('date')-$(a).data('date')
            } else if(searchType == '1') {
                return $(b).data('rating')-$(a).data('rating')
            } else if(searchType == '2') {
                return $(b).data('like')-$(a).data('like')
            } else if(searchType == '3') {
                return $(a).data('like')-$(b).data('like')
            }
        });

        parentDiv.html(divList);
    });
});