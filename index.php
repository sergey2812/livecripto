<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 12.08.2018
 * Time: 23:10
 */

$safe_mode_disable = true;

require_once __DIR__.'/engine/autoload.php';

$smarty->assign('locations', $locations->GetLocations());

$smarty->assign('locations_cities', $locations->GetCities());

$smarty->assign('country', $locations);

if (!empty($_GET['location'])) $smarty->assign('selectedCities', $locations->GetCitiesOfCountry($_GET['location']));

$smarty->assign('author', false);

$sort = ['date', 'desc'];

$smarty->assign('_GET', $_GET);

if (!empty($_GET)) {

    $filter = [];

    if (!empty($_GET['keywords'])){
        $filter[] = 'name LIKE \'%'.$adverts->mysqli->escape_string($_GET['keywords']).'%\'';
    }
    if (!empty($_GET['search'])){
        $filter[] = 'name LIKE \'%'.$adverts->mysqli->escape_string($_GET['search']).'%\'';
    }
    if (!empty($_GET['section'])){
        if (!is_array($_GET['section'])) $_GET['section'] = [$_GET['section']];
        foreach ($_GET['section'] as $k => $v) $_GET['section'][$k] = $adverts->mysqli->escape_string($v);

        $filter[] = 'section IN (\''.implode('\',\'', $_GET['section']).'\')';
        $smarty->assign('selected_section_categories', $sections->GetSectionCategories($_GET['section'][0]));
    }
    if (!empty($_GET['category'])){
        $filter[] = 'category = \''.$adverts->mysqli->escape_string($_GET['category']).'\'';
        $smarty->assign('selected_category_subcategories', $sections->GetCategorySubcategories($_GET['category']));
    }
    if (!empty($_GET['subcategory'])){
        $filter[] = 'subcategory = \''.$adverts->mysqli->escape_string($_GET['subcategory']).'\'';
    }
    if (!empty($_GET['securedeal']) AND count($_GET['securedeal']) === 1){
        $secureDeal = ($_GET['securedeal'][0] == 'on') ? 1 : 0;
        $filter[] = 'secure_deal = \''.$adverts->mysqli->escape_string($secureDeal).'\'';
    }
    if (!empty($_GET['author'])){
        $filter[] = 'author = \''.$adverts->mysqli->escape_string($_GET['author']).'\'';
        $smarty->assign('author', $users->Get($_GET['author']));
    }

    if (!empty($_GET['location'])){

        $filter[] = 'location = \''.$adverts->mysqli->escape_string($_GET['location']).'\'';
    }

    if (!empty($_GET['location_name'])){
        $filter[] = 'location_name = \''.$adverts->mysqli->escape_string($_GET['location_name']).'\'';
    }

    if (!empty($_GET['delivery']) AND COUNT($_GET['delivery']) == 1){
        if ($_GET['delivery'][0] == 'on') {
            $filter[] = 'location != \''.$world_id.'\'';
        } else{
            $filter[] = 'location = \''.$world_id.'\'';
        }
        
    }
    if (!empty($_GET['date'])){

        $date = date('Y-m-d H:i:s', strtotime('- '.$_GET['date'].' hours'));
        $filter[] = 'date >= \''.$adverts->mysqli->escape_string($date).'\'';
    }

    $filterType = 'BTC';
    foreach ($_GET as $key => $value){
        if (stripos($key, 'min') !== false OR stripos($key, 'max') !== false) {
            $type = explode('_', $key);
            if ($value !== '') {
                $i = ($type[1] == 'min') ? '>=' : '<=';
                $value = $adverts->mysqli->escape_string($value);
            } else{
                $i = '>=';
                $value = 0;
            }
            $filterType = $type[0];
            $filter[] = "CAST(JSON_EXTRACT(prices, '$.$type[0]') as DECIMAL(16,8)) $i $value";
        }
    }

    if (!empty($_GET['sort'])){

        if ($_GET['sort'] == 'date_desc'){
            $sort = ['date', 'desc'];
        } elseif($_GET['sort'] == 'price_desc'){
            $sort = ['price', "CAST(JSON_EXTRACT(prices, '$.$filterType') as DECIMAL(16,8)) desc"];
        } elseif($_GET['sort'] == 'price_asc'){
            $sort = ['price', "CAST(JSON_EXTRACT(prices, '$.$filterType') as DECIMAL(16,8)) asc"];
        }
    }

    if (!empty($_GET['page'])){
        $limit = (int)$_GET['page']*64;       
    } else{
        $limit = 64;
    }

    if (!empty($filter)){
        $allAdverts = $adverts->GetAll('status = 2 AND '.implode(' AND ', $filter), $limit, $sort);
        $smarty->assign('adverts', $allAdverts);
        $smarty->assign('advertsCount', $adverts->getCount('status = 2 AND '.implode(' AND ', $filter)));

    } else{
        $allAdverts = $adverts->GetAll('status = 2', $limit, $sort);
        $smarty->assign('adverts', $allAdverts);
        $smarty->assign('advertsCount', $adverts->getCount('status = 2'));
    }
} else{
    $allAdverts = $adverts->GetAll('status = 2', 64, $sort);
    $smarty->assign('adverts', $allAdverts);
    $smarty->assign('advertsCount', $adverts->getCount('status = 2'));
}

$typeFilters = [];
foreach ($_GET as $key => $value) {
    if ((stripos($key, '_min') !== false OR stripos($key, '_max')) AND mb_stripos($key, 'выберите') === false) {
        $type = str_ireplace('_min', '', $key);
        $type = str_ireplace('_max', '', $type);

        $i = (stripos($key, '_min') !== false) ? 'min' : 'max';

        if (empty($typeFilters[$type])) $typeFilters[$type] = ['min' => 0, 'max' => 0];
        $typeFilters[$type][$i] = $value;
    }
}

$smarty->assign('typeFilters', $typeFilters);
$smarty->assign('filters', $_GET);

$smarty->assign('adsIcons', $ads->ReturnIcon($sec_id, $cat_id, $subcat_id));

$smarty->assign('adsBannerUp', $ads->Return(1, $sec_id, $cat_id, $subcat_id));

$smarty->assign('adsSlider1', $ads->Return(2, $sec_id, $cat_id, $subcat_id));
$smarty->assign('adsSlider2', $ads->Return(3, $sec_id, $cat_id, $subcat_id));
$smarty->assign('adsSlider3', $ads->Return(4, $sec_id, $cat_id, $subcat_id));

$smarty->assign('adsBlock1', $ads->Return(5, $sec_id, $cat_id, $subcat_id));

$smarty->assign('adsBlock2', $ads->Return(6, $sec_id, $cat_id, $subcat_id));

if (!empty($pos_top_1)) 
    {
        $rand_keys1 = array_rand($pos_top_1, 1);
        // получить объявление по его id
        $advert1 = $adverts->GetOneAdvertById($pos_top_1[$rand_keys1]); // это id объявления

        $smarty->assign('advert1', $advert1[0]); // передали массив с одним объявлением в шаблон
    }

if (!empty($pos_top_2)) 
    {
        $rand_keys2 = array_rand($pos_top_2, 1);
        // получить объявление по его id
        $advert2 = $adverts->GetOneAdvertById($pos_top_2[$rand_keys2]); // это id объявления

        $smarty->assign('advert2', $advert2[0]); // передали массив с одним объявлением в шаблон
    }

if (!empty($pos_top_3)) 
    {
        $rand_keys3 = array_rand($pos_top_3, 1);
        // получить объявление по его id
        $advert3 = $adverts->GetOneAdvertById($pos_top_3[$rand_keys3]); // это id объявления

        $smarty->assign('advert3', $advert3[0]); // передали массив с одним объявлением в шаблон
    }   

if (!empty($pos_top_4)) 
    {
        $rand_keys4 = array_rand($pos_top_4, 1);
        // получить объявление по его id
        $advert4 = $adverts->GetOneAdvertById($pos_top_4[$rand_keys4]); // это id объявления

        $smarty->assign('advert4', $advert4[0]); // передали массив с одним объявлением в шаблон
    }

$smarty->assign('page_title', 'Главная');

$smarty->display('index.tpl');