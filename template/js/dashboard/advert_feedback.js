$(function () {

    let form = $("#review");

    $('.open_feedback').on('click', function () {

        let id = $(this).data('deal_id');

        modal.find('.deal_hook').empty();

        $.ajax({
            url: '/ajax/adverts/get_deal_feedback.php',
            type: 'POST',
            dataType: 'json',
            data: {id: id},
        })
            .done(function(data) {
                if (data.ok === true){
                    modal.find('.like_type').text((data.result.like == 1) ? glossary.dashboard.advert_feedback[0] : glossary.dashboard.advert_feedback[1]);
                    modal.find('.rating').text(data.result.rating);
                    modal.find('.comment').text(data.result.text);
                }
            })
            .fail(function() {
                console.log("error");
            })
            .always(function(data) {
                console.log(data);
            });

    });

    $('.add_review').on('click', function () {
        let dealId = $(this).data('deal_id');

        form.empty();

        $.ajax({
        	url: '/ajax/reviews/get_add_review_modal.php',
        	type: 'POST',
        	dataType: 'html',
        	data: {deal_id: dealId},
        })
        .done(function(data) {
            form.html(data);
        })
        .fail(function(data) {
            form.html(data);
        });
    });

    $('.show-comment').on('click', function () {
        let modal = $('#show_review');

        let comment = $(this).data('text');
        let like = $(this).data('like');
        let rating = $(this).data('rating');
        let to = $(this).data('to');
        let from = $(this).data('from');
        let avatar = $(this).data('avatar');
        let color = $(this).data('avatar-color');

        modal.find('.reviews-popup_head-title span').text(to);

        modal.find('.reviews-item p.comment').text(comment);
        modal.find('.reviews-item .name').text(from);
        modal.find('.reviews-item .avatar img').attr('src', '/files/' + avatar);
        modal.find('.reviews-item .avatar').css({'background-color': '#' + color});

        let likeDiv = modal.find('.reviews-item .score');
        likeDiv.empty();
        if (like == '1') {
            likeDiv.append('<i class="icon-like"></i>');
        } else{
            likeDiv.append('<i class="icon-dislike"></i>');
        }
    })

});