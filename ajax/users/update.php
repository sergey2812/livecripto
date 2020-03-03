<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 20:57
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST) AND !empty($_POST['change_pass'])) {

    $login = $users->Login($_COOKIE['id'], $_POST['change_pass']);

    if ($login === true) {

        $valid = true;

        foreach ($_POST as $key => $value) {
            if (empty($value)) {
                unset($_POST[$key]);
            }
        }

        if (!empty($_POST['password']) OR !empty($_POST['password2'])) {
            if ($_POST['password'] != $_POST['password2']) {
                $valid = false;
            } else {
                unset($_POST['password2']);
            }
        }

        if (!empty($_POST['color'])) $_POST['color'] = str_replace('#', '', $_POST['color']);

        unset($_POST['change_pass']);

        if ($valid) {

            $result = $users->Update($_COOKIE['id'], $_POST, true);

            if ($result === true) {
                $ajax->Success();
            } else {
                $ajax->Error(_('Ошибка обновления данных'));
            }
        } else {
            $ajax->Error(_('Проверьте правильность ввода данных'));
        }
    } else{
        $ajax->Error(_('Неправильно указан пароль'));
    }
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();