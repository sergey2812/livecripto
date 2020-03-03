$(function () {

    let block = $('.photos');
    let photos = [];
    
    if ($('input[name="photos"]').val() !== ''){
        photos = JSON.parse($('input[name="photos"]').val());
        console.log(photos);
      
    }

    function ShowNewPhoto(filename, id) {

        if (!photos.includes(filename)) {
            photos.push(filename);    
            $('input[name="photos"]').val(JSON.stringify(photos)).trigger('change');
            console.log(filename, photos);
            
            let num_current = Number.parseInt(id.charAt(5));
            let num_preview = num_current - 1;
            let num_next = num_current + 1;

            $('#photo_close_' + num_current + '').css("display", "inline-block");
            $('#file_' + num_current + '').css("pointer-events", "none");
            $('#file_' + num_current + '').css("cursor", "none");
            $('#photo_label_' + num_current + '').css("opacity", "0");

            if (num_preview >=0)
                {                   
                    $('#photo_close_' + num_preview +'').css("display", "none"); 
                    $('#file_' + num_preview + '').css("pointer-events", "none"); 
                    $('#file_' + num_preview + '').css("cursor", "none"); 
                }

            if (num_next <= 4)
                {                       
                    $('.photo-photo_' + num_next + '').prop('disabled', false);
                    $('.photo-photo_' + num_next + '').addClass('active');
                    $('#file_' + num_next + '').css("pointer-events", "auto");
                    $('#file_' + num_next + '').css("cursor", "pointer");
                }

// photos.splice($.inArray(photos[num_current], photos), 1); // это удаление элемент массива
        }

//        block.find('input#'+id).closest('div').css('background-image', 'url(/files/'+filename+')');
    }

    function AddNewPhotoBlock() {
        if (block.find('div').length <= 5) {
            let random_id = new Date().getTime();
            let photo = '<div class="add-placement-files__item"><input id="file_'+random_id+'" type="file" name="item_photo" accept="image/*"><label for="file_'+random_id+'"><i></i></label></div>';
            block.append(photo);
        }
    }

    block.on('change', 'input[type="file"]', function (event) {

        let id = $(this).attr('id');
        let index = $(this).closest('div').index();
        index--;

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
            console.log(id);
            if (data.ok === true && data.result !== undefined && data.result.filename !== undefined) {
                ShowNewPhoto(data.result.filename, id);
                if (index > 0) {
                    AddNewPhotoBlock();
                }
            } else{
                if (data.error !== undefined) {
                    alert(data.error);
                } else{
                    alert(glossary.functions.upload_image[0]);
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

    $('.photo_photo_close').on('click', function () 
        {
            let close_id = $(this).attr('id');

            let num_current = Number.parseInt(close_id.charAt(12));
            let num_preview = num_current - 1;
            let num_next = num_current + 1;
                if (num_current == 0) 
                    {
                        $('button.btn-add').prop('disabled', true);
                    } 
                else
                    {
                        $('button.btn-add').prop('disabled', false)
                    }
            $('#photo_close_' + num_current + '').css("display", "none");
            $('#file_' + num_current + '').css("pointer-events", "auto");
            $('#file_' + num_current + '').css("cursor", "pointer");  
            $('#file_' + num_current + '').val(''); 

            photos.splice($.inArray(photos[num_current], photos), 1); // это удаление элемент массива   
            $('input[name="photos"]').val(JSON.stringify(photos)).trigger('change');
            $('#photos-block_result_' + num_current + '').css("background", '');
            $('#photo_label_' + num_current + '').css("opacity", "1");

            if (num_preview >= 0)
                {
                    $('#photo_close_' + num_preview +'').css("display", "inline-block"); 
                    $('#file_' + num_preview + '').css("pointer-events", "none");
                    $('#file_' + num_preview + '').css("cursor", "none"); 
                }

            if (num_next <= 4)
                {
                    $('.photo-photo_' + num_next + '').removeClass('active');
                    $('.photo-photo_' + num_next + '').prop('disabled', true);
                    $('#file_' + num_next + '').css("pointer-events", "none");
                    $('#file_' + num_next + '').css("cursor", "none");
                }                              
        });
});