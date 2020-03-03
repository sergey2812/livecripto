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

if (!empty($_POST['chat_id'])) {

    $chat = $chats->Get($_POST['chat_id'], $_COOKIE['id']);

    if ($chat->getDeal()->getSeller()->getId() == $_COOKIE['id']) {
        if (isset($_POST['product_get'])) { 
        // Здесь происходит уточнение значения радиокнопки: если ДА, то обновляем статус положительно, если НЕТ, то отрицательно
            
                $product_get = $_POST['product_get'];

            if ($product_get == 'Да')
                {
                    $adverts->UpdateDelivered($chat->getDeal()->getId(), true);
                    $ajax->Success();
                }
            if ($product_get == 'Нет')
                {
                    $adverts->UpdateNoDelivered($chat->getDeal()->getId(), true);
                    $ajax->Success();
                }

        } else{
            $ajax->Error(_('Это безопасная сделка'));
        }
    } else{
        $ajax->Error(_('Вы не продавец этого объявления'));
    }
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();