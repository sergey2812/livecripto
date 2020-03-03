<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 26.09.2018
 * Time: 11:03
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['id']) AND isset($_POST['type']) AND !empty($_POST['rating']) AND !empty($_POST['comment'])) {

    if ($_POST['rating'] > 0 AND $_POST['rating'] <= 5){
        if ($adverts->isUserBuyer($_COOKIE['id'], $_POST['id'])){

            $like = (!empty($_POST['type']) AND $_POST['type'] == '1') ? true : false;

            $result = $adverts->CloseDeal($_POST['id'], $like, $_POST['comment'], $_POST['rating']);

            if ($result){
                $ajax->Success();
            } else{
                $ajax->Error($result);
            }
        } else{
            $ajax->Error(_('Вы не покупатель этого объявления'));
        }
    } else{
        $ajax->Error(_('Указана неверная оценка.'));
    }
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля.'));
}

$ajax->Echo();