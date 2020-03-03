<?php

/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 12.08.2018
 * Time: 23:10
 */

header('Location: /');
die();

$safe_mode_disable = true;

require_once __DIR__ . '/engine/autoload.php';

$smarty->assign('locations', $locations->GetLocations());

$smarty->assign('locations_cities', $locations->GetCities());

$smarty->assign('author', false);

$sort = ['date', 'desc'];

$smarty->assign('_GET', $_GET);

if (!empty($_GET)) {

    $filter = [];

    if (!empty($_GET['keywords'])) {
        $filter[] = 'name LIKE \'%' . $adverts->mysqli->escape_string($_GET['keywords']) . '%\'';
    }
    if (!empty($_GET['search'])) {
        $filter[] = 'name LIKE \'%' . $adverts->mysqli->escape_string($_GET['search']) . '%\'';
    }
    if (!empty($_GET['section'])) {
        $filter[] = 'section = \'' . $adverts->mysqli->escape_string($_GET['section']) . '\'';
        $smarty->assign('selected_section_categories', $sections->GetSectionCategories($_GET['section']));
    }
    if (!empty($_GET['category'])) {
        $filter[] = 'category = \'' . $adverts->mysqli->escape_string($_GET['category']) . '\'';
        $smarty->assign('selected_category_subcategories', $sections->GetCategorySubcategories($_GET['category']));
    }
    if (!empty($_GET['subcategory'])) {
        $filter[] = 'subcategory = \'' . $adverts->mysqli->escape_string($_GET['subcategory']) . '\'';
    }
    if (!empty($_GET['securedeal']) AND count($_GET['securedeal']) === 1) {
        $secureDeal = ($_GET['securedeal'] == 'on') ? 1 : 0;
        $filter[] = 'secure_deal = \'' . $adverts->mysqli->escape_string($secureDeal) . '\'';
    }
    if (!empty($_GET['author'])) {
        $filter[] = 'author = \'' . $adverts->mysqli->escape_string($_GET['author']) . '\'';
        $smarty->assign('author', $users->Get($_GET['author']));
    }
    if (!empty($_GET['location'])) {

        $locations = explode(', ', $_GET['location']);
        foreach ($locations as $location) {
            $filter[] = 'location LIKE \'%' . $adverts->mysqli->escape_string($location) . '%\'';
        }
    }
    if (!empty($_GET['date'])) {

        $date = date('Y-m-d H:i:s', strtotime('- ' . $_GET['date'] . ' hours'));
        $filter[] = 'date >= \'' . $adverts->mysqli->escape_string($date) . '\'';
    }

    foreach ($_GET as $key => $value) {
        if ((stripos($key, 'min') !== false OR stripos($key, 'max') !== false) AND !empty($value)) {

            $type = explode('_', $key);

            $i = ($type[1] == 'min') ? '>=' : '<=';

            $value = $adverts->mysqli->escape_string($value);

            $filter[] = "CAST(JSON_EXTRACT(prices, '$.$type[0]') as DECIMAL(16,8)) $i $value";
        }
    }

    if (!empty($_GET['sort'])) {
        if ($_GET['sort'] == 'date_desc') {
            $sort = ['date', 'desc'];
        } elseif ($_GET['sort'] == 'price_desc') {
            $sort = ['price', 'desc'];
        } elseif ($_GET['sort'] == 'price_asc') {
            $sort = ['price', 'asc'];
        }
    }

    if (!empty($_GET['page'])) {
        $limit = (int)$_GET['page'] * 64;
    } else {
        $limit = 64;
    }

    if (!empty($filter)) {
        $allAdverts = $adverts->GetAll('status = 2 AND ' . implode(' AND ', $filter), $limit, $sort);
        $smarty->assign('adverts', $allAdverts);
        $smarty->assign('advertsCount', $adverts->getCount('status = 2 AND ' . implode(' AND ', $filter)));
    } else {
        $allAdverts = $adverts->GetAll('status = 2', $limit, $sort);
        $smarty->assign('adverts', $allAdverts);
        $smarty->assign('advertsCount', $adverts->getCount('status = 2'));
    }
} else {
    $allAdverts = $adverts->GetAll('status = 2', 64, $sort);
    $smarty->assign('adverts', $allAdverts);
    $smarty->assign('advertsCount', $adverts->getCount('status = 2'));
}

$typeFilters = [];
foreach ($_GET as $key => $value) {
    if ((stripos($key, '_min') !== false OR stripos($key, '_max')) AND mb_stripos($key, 'выберите') === false AND !empty($value)) {
        $type = str_ireplace('_min', '', $key);
        $type = str_ireplace('_max', '', $type);

        $i = (stripos($key, '_min') !== false) ? 'min' : 'max';

        if (empty($typeFilters[$type])) $typeFilters[$type] = ['min' => 0, 'max' => 0];
        $typeFilters[$type][$i] = $value;
    }
}

$smarty->assign('typeFilters', $typeFilters);
$smarty->assign('filters', $_GET);

$smarty->assign('page_title', 'Ошибка 404');

$smarty->display('404.tpl');