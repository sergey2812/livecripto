$(function () {

    $('.add_to_favorites').on('click', function (event) {

        event.preventDefault();

        let button = $(this);

        let counter = button.find('.counter');
        let count = parseInt(counter.text());

        let advert_id = button.data('advert_id');

        let show_alert = $(this).hasClass('show_alert');

        $.ajax({
            url: '/ajax/adverts/toggle_favorite_advert.php',
            type: 'POST',
            dataType: 'json',
            data: { id: advert_id },
        })
        .done(function(data) {
            if (data.ok === true) {
                if (show_alert) {
                    if (data.result.status === 1){
                        alert(glossary.functions.add_to_favorites[0]);
                    } else{
                        alert(glossary.functions.add_to_favorites[1]);
                    }
                } else{
                    if (data.result.status === 1){
                        button.find('i').addClass('filled');
                        counter.text(count + 1);
                    } else{
                        button.find('i').removeClass('filled');
                        counter.text(count - 1);
                    }

                    $(".head-profile_fav span").text(data.result.count);
                }
            } else{
                if (data.error !== undefined) {
                    alert(data.error);
                } else{
                    alert(glossary.functions.add_to_favorites[2]);
                }
            } 
        })
        .fail(function() {
            console.log("error");
        })
        .always(function(data) {
            console.log(data);
            
        });

    });

});