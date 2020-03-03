$(function () {

    let html_area = $("#html_code");
    let image = null;
    let link_url = null;

    function HtmlImage(filename) {

        html_area.val(filename);
    }

    $(document).on('change', 'input.image_upload[type="file"]', function () {

        let data = new FormData();
        data.append('photo', $(this)[0].files[0]);

        $.ajax({
            url: '/ajax/files/upload_html_email.php',
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