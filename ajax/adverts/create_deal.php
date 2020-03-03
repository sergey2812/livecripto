<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 25.09.2018
 * Time: 16:23
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

/*print_r($_POST);
echo $_COOKIE['id'];*/

if (!empty($_POST['advert_id']) AND !empty($_POST['buyer_wallet']) AND !empty($_POST['buyer_type']) AND !empty($_COOKIE['id'])) {

    $result = $adverts->CreateDeal($_POST['advert_id'], $_COOKIE['id'], $_POST['buyer_wallet'], $_POST['buyer_type']);

    if ($result != false) {
        $ajax->Success();
    } else{
        $ajax->Error(_('Ошибка создания сделки'));
    }
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();