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

    if (!empty($_POST["top_advert_id"]))
        {
            $params = [
                        'advert_id' => $_POST["top_advert_id"],
                        'user_id' => $_POST["top_user_id"],
                        'pay_date' => date('Y-m-d H:i:s'),
                        'pay_sum' => $_POST["clients_pay_sum"],
                        'crypta_code' => $_POST["clients_crypto_code"],
                        'user_wallet' => $_POST["clients_wallet_address"],
                        'admin_wallet' => $_POST["admins_wallet_address"],                        
                        'status' => 1,
                        'country' => $_POST["top_client_country_id"],
                        'city' => $_POST["top_client_city_id"],
                        'section' => $_POST["top_client_section_id"],
                        'category' => $_POST["top_client_category_id"],
                        'subcategory' => $_POST["top_client_subcategory_id"]
                    ];

            $result = $update_prices->WrightUpdateClientsData($params);
              
            if ($result == 1)
                {
                    header('Location: /dashboard.php?page=my_adverts&adverts=all');
                }
            if ($result == 0)
                {
                    header('Location: /dashboard.php?page=my_adverts&adverts=has');
                }
                 
        }
    else
        {
            $ajax->Echo();
        }
 
exit;