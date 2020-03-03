$(function(){
    /*
    type =
    1 - payed
    2 - delivered
    3 - received
     */
    function UpdateStatus(type, advert_id, status, element = null) {

        $.ajax({
            url: '/ajax/adverts/update_' + type + '.php',
            type: 'POST',
            dataType: 'json',
            data: {id: advert_id, type: status},
        })
        .done(function(data) {
            if (data.ok === true){
                location.reload();
            } else{
                if (data.error !== undefined){
                    alert(data.error);
                } else{
                    alert(glossary.functions.adverts_dashboard_status_update[0]);
                }
            }
        })
        .fail(function() {
            console.log("error");
        })
        .always(function(data) {
            if (element !== null){
                element.prop('disabled', false);
            }
            console.log(data);
        });
    }

    $('.update_status').on('click', function (e) {
        e.preventDefault();

        $(this).prop('disabled', true);

        let type = $(this).data('type');
        let id = $(this).data('id');
        let status = $(this).closest('form').find('input[type="radio"]').data('status');

        /*if (type === 'received' && id !== undefined && parseInt(status) === 1) {
            let modal = $("#close_deals");
            modal.find("input[name='id']").val(id);
        } else{
            UpdateStatus(type, id, status, $(this));
        }*/
//        UpdateStatus(type, id, status, $(this));

    })

});