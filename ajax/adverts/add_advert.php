<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 9:37
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

//print_r($_POST);

//echo intval(isset($_POST['section']));
//echo intval(isset($_POST['category']));
//echo intval(isset($_POST['subcategory']));
//echo intval(isset($_POST['name']));
//echo intval(isset($_POST['description']));
//echo intval((isset($_POST['location']) OR isset($_POST['without_location'])));
//echo intval(isset($_POST['prices']));
//echo intval(isset($_POST['secure_deal']));
//echo intval(isset($_POST['photos']));
//echo intval(isset($_POST['condition']));

if (
        isset($_POST['section']) AND 
        isset($_POST['category']) AND 
        isset($_POST['subcategory']) AND 
        isset($_POST['name']) AND 
        isset($_POST['description']) AND 
        (isset($_POST['location']) OR isset($_POST['without_location'])) AND 
        isset($_POST['prices']) AND 
        isset($_POST['secure_deal']) AND 
        isset($_POST['photos']) AND 
        isset($_POST['condition'])
    ) 
{
    $world = 'Весь МИР';
    $locationName = 'Передача через сеть';
    $city_id = 0;
    $location = $locations->GetCountryIdByName($world);

        if (!empty($_POST['location_name']) AND $_POST['location_name'] != '' AND $_POST['location_name'] != NULL AND empty($_POST['location_name_new'])) 
            {
                
                $locationName = $locations->GetCityName($_POST['location_name']);

                if ($locationName == 'Весь МИР')
                    {
                        $locationName = 'Передача через сеть';
                    }
                $city_id = $_POST['location_name'];
                $location = $_POST['location'];
            } 
        else
            {
                if ($_POST['location_name_new'] != '')
                    {
                        $locationName = $_POST['location_name_new'];

                        $location = $_POST['location'];

                        $cities = $locations->GetCitiesOfCountry($_POST['location']);

                        if ($cities != array())
                            {
                                $city_exist = 0;
                                foreach ($cities as $gorod) 
                                    {
                                        if ($gorod->getName() == $_POST['location_name_new'])
                                            {       
                                                $city_id = $gorod->getId();
                                                $city_exist = 1;
                                            }
                                    }

                                if ($city_exist != 1)
                                    {
                                        $params = [
                                            'name' => $_POST["location_name_new"],
                                            'country' => $_POST["location"],
                                            'author' => 0
                                        ];

                                        $city_id = $locations->CreateCity($params); 
                                    }    
                            }
                        else
                            {
                                $params = [
                                    'name' => $_POST["location_name_new"],
                                    'country' => $_POST["location"],
                                    'author' => 0
                                ];

                                $city_id = $locations->CreateCity($params);
                            }
                    }
                else
                    {
                        $world = 'Весь МИР';
                        $locationName = 'Передача через сеть';
                        $city_id = 0;
                        $location = $locations->GetCountryIdByName($world);
                    }

            }
    
    $params = [
        'section' => $_POST['section'],
        'category' => $_POST['category'],
        'subcategory' => $_POST['subcategory'],
        'name' => $_POST['name'],
        'description' => $_POST['description'],
        'location' => $location,
        'city' => $city_id,
        'location_name' => $locationName,
        'photos' => $_POST['photos'],
        'prices' => $_POST['prices'],
        'condition_type' => $_POST['condition'],
        'author' => $_COOKIE['id'],
        'secure_deal' => (!empty($_POST['secure_deal']) AND $_POST['secure_deal'] == '1') ? '1' : '0'
    ];

    $result = $adverts->Create($params);

    if ($result != false) 
        {
            $ajax->AddData(['new_advert_id' => $result]);
            $ajax->Success();
        } 
    else
        {
            $ajax->Error(_('Проверьте правильность заполнения формы')); // . $location . $city_id . $locationName . $_COOKIE['id'] . $result));
        }

} 
else
{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();