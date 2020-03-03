<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 19:07
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

    if (!empty($_POST["function"]) AND $_POST["function"] == 'new_city' AND !empty($_POST["name_city"]) AND !empty($_POST["country_id"]) AND !empty($_POST["country_name"]))
        {
            $params = [
                        'name' => $_POST["name_city"],
                        'country' => $_POST["country_id"],
                        'author' => 1
                    ];

            $result = $locations->NewCity($params);
              
            if ($result)
                {
                    header('Location: /admin/settings.php?type=cities&country_id='.$_POST["country_id"].'&country_name='.$_POST["country_name"]);
                }
            else
                {
                    header('Location: /admin/settings.php?type=cities&country_id='.$_POST["country_id"].'&country_name='.$_POST["country_name"].'&city=has');
                }
                 
        }
    else
        {
            $ajax->Echo();
        }
 
exit;