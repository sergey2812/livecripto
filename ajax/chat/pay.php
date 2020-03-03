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

if (!empty($_POST['chat_id']) AND !empty($_POST['from_wallet']) AND !empty($_POST['to_wallet']) AND !empty($_POST['seller_wallet']) AND !empty($_POST['type'])) {

    $chats = new \LiveinCrypto\Chats();

    $chat = $chats->Get($_POST['chat_id'], $_COOKIE['id']);

    $chats->paid($_COOKIE['id'], $_POST['chat_id'], $_POST['from_wallet'], $_POST['type'], $_POST['to_wallet'], $_POST['seller_wallet']);
    $ajax->Success();
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();