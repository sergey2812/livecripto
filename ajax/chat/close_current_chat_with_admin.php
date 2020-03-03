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

if (!empty($_POST['close_chat_id'])) {

    $chats = new \LiveinCrypto\Chats();

    $chat = $chats->CloseAdminChat($_POST['close_chat_id']);

    $ajax->Success();

} else{
    $ajax->Error(_('Пожалуйста, укажите номер чата'));
}

$ajax->Echo();