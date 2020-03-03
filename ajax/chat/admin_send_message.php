<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 9:31
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['chat_id']) AND !empty($_POST['message'])) {

    $chats = new \LiveinCrypto\Chats();

    $result = $chats->SendAdminMessage($_COOKIE['id'], $_POST['chat_id'], $_POST['message']);

    if ($result === true) {
        $ajax->Success();
    } else{
        $ajax->Error($result);
    }

} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();