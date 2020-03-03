<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 15:59
 */

namespace LiveinCrypto\Helpers;


class RegistrationDataChecker
{

    public function CheckLogin(string $login): bool
    {
        return preg_match('/^[A-Za-z0-9]{5,10}$/', $login);
    }

    public function CheckEmail(string $email): bool
    {
        return filter_var($email, FILTER_VALIDATE_EMAIL);
    }

    public function CheckPhone(string $phone): bool
    {
        return preg_match("/^\+7[0-9]{10}$/", $phone);
    }

    public function CheckPassword(string $password): bool
    {
        if (strlen($password) > 5){
            return true;
        } else{
            return false;
        }
    }

}