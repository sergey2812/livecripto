<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.08.2018
 * Time: 4:32
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();
$captcha = new \LiveinCrypto\Captcha();

if (!empty($_POST['g-recaptcha-response']) AND $captcha->check($_POST['g-recaptcha-response'])) {
    if (!empty($_POST['login']) AND !empty($_POST['password'])) {

        $result = $users->Login($_POST['login'], $_POST['password']);

        if ($result === true) {
            
            $ajax->Success();
        } else{
            $ajax->Error(_('Пожалуйста, проверьте правильность ввода логина и пароля'));
        }

    } else{
        $ajax->Error(_('Пожалуйста, заполните все поля'));
    }
} else{
    $ajax->Error('Пожалуйста, заполните капчу');
}

$ajax->Echo();