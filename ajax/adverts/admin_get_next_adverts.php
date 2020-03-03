<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.10.2018
 * Time: 18:03
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../../engine/autoload.php";

if (!empty($_POST['page'])) {

    $filter = [];

    if (!empty($_POST['type'])){
        if ($_POST['type'] <= 4){
            $filter[] = 'status = \''.$adverts->mysqli->escape_string($_POST['type']).'\'';
        } else{
            $filter[] = 'id IN (SELECT advert_id FROM deals WHERE incident > 0)';
        }
    }
    if (!empty($_POST['section'])){
        $filter[] = 'section = \''.$adverts->mysqli->escape_string($_POST['section']).'\'';
        $smarty->assign('selected_section_categories', $sections->GetSectionCategories($_POST['section']));
    }
    if (!empty($_POST['category'])){
        $filter[] = 'category = \''.$adverts->mysqli->escape_string($_POST['category']).'\'';
        $smarty->assign('selected_category_subcategories', $sections->GetCategorySubcategories($_POST['category']));
    }
    if (!empty($_POST['subcategory'])){
        $filter[] = 'subcategory = \''.$adverts->mysqli->escape_string($_POST['subcategory']).'\'';
    }
    if (!empty($_POST['securedeal']) AND COUNT($_POST['securedeal']) === 1){
        $secureDeal = ($_POST['securedeal'][0] == 'on') ? 1 : 0;
        $filter[] = 'secure_deal = \''.$adverts->mysqli->escape_string($secureDeal).'\'';
    }
    if (!empty($_POST['date'])){
        $filter[] = 'date >= \''.$adverts->mysqli->escape_string($_POST['date']).'\'';
    }


    if (!empty($_POST['location'])){

        $locations = explode(', ', $_POST['location']);
        foreach ($locations as $location){
            $filter[] = 'location LIKE \'%'.$adverts->mysqli->escape_string($location).'%\'';
        }
    }
    if (!empty($_POST['location_name'])){

        $location_names = explode(', ', $_POST['location_name']);
        foreach ($location_names as $location_name){
            $filter[] = 'location_name LIKE \'%'.$adverts->mysqli->escape_string($location_name).'%\'';
        }
    }
    if (!empty($_POST['author'])){
        $filter[] = 'author = \''.$adverts->mysqli->escape_string($_POST['author']).'\'';
        $smarty->assign('author', $users->Get($_POST['author']));
    }
    if (!empty($_GET['delivery']) AND COUNT($_GET['delivery']) == 1){
        if ($_GET['delivery'][0] == 'on') {
            $value = ' NOT NULL';
        } else{
            $value = ' NULL';
        }
        $filter[] = "location IS $value";
    }

    foreach ($_POST as $key => $value){
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

    if (!empty($_POST['sort'])){
        if ($_POST['sort'] == 'date_desc'){
            $sort = ['date', 'desc'];
        } elseif($_POST['sort'] == 'price_desc'){
            $sort = ['price', "CAST(JSON_EXTRACT(prices, '$.$type[0]') as DECIMAL(16,8)) desc"];
        } elseif($_POST['sort'] == 'price_asc'){
            $sort = ['price', "CAST(JSON_EXTRACT(prices, '$.$type[0]') as DECIMAL(16,8)) asc"];
        }
    } else{
        $sort = ['date', 'desc'];
    }

    $pageAdvertsCount = 64;

    $offset = (int)$_POST['page'] * $pageAdvertsCount;

        if (!empty($filter)){
            $smarty->assign('all_adverts', $adverts->GetAll('status <= 4 AND '.implode(' AND ', $filter), $pageAdvertsCount, $sort, $offset));

        } else{
            $smarty->assign('all_adverts', $adverts->GetAll('status <= 4', $pageAdvertsCount, $sort, $offset));
        }
      

    $style = (empty($_POST['style'])) ? 'normal' : $_POST['style'];
    $smarty->assign('style', $style);

    $smarty->assign('pageAdvertsCount', $pageAdvertsCount);

    $smarty->display('admin/pages/adverts/admin_ajax_adverts.tpl');

}

die();