<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.08.2018
 * Time: 13:05
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['to']) AND !empty($_POST['subject']) AND !empty($_POST['message'])) {

    $chats = new \LiveinCrypto\Chats();

    $result = $chats->CreateChat($_COOKIE['id'], $_POST['to'], $_POST['subject'], $_POST['message']);

    if ($result === true) {
    	
        $ajax->Success();
    } else{
        $ajax->Error($result);
    }

} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();