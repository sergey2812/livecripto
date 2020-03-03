<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 23.08.2018
 * Time: 23:55
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['id'])) {

    $result = $adverts->ToggleItemFromFavorites($_COOKIE['id'], $_POST['id']);

    if (is_array($result)){
        $ajax->Success();
        $ajax->AddData($result);
    } else{
        $ajax->Error($result);
    }

} else{
    $ajax->Error(_('Пожалуйста, выберите объявление'));
}

$ajax->Echo();