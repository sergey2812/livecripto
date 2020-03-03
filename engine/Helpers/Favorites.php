<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 08.09.2018
 * Time: 7:18
 */

namespace LiveinCrypto\Helpers;


use LiveinCrypto\Types\User;

class Favorites
{

    public function AdvertInUserFavorites(User $user, int $advert_id){

        $result = false;

        if (!empty($user->getFavorites()) AND in_array($advert_id, $user->getFavorites())) {
            $result = true;
        }

        return $result;

    }

}