<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 4:16
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();
$ajax->ReloadPage(false);

if ($user === false) {
    if (!empty($_POST['login']) AND !empty($_POST['email']) AND !empty($_POST['password']) AND !empty($_POST['password_2'])) {

        if ($_POST['password'] == $_POST['password_2']) {

            $checker = new \LiveinCrypto\Helpers\RegistrationDataChecker();

            if (!$checker->CheckLogin($_POST['login'])){
                $ajax->Error(_('Проверьте правильность введённого логина. Логин должен содержать более 5-ти символов и менее 10-ти'));
            }
            if (!$checker->CheckEmail($_POST['email'])){
                $ajax->Error(_('Проверьте правильность введённого e-mail'));
            }
            if (!empty($_POST['phone']) AND !$checker->CheckPhone($_POST['phone'])){
                $ajax->Error(_('Проверьте правильность введённого телефона'));
            }
            if (!$checker->CheckPassword($_POST['password'])){
                $ajax->Error(_('Проверьте правильность введённого пароля. Пароль должен быть более 5-ти символов'));
            }

            if ($ajax->GetError() == false) {

                $params = [
                    'login' => $_POST['login'],
                    'email' => $_POST['email'],
                    'phone' => (!empty($_POST['phone'])) ? $_POST['phone'] : '',
                    'password' => $_POST['password'],
                    'wallets' => json_encode([])
                ];

                $result = $users->Register($params);

                if ($result) {
                    $mail->sendMail($params['email'], 'Подтверждение регистрации', 'register.tpl', ['login' => $params['login']]);

                    $ajax->Success();
                } else{
                    $ajax->Error($result);
                }
            }
        } else{
            $ajax->Error(_('Пароли должны быть одинаковыми'));
        }
    } else{
        $ajax->Error(_('Пожалуйста, заполните все поля'));
    }
} else{
    $ajax->Error(_('Вы уже зарегистрированы.'));
}

$ajax->Echo();