<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 08.09.2018
 * Time: 8:54
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['chat_id'])) {

    $chats = new \LiveinCrypto\Chats();

    $chats->ReadAdminMessages($_COOKIE['id'], $_POST['chat_id']);

    $lastMessageId = (!empty($_POST['last_message_id'])) ? $_POST['last_message_id'] : 0;

    $result = $chats->GetAdminChatHistory($_COOKIE['id'], $_POST['chat_id'], $lastMessageId);

    $ajax->AddData($result);
    $ajax->Success();

} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();