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

if (!empty($_POST['deal_id']) AND !empty($_POST['stars']) AND isset($_POST['like']) AND !empty($_POST['message'])) {

    $adverts->CloseDeal($_POST['deal_id'], boolval($_POST['like']), $_POST['message'], $_POST['stars']);

    $ajax->Success();
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();