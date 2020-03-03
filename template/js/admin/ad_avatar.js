$(function () {

    let html_area = $("#html_code");
    let preview = $("#preview_block_avatar");
    let image = null;
    let link_url = null;

    if (preview.find('a').length > 0) {
        link_url = preview.find('a').attr('href');
        image = preview.find('img').attr('src');
        image = image.split('/');
        image = image[image.length - 1];
    }

    function HtmlImage(filename) {

        if (preview.hasClass('edit'))
            {
                html_area.val('<div class="profiles-avatar"><img src="/files/avatars/'+filename+'"></div>');
            } 
        else
            {
                html_area.val('<img src="/files/avatars/'+filename+'">');
            }
        
        preview.empty();
        preview.append(html_area.val());
        html_area.val('avatars/'+filename);
    }

    $(document).on('change', 'input.image_upload[type="file"]', function () {

        let data = new FormData();
        data.append('photo', $(this)[0].files[0]);

        $.ajax({
            url: '/ajax/files/upload_avatar.php',
            type: 'POST',
            dataType: 'json',
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            data: data,
        })
            .done(function(data) {
                if (data.ok === true && data.result !== undefined && data.result.filename !== undefined) {
                    HtmlImage(data.result.filename);
                } else{
                    if (data.error !== undefined) {
                        alert(data.error);
                    } else{
                        alert('Произошла неизвестная ошибка при загрузке файла');
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