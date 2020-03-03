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
    if (!empty($_POST['login']) OR !empty($_POST['email'])) {

        $login = (!empty($_POST['login'])) ? $_POST['login'] : $_POST['email'];
        $user = $users->getByLogin($login);

        if ($user !== false) {

            function randomPassword() {
                $alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
                $pass = array(); //remember to declare $pass as an array
                $alphaLength = strlen($alphabet) - 1; //put the length -1 in cache
                for ($i = 0; $i < 8; $i++) {
                    $n = rand(0, $alphaLength);
                    $pass[] = $alphabet[$n];
                }
                return implode($pass); //turn the array into a string
            }
            $newPassword = randomPassword();

            $params = [
                'password' => $newPassword,
            ];

            $result = $users->Update($user->getId(), $params, true);

            $mail->sendMail($user->getEmail(), 'Новый пароль', 'reset_password.tpl', [
                'login' => $user->getLogin(),
                'newPassword' => $newPassword,
            ]);

            if ($result) {
                $ajax->Success();
            } else{
                $ajax->Error('Ошибка работы с базой данных');
            }
        }
    } else{
        $ajax->Error(_('Такого логина или email\'а не существует.'));
    }
} else{
    $ajax->Error(_('Вы уже зарегистрированы.'));
}

$ajax->Echo();