<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 20.09.2018
 * Time: 10:24
 */

$admin_area = true;

require_once __DIR__.'/../engine/autoload.php';

$smarty->assign('page_title', 'Объявления');

$settings = new \LiveinCrypto\Settings();

if ($_GET['type'] == 'smtp') 
    {
        if (!empty($_POST['smtp_server']) AND !empty($_POST['smtp_port']) AND !empty($_POST['smtp_type']) AND !empty($_POST['smtp_login']) AND !empty($_POST['smtp_password']) AND !empty($_POST['smtp_email'])) {
            $settings->Update($_POST);
        }

        $smarty->assign('settings', $settings);
        $smarty->display('admin/pages/settings/smtp.tpl');
    } 
elseif ($_GET['type'] == 'wallets')
    {
        if (!empty($_GET['function'])) 
            {
                if ($_GET['function'] == 'new')
                    {
                        $crypto_img_real_file = '';

                        if (!empty($_POST['save_crypto_name']) AND !empty($_POST['save_crypto_code']) AND !empty($_POST['save_crypto_wallet']))
                            {
                                // здесь функция записи крипты в таблицу БД
                            $params = [
                                'name' => $_POST['save_crypto_name'],
                                'code' => $_POST['save_crypto_code'],
                                'wallets_address' => $_POST['save_crypto_wallet'],
                                'bs_min_price' => (($_POST['save_crypto_min_price'] >= 0) ? $_POST['save_crypto_min_price'] : 0.0)
                            ];

                                $currencies->Create($params);
                                    
                                header('Location: /admin/settings.php?type=wallets');
                            }

                        if (!empty($_POST['crypto_img_file']) AND !empty($_POST['crypto_img_puth']) AND !empty($_POST['crypto_code']))
                            { 
                                $smarty->assign('crypto_name', $_POST['crypto_name']);
                                $smarty->assign('crypto_code', $_POST['crypto_code']);
                                $smarty->assign('crypto_wallet', $_POST['crypto_wallet']);
                                $smarty->assign('crypto_min_price', $_POST['crypto_min_price']);

                                // здесь функция загрузки файла с эмблемой крипты в систему
                        $crypto_img_real_file = $currencies->UploadCryptoImg($_FILES['inputfile'], $_POST['crypto_code']);
                            }

                        // здесь возврат имени файла с эмблемой крипты шаблон
                        $smarty->assign('crypto_img_real_file', $crypto_img_real_file);
                        $smarty->assign('edit_mode', false);
                        $smarty->display('admin/pages/settings/new_wallets.tpl');

                    } 
                elseif ($_GET['function'] == 'edit')
                    {
                        if (!empty($_POST['name']) AND !empty($_POST['code']) AND !empty($_POST['wallets_address']))
                            {
                                $params = [
                                    'id' => $_GET['id'],
                                    'name' => $_POST['name'],
                                    'code' => $_POST['code'],
                                    'wallets_address' => $_POST['wallets_address'],
                                    'bs_min_price' => ($_POST['bs_min_price'] >= 0) ? $_POST['bs_min_price'] : 0
                                ];

                                $currencies->Update($params); 
                                    
                                header('Location: /admin/settings.php?type=wallets');                               
                            }

                        $smarty->assign('crypto_id', $_GET['id']);
                        $smarty->assign('edit_mode', true);
                        $smarty->display('admin/pages/settings/new_wallets.tpl');
                        
                    }
                else
                    {
                        if (!empty($_GET['id']) AND !empty($_GET['img']))
                            { 
                                if (!empty($_POST['function']))
                                    {
                                        $function = $_POST['function'];

                                        if ($function == 'delete-yes' AND !empty($_POST['crypto']))
                                            {
                                                $currencies->RemoveCrypto($_POST['crypto']); 
                                                $id_crypto = '';
                                                $smarty->assign('id_crypto', $id_crypto);
                                                header('Location: /admin/settings.php?type=wallets');
                                            }
                                        $smarty->assign('edit_mode', false);
                                        $smarty->display('admin/pages/settings/wallets.tpl');
                                    }
                                else
                                    {
                                        $smarty->assign('id_crypto', $_GET['id']);

                                        $smarty->assign('img_crypto', $_GET['img']);

                                        $smarty->assign('edit_mode', false);
                                        $smarty->display('admin/pages/settings/wallets.tpl');
                                    }                          
                            }
                    } 
            }
        else
            {        
                $smarty->assign('edit_mode', false);
                $smarty->display('admin/pages/settings/wallets.tpl');  
            }
    }

elseif ($_GET['type'] == 'update' || $_GET['type'] == 'updtcountry' || $_GET['type'] == 'updtcity')
    {
        if (!empty($_GET['function']) AND $_GET['function'] == 'edit' AND !empty($_GET['id']) AND !empty($_GET['name']) AND !empty($_GET['countryid']) AND !empty($_GET['countryname']))
            {
                
                if (!empty($_POST['function']) AND $_POST['function'] == 'keep_price_row')
                    {
                        $params = [
                                    'country' => $_GET['countryid'],
                                    'city' => ($_GET['type'] == 'updtcity' AND $_GET['name'] !== "Весь МИР" ) ? $_GET['id'] : 0,
                                    'section' => $_POST['section'],
                                    'category' => $_POST['category'],
                                    'subcategory' => $_POST['subcategory'],
                                    'price_for_update' => $_POST['price_massive']
                                ];

                        $update_prices->WrightUpdatePrices($params);

                        if ($_GET['countryid'] == $_GET['id'] AND $_GET['name'] == $_GET['countryname'])
                            {
                                header('Location: /admin/settings.php?type='.$_GET['type'].'&function=new&country_id='.$_GET['countryid'].'&country_name='.$_GET['countryname'].'&save=1');
                            }
                        else
                            {                                    
                                header('Location: /admin/settings.php?type='.$_GET['type'].'&function='.$_GET['function'].'&id='.$_GET['id'].'&name='.$_GET['name'].'&countryid='.$_GET['countryid'].'&countryname='.$_GET['countryname'].'&save=1');
                                
        //                        header("Location: {$_SERVER['HTTP_REFERER']}"); 
                            }
                    }
                else
                    {
                        $type = $_GET['type'];
                        $country_id = $_GET['countryid'];
                        $country_name = $_GET['countryname'];
                        
                        if ($type == 'updtcountry')
                            {
                                $item = $locations->GetLocation($_GET['id']);
                            } 
            
                        elseif($type == 'updtcity')
                            {
                                $item = $locations->GetCity($_GET['id']);
                            }

                        $smarty->assign('item', $item);
                        $smarty->assign('type', $type);

        //                $smarty->assign('prices', $item->getPrices());

                        $smarty->assign('sections', $sections->GetSections());
                        $smarty->assign('country_id', $country_id);
                        $smarty->assign('country_name', $country_name);

                        $smarty->display('admin/pages/settings/update_update.tpl');
                    }
            } 
        else
            {
                if (!empty($_GET['type']) AND $_GET['type'] == 'updtcity' AND !empty($_GET['country_id']) AND !empty($_GET['country_name']))
                    {
                        if ($_GET['country_name'] == 'Весь МИР')
                            {
                                $item = $locations->GetLocation($_GET['country_id']);
                                $smarty->assign('item', $item);
                                $smarty->assign('type', $_GET['type']);
                                $smarty->assign('sections', $sections->GetSections());
                                $smarty->assign('country_id', $_GET['country_id']);
                                $smarty->assign('country_name', $_GET['country_name']);

                                $smarty->display('admin/pages/settings/update_update.tpl');
                            }                            
                        else 
                            {
                                $cities = $locations->GetCitiesOfCountry($_GET['country_id']);
                                $smarty->assign('country_id', $_GET['country_id']);
                                $smarty->assign('country_name', $_GET['country_name']);
                                $smarty->assign('cities_top4', $cities);

                                $smarty->display('admin/pages/settings/update_list_cities.tpl');
                            }
                    }     
                else
                    {
                        $smarty->display('admin/pages/settings/update_list_countries.tpl');
                    }
            }        
    }
elseif ($_GET['type'] == 'countries' || $_GET['type'] == 'cities')
    {
        if ($_GET['type'] == 'cities' AND !empty($_GET['country_id'])) 
            {
                if (!empty($_POST["function"]) AND $_POST["function"] == 'new_city' AND !empty($_POST["name_city"]) AND !empty($_POST["country_id"]) AND !empty($_POST["country_name"]))
                    {
                        $params = [
                                    'name' => $_POST["name_city"],
                                    'country' => $_POST["country_id"],
                                    'author' => 1
                                ];

                        $new_city = $locations->NewCity($params);
                        $smarty->assign('status', $new_city);    
                    }
                
                if (!empty($_POST["function"]) AND $_POST["function"] == 'edit_city' AND !empty($_POST["name_city"]) AND !empty($_POST["city_id"]) AND !empty($_POST["country_id"]) AND !empty($_POST["country_name"]))
                    {
                        $params = [
                                    'id' => $_POST["city_id"],
                                    'name' => $_POST["name_city"],
                                    'country' => $_POST["country_id"],
                                    'author' => 1
                                ];

                        $edit_city = $locations->EditCity($params);
                        $smarty->assign('status', $edit_city);    
                    }                    

                if (!empty($_POST["function"]) AND $_POST["function"] == 'del_city' AND !empty($_POST["city_id"]))
                    {
                        $params = [
                                    'id' => $_POST["city_id"]
                                ];

                        $del_city = $locations->DeleteCity($params);
                        $smarty->assign('status', $del_city);    
                    }

                $all_cities = $locations->GetCitiesOfCountry($_GET['country_id']);
                $smarty->assign('all_cities', $all_cities);
                $cities_of_country_count = $locations->getCityCountByCountry($_GET['country_id']);
                $smarty->assign('cities_of_country_count', $cities_of_country_count);
                $smarty->assign('country_name', $_GET['country_name']);
                $smarty->assign('country_id', $_GET['country_id']);
                $smarty->assign('edit_mode', false);
                $smarty->display('admin/pages/settings/cities.tpl');   
            } 
        else
            {
                if (!empty($_POST["function"]) AND $_POST["function"] == 'new_country' AND !empty($_POST["name_country"]))
                    {
                        $new_country = $locations->NewCountry($_POST["name_country"]);
                        $smarty->assign('status', $new_country);    
                    }                

                if (!empty($_POST["function"]) AND $_POST["function"] == 'edit_country' AND !empty($_POST["name_country"]) AND !empty($_POST["country_id"]))
                    {
                        $edit_country = $locations->EditCountry($_POST["name_country"], $_POST["country_id"]);
                        $smarty->assign('status', $edit_country);    
                    }

                if (!empty($_POST["function"]) AND $_POST["function"] == 'del_country' AND !empty($_POST["country_id"]))
                    {
                        $del_country = $locations->DeleteCountry($_POST["country_id"]);
                        $smarty->assign('status', $del_country);    
                    }                    

                $all_countries = $locations->GetLocations();
                $smarty->assign('all_countries', $all_countries);
                $smarty->assign('edit_mode', false);
                $smarty->display('admin/pages/settings/countries.tpl');
            }        
    }

elseif ($_GET['type'] == 'sections' OR $_GET['type'] == 'cats' OR $_GET['type'] == 'subcats') 
    {
        if ($_GET['type'] == 'subcats' AND !empty($_GET['category_id']) AND !empty($_GET['category_name'])) 
            {
                if (!empty($_POST["function"]) AND $_POST["function"] == 'new_subcategory' AND !empty($_POST["name_subcategory"]) AND !empty($_POST["category_id"]) AND !empty($_POST["category_name"]))
                    {
                        $params = [
                                    'name' => $_POST["name_subcategory"],
                                    'category' => $_POST["category_id"]
                                ];

                        $new_subcategory = $sections->NewSubcategory($params);
                        $smarty->assign('status', $new_subcategory);    
                    }
                
                if (!empty($_POST["function"]) AND $_POST["function"] == 'edit_subcategory' AND !empty($_POST["name_subcategory"]) AND !empty($_POST["subcategory_id"]) AND !empty($_POST["category_id"]) AND !empty($_POST["category_name"]))
                    {
                        $params = [
                                    'id' => $_POST["subcategory_id"],
                                    'name' => $_POST["name_subcategory"],
                                    'category' => $_POST["category_id"]
                                ];

                        $edit_subcategory = $sections->EditSubcategory($params);
                        $smarty->assign('status', $edit_subcategory);    
                    }                    

                if (!empty($_POST["function"]) AND $_POST["function"] == 'del_subcategory' AND !empty($_POST["subcategory_id"]))
                    {
                        $params = [
                                    'id' => $_POST["subcategory_id"]
                                ];

                        $del_subcategory = $sections->DeleteSubcategory($params);
                        $smarty->assign('status', $del_subcategory);    
                    }

                $all_subcategories = $sections->GetCategorySubcategories($_GET['category_id']);
                $smarty->assign('all_subcategories', $all_subcategories);
                $smarty->assign('subcategories_count', $sections->getSubCategoriesBySectionIdCount($_GET['category_id']));
                $smarty->assign('category_id', $_GET['category_id']);
                $smarty->assign('category_name', $_GET['category_name']);
                $smarty->assign('section_id', $_GET['section_id']);
                $smarty->assign('section_name', $_GET['section_name']);

                $smarty->display('admin/pages/settings/subcats.tpl');   
            } 
        
        if ($_GET['type'] == 'cats' AND !empty($_GET['section_id']) AND !empty($_GET['section_name'])) 
            {
                if (!empty($_POST["function"]) AND $_POST["function"] == 'new_category' AND !empty($_POST["name_category"]) AND !empty($_POST["section_id"]) AND !empty($_POST["section_name"]))
                    {
                        $params = [
                                    'name' => $_POST["name_category"],
                                    'section' => $_POST["section_id"]
                                ];

                        $new_category = $sections->NewCategory($params);
                        $smarty->assign('status', $new_category);    
                    }
                
                if (!empty($_POST["function"]) AND $_POST["function"] == 'edit_category' AND !empty($_POST["name_category"]) AND !empty($_POST["category_id"]) AND !empty($_POST["section_id"]) AND !empty($_POST["section_name"]))
                    {
                        $params = [
                                    'id' => $_POST["category_id"],
                                    'name' => $_POST["name_category"],
                                    'section' => $_POST["section_id"]
                                ];

                        $edit_category = $sections->EditCategory($params);
                        $smarty->assign('status', $edit_category);    
                    }                    

                if (!empty($_POST["function"]) AND $_POST["function"] == 'del_category' AND !empty($_POST["category_id"]))
                    {
                        $del_category = $sections->DeleteCategory($_POST["category_id"]);
                        $smarty->assign('status', $del_category);    
                    }                    

                $all_categories = $sections->GetSectionCategories($_GET['section_id']);
                $smarty->assign('all_categories', $all_categories);
                $smarty->assign('categories_count', $sections->getCategoriesBySectionIdCount($_GET['section_id']));
                $smarty->assign('section_id', $_GET['section_id']);
                $smarty->assign('section_name', $_GET['section_name']);

                $smarty->display('admin/pages/settings/cats.tpl');
            } 
        
        if ($_GET['type'] == 'sections') 
            {
                if (!empty($_POST["function"]) AND $_POST["function"] == 'new_section' AND !empty($_POST["name_section"]))
                    {
                        $new_section = $sections->NewSection($_POST["name_section"]);
                        $smarty->assign('status', $new_section);    
                    }                

                if (!empty($_POST["function"]) AND $_POST["function"] == 'edit_section' AND !empty($_POST["name_section"]) AND !empty($_POST["section_id"]))
                    {
                        $edit_section = $sections->EditSection($_POST["name_section"], $_POST["section_id"]);
                        $smarty->assign('status', $edit_section);    
                    }

                if (!empty($_POST["function"]) AND $_POST["function"] == 'del_section' AND !empty($_POST["section_id"]))
                    {
                        $del_section = $sections->DeleteSection($_POST["section_id"]);
                        $smarty->assign('status', $del_section);    
                    }                    
                
                $smarty->assign('sections', $sections->GetSections());
                $smarty->assign('sections_count', $sections->getSectionsCount());
            
                $smarty->display('admin/pages/settings/sections.tpl');
            }                   

    }

elseif ($_GET['type'] == 'top' || $_GET['type'] == 'topcountry' || $_GET['type'] == 'topcity')
    {
        if (!empty($_GET['function']) AND !empty($_GET['position']) AND !empty($_GET['id']) AND !empty($_GET['name']) AND !empty($_GET['countryid']) AND !empty($_GET['countryname']))
            {
                
                if (!empty($_POST['function']) AND $_POST['function'] == 'keep_price_row')
                    {                        
                        $params = [
                                    'country' => ($_GET['type'] == 'topcountry') ? $_GET['id'] : $_GET['countryid'],
                                    'city' => ($_GET['type'] == 'topcity') ? $_GET['id'] : 0,
                                    'section' => ($_POST['section'] != '') ? $_POST['section'] : 0,
                                    'category' => ($_POST['category'] != '') ? $_POST['category'] : 0,
                                    'subcategory' => ($_POST['subcategory'] != '') ? $_POST['subcategory'] : 0,
                                    'price_top_1' => ($_GET['position'] == 1) ? $_POST['price_massive'] : array(),
                                    'price_top_2' => ($_GET['position'] == 2) ? $_POST['price_massive'] : array(),
                                    'price_top_3' => ($_GET['position'] == 3) ? $_POST['price_massive'] : array(),
                                    'price_top_4' => ($_GET['position'] == 4) ? $_POST['price_massive'] : array()
                                ];

                        $price_status = $top_4_prices->WrightTop4Prices($params);
                        $smarty->assign('status', $price_status);
                                                            
                        header('Location: /admin/settings.php?type='.$_GET['type'].'&function='.$_GET['function'].'&position='.$_GET['position'].'&id='.$_GET['id'].'&name='.$_GET['name'].'&countryid='.$_GET['countryid'].'&countryname='.$_GET['countryname'].'&save=1');
                        
//                        header("Location: {$_SERVER['HTTP_REFERER']}"); 
                    }
                else
                    {
                        $type = $_GET['type'];
                        $country_id = $_GET['countryid'];
                        $country_name = $_GET['countryname'];
                        
                        if ($type == 'topcountry')
                            {
                                $item = $locations->GetLocation($_GET['id']);
                            } 
            
                        elseif($type == 'topcity')
                            {
                                $item = $locations->GetCity($_GET['id']);
                            }

                        $smarty->assign('position', $_GET['position']);
                        $smarty->assign('item', $item);
                        $smarty->assign('type', $type);

        //                $smarty->assign('prices', $item->getPrices());

                        $smarty->assign('sections', $sections->GetSections());
                        $smarty->assign('country_id', $country_id);
                        $smarty->assign('country_name', $country_name);

                        if ($_GET['function'] == 'home')
                            {
                                $smarty->display('admin/pages/settings/top_update_home.tpl');
                            }

                        if ($_GET['function'] == 'section')
                            {
                                $smarty->display('admin/pages/settings/top_update_sections.tpl');
                            }
                        if ($_GET['function'] == 'category')
                            {
                                $smarty->display('admin/pages/settings/top_update_cats.tpl');
                            }
                        if ($_GET['function'] == 'subcategory')
                            {
                                $smarty->display('admin/pages/settings/top_update_subcats.tpl');
                            }
                    }
            } 
        else
            {
                if (!empty($_GET['type']) AND $_GET['type'] == 'topcity' AND !empty($_GET['country_id']) AND !empty($_GET['country_name']))
                    {
                        $cities = $locations->GetCitiesOfCountry($_GET['country_id']);
                        $smarty->assign('country_id', $_GET['country_id']);
                        $smarty->assign('country_name', $_GET['country_name']);
                        $smarty->assign('cities_top4', $cities);

                        $smarty->display('admin/pages/settings/top_list_cities.tpl');
                    }     
                else
                    {
                        $smarty->display('admin/pages/settings/top_list_countries.tpl');
                    }
            }
    }