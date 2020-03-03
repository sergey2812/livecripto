<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.10.2018
 * Time: 11:20
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if ($_POST['id'] AND !empty($_POST['user_id'])) {

    $result = $adverts->GetDealFeedback($_POST['id'], $_POST['user_id']);

    if ($result != false) {
        $ajax->AddData($result);
        $ajax->Success();
    } else{
        $ajax->Error(_('Проверьте правильность заполнения формы'));
    }

} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();