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

    $chat = $chats->Get($_POST['chat_id'], $_COOKIE['id']);

    $newValue = intval(!$chat->isAccept());

    $chats->accept($_COOKIE['id'], $_POST['chat_id'], $newValue);
    $ajax->Success();
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();