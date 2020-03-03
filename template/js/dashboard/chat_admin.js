$(function () {
    let timer = setInterval(UpdateChatWindow, 10000);

    let lastMessageId = 0;
    let firstTimeUpdate = true;
    let lastMessage;

    let chatId = $(".send_message").data('chat_id');

    $("button.send_message").on('click', function () {

        let textarea = $("#message_text_area");
        let text = encode_utf8(textarea.val().trim());

        console.log('sending message', text);

        if (text !== '') {

            textarea.empty();
            $(".twemoji-textarea").empty();

            $.ajax({
                url: '/ajax/chat/admin_send_message.php',
                type: 'POST',
                dataType: 'json',
                data: { chat_id: chatId, message: text },
            })
            .done(function() {

                UpdateChatWindow();                
            })
            .fail(function() {
                console.log("error");
            })
            .always(function(data) {
                console.log(data);
            });
        }

    });

    function UpdateChatWindow() {
        let window = $('.chat-message_body');

        $.ajax({
            url: '/ajax/chat/get_admin_chat.php',
            type: 'POST',
            dataType: 'json',
            data: { chat_id: chatId, last_message_id: lastMessageId },
        })
        .done(function(data) {
            if (data.ok === true){
                if (data.result.length > 0) {

                    data.result.forEach((message) => {
                        if (lastMessage === undefined || lastMessage.date !== message.date) {

                            window.append('<div class="chat-message_date"><span class="date">' + message.date + '</span></div>');                        
                        
                        }
                        let messageDate = '';
                        if (lastMessage === undefined || lastMessage.time !== message.time || lastMessage.from !== message.from) {
                            messageDate = '<div class="chat-message_body-date time">' + formatTime(message.time) + '</div>';
                        }

                        let color_to = $(".send_message").data('color_to');

                        let color_from = $(".send_message").data('color_from');

                        window.append('<div class="chat-message_body-item ' + ((message.from) ? 'an' : 'mes') + '"><div class="col-xs-2"><div class="chat-message_body-av" style="background-color: #'+ ((message.from) ? color_to : color_from) +';"><img src="/files/' + message.avatar + '" alt=""></div></div><div class="col-xs-10 ' + ((message.from) ? 'text-right' : '') + '"><div class="chat-message_body-block"><div class="chat-message_body-text">' + decode_utf8(message.text) + '</div>' + messageDate + '</div></div><div class="clearfix"></div></div>');

                        lastMessage = message;
                    });

                    lastMessageId = lastMessage.id;

                    if (!firstTimeUpdate) 
                        {
                          
                            let chatDiv = $('div[data-chat-id="' + chatId + '"]');
                            chatDiv.find('.chat-theme_item-text').html(decode_utf8(lastMessage.text));
                            chatDiv.find('.chat-theme_item-date').text(lastMessage.time);
                            chatDiv.prependTo('.chat-theme');
                        } 
                    else
                        {
                            
                            firstTimeUpdate = false;
                        }

                    window.animate({scrollTop: window[0].scrollHeight}, 500, 'swing');
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

    UpdateChatWindow();

    function encode_utf8(s) {
        return encodeURIComponent(s);
    }

    function decode_utf8(s) {
        return decodeURIComponent(s);
    }


});