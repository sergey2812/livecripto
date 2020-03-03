$(function () {

    $(".upload_image").on('change', function () {

        if ($(this).val() !== '') {

            let target = $(this).data('target');
            target = $(target);

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
                    target.val(data.result.filename);
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

        }

    });

});