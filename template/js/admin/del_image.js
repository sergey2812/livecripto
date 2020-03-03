$(function () 
    {
        
        if ($("#preview_block").html() != '')
            {
                $('.btn.btn-success.upload').prop('disabled', true);
                $('.photo_photo_close').css('display', 'inline');
            }

        $('input[name="image"]').on('change', function () 
            {
                if ($(this).val() != '') 
                    {
                        $('.btn.btn-success.upload').prop('disabled', true);
                        $('.photo_photo_close').css('display', 'inline');
                    } 
                else
                    {
                        $('.btn.btn-success.upload').prop('disabled', false)
                        $('.photo_photo_close').css('display', 'none');
                    }                
            });


        $('.photo_photo_close').on('click', function () 
            {
                let close_id = '';
                $('.btn.btn-success.upload').prop('disabled', false)
                $('.photo_photo_close').css('display', 'none');
                $('input[name="image"]').val('');
                $("#preview_block").empty();
                                     
            });

    });