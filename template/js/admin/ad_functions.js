$(function () {

    let html_area = $("#html_code");
    let preview = $("#preview_block");
    let image = null;
    let link_url = null;

    if (preview.find('a').length > 0) {
        link_url = preview.find('a').attr('href');
        image = preview.find('img').attr('src');
        image = image.split('/');
        image = image[image.length - 1];
    }

    function UpdateHtml() {
        preview.empty();
        preview.append(html_area.val());
    }

    function HtmlImage(filename) {
        image = filename;
        if (link_url === null || link_url === ''){
            html_area.val('<img src="/files/'+image+'">');
        } else{
            html_area.val('<a href="'+link_url+'" target="_blank"><img src="/files/'+image+'"></a>');
        }

        UpdateHtml();
    }

    function HtmlLink(link) {
        link_url = link;
        if (link_url === null || link_url === ''){
            html_area.val('<img src="/files/'+image+'">');
        } else{
            html_area.val('<a href="'+link_url+'" target="_blank"><img src="/files/'+image+'"></a>');
        }
        UpdateHtml();
    }

    $(document).on('change', 'input.image_upload[type="file"]', function () {

        let data = new FormData();
        data.append('photo', $(this)[0].files[0]);

        $.ajax({
            url: '/ajax/files/upload_photo.php',
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
                        alert('Произошла неизвестная ошибка при загрузкей файла');
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

    $(document).on('keyup', '.link_input', function () {
        HtmlLink($(this).val());
    });

    html_area.on('change', function (event) {
        UpdateHtml();
    });
    html_area.on('keyup', function (event) {
        UpdateHtml();
    });

});