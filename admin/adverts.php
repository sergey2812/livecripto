<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 20.09.2018
 * Time: 10:09
 */

$admin_area = true;

require_once __DIR__.'/../engine/autoload.php';

$smarty->assign('page_title', 'Объявления');

$smarty->assign('all_adverts', []);

// $smarty->assign('locations', $sections->GetLocations());

// $smarty->assign('locations_cities', $sections->GetCities());

$sort = ['date', 'desc'];

$smarty->assign('_GET', $_GET);

if (!empty($_GET['page'])){
    $limit = (int)$_GET['page']*64;  
    $pageAdvertsCount = $limit;     
} else{
    $limit = 64;
    $pageAdvertsCount = 64;
}

if ($_GET['type'] == 'incident') {

    $smarty->assign('title_type', 'Арбитраж');
    $smarty->assign('all_adverts', $adverts->GetAll('id IN (SELECT advert_id FROM deals WHERE incident > 0)', $limit, $sort));
    $smarty->assign('pageAdvertsCount', $pageAdvertsCount);
    $smarty->assign('filters', $_GET);    
    $smarty->display('admin/pages/adverts/all.tpl');

} elseif ($_GET['type'] == 'moderation'){

    $smarty->assign('title_type', 'На модерации');
    $smarty->assign('all_adverts', $adverts->GetAll('status = \'1\'', $limit, $sort));
    $smarty->assign('pageAdvertsCount', $pageAdvertsCount);
    $smarty->assign('filters', $_GET);    
    $smarty->display('admin/pages/adverts/all.tpl');

} elseif ($_GET['type'] == 'all'){
   
    $smarty->assign('title_type', 'Все объявления');
    $smarty->assign('all_adverts', $adverts->GetAll('', $limit, $sort));
    $smarty->assign('pageAdvertsCount', $pageAdvertsCount);
    $smarty->assign('filters', $_GET);    
    $smarty->display('admin/pages/adverts/all.tpl');

} elseif($_GET['type'] == 'single' AND !empty($_GET['id'])) {

    if (!empty($_POST['update_status'])){
        $result = $adverts->Update($_GET['id'], ['status' => $_POST['update_status']]);

        if ($result && $_POST['update_status'] == 4)
            {
                $smarty->assign('status', 10); // успешное блокирование
            }
        if ($result && $_POST['update_status'] == 3)
            {
                $smarty->assign('status', 12); // успешное архивирование
            }
        if ($result && $_POST['update_status'] == 2)
            {
                $smarty->assign('status', 14); // успешная публикация
            }
        if ($result && $_POST['update_status'] == 1)
            {
                $smarty->assign('status', 8); // исходное состояние модерации
            }
    }

    $smarty->assign('advert', $adverts->Get($_GET['id']));
    $smarty->display('admin/pages/adverts/single.tpl');

} 
else
{    
    if (!empty($_GET)) 
        {
            $filter = [];

            if (!empty($_GET['type'])){
                if ($_GET['type'] <= 4){
                    $filter[] = 'status = \''.$adverts->mysqli->escape_string($_GET['type']).'\'';
                } else{
                    $filter[] = 'id IN (SELECT advert_id FROM deals WHERE incident > 0)';
                }
            }
            if (!empty($_GET['section'])){
                $filter[] = 'section = \''.$adverts->mysqli->escape_string($_GET['section']).'\'';
                $smarty->assign('selected_section_categories', $sections->GetSectionCategories($_GET['section']));
            }
            if (!empty($_GET['category'])){
                $filter[] = 'category = \''.$adverts->mysqli->escape_string($_GET['category']).'\'';
                $smarty->assign('selected_category_subcategories', $sections->GetCategorySubcategories($_GET['category']));
            }
            if (!empty($_GET['subcategory'])){
                $filter[] = 'subcategory = \''.$adverts->mysqli->escape_string($_GET['subcategory']).'\'';
            }
            if ($_GET['secure_deal'] == '0' OR $_GET['secure_deal'] == '1'){
                $filter[] = 'secure_deal = \''.$adverts->mysqli->escape_string($_GET['secure_deal']).'\'';
            }
            if (!empty($_GET['date'])){
                $filter[] = 'date >= \''.$adverts->mysqli->escape_string($_GET['date']).'\'';
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



            $smarty->assign('all_adverts', $adverts->GetAll(implode(' AND ', $filter), $limit, $sort));
            $smarty->assign('advertsCount', $adverts->getCount(implode(' AND ', $filter)));
            $smarty->assign('pageAdvertsCount', $pageAdvertsCount);
        } 
    else
        {
            $smarty->assign('all_adverts', $adverts->GetAll('', 0, $sort));
            $smarty->assign('advertsCount', $adverts->getCount());
            $smarty->assign('pageAdvertsCount', $pageAdvertsCount);
        }

    $typeFilters = [];
    
    foreach ($_GET as $key => $value) 
        {

            if ((stripos($key, '_min') !== false OR stripos($key, '_max')) AND mb_stripos($key, 'выберите') === false) 
                {
                    $type = str_ireplace('_min', '', $key);
                    $type = str_ireplace('_max', '', $type);

                    $i = (stripos($key, '_min') !== false) ? 'min' : 'max';

                    if (empty($typeFilters[$type])) $typeFilters[$type] = ['min' => 0, 'max' => 0];
                    $typeFilters[$type][$i] = $value;                     
                }
        }

    $smarty->assign('typeFilters', $typeFilters);

    $smarty->assign('title_type', 'Поиск');
    $smarty->assign('filters', $_GET);
    $smarty->assign('pageAdvertsCount', $pageAdvertsCount);
    $smarty->display('admin/pages/adverts/all.tpl');
}

