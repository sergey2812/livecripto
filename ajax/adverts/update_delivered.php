<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 11.09.2018
 * Time: 0:44
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['id'])) {

    if ($adverts->isUserSeller($_COOKIE['id'], $_POST['id']))
    {
        if (!empty($_POST['type']) AND $_POST['type'] == '1')
        {
                    $type = (!empty($_POST['type']) AND $_POST['type'] == '1');

                    $result = $adverts->UpdateDelivered($_POST['id'], $type);

                    if ($result)
                    {
                        $ajax->Success();
                    } 
                    else
                    {
                        $ajax->Error($result);
                    }

        }
        if (!empty($_POST['type']) AND $_POST['type'] == '0')
        {
                    $type = (!empty($_POST['type']) AND $_POST['type'] == '0');

                    $result = $adverts->UpdateNoDelivered($_POST['id'], $type);
                    if ($result)
                    {
                        $ajax->Success();
                    } 
                    else
                    {
                        $ajax->Error($result);
                    }                    
        }        

    } 
    else
    {
        $ajax->Error(_('Вы не владалец этого объявления'));
    }

} 
else
{
    $ajax->Error(_('Пожалуйста, заполните все поля.'));
}

$ajax->Echo();