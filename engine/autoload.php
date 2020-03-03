<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 2:39
 */

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header('Content-Type: text/html; charset=utf-8', true); //UTF-8 Charset

require_once __DIR__.'/../composer/vendor/autoload.php'; //Composer

$smarty = new Smarty();
$smarty->setTemplateDir(__DIR__.'/../template/');
//$smarty->debugging = true;

$config = new \LiveinCrypto\Config();
$adverts = new \LiveinCrypto\Adverts();
$users = new \LiveinCrypto\Users();
$sections = new \LiveinCrypto\Sections();
$locations = new \LiveinCrypto\Locations();
$banneds = new \LiveinCrypto\Banneds();
$currencies = new \LiveinCrypto\Currencies();
$ads = new \LiveinCrypto\Ads();
$notifications = new \LiveinCrypto\Notifications();
$rates = new \LiveinCrypto\ExchangeRates();
$chats = new \LiveinCrypto\Chats();
$top_4_prices = new \LiveinCrypto\Top_4_prices();
$update_prices = new \LiveinCrypto\Update_prices();


$mail = new \LiveinCrypto\Mail($smarty);


$smarty->assign('Users', $users);
$smarty->assign('Chats', $chats);
$smarty->assign('Adverts', $adverts);
$smarty->assign('Rates', $rates);
$smarty->assign('_GET', $_GET);
$smarty->assign('_COOKIE', $_COOKIE);
$smarty->assign('banneds', $banneds);
$smarty->assign('cryptos', $currencies);
$smarty->assign('countries', $locations);
$smarty->assign('top_4_prices', $top_4_prices);
$smarty->assign('update_prices', $update_prices);
$smarty->assign('sections_table', $sections);

$smarty->assign('currencies', $rates->getCurrencies()); // старый вариант переменной с валютами только с полями Name и Code
$smarty->assign('all_cryptos', $currencies->getAllCryptos()); // новый вариант переменной с валютами со всеми полями

$smarty->assign('all_cryptos_bs', $currencies->getAllCryptosBs()); // новый вариант переменной с валютами со всеми полями для БС

$smarty->assign('all_clients_payment_top', $top_4_prices->getAllClientsPaymentTop());

$smarty->assign('all_clients_payment_update', $update_prices->getAllClientsPaymentUpdate());

$smarty->assign('all_secure_deals', $adverts->GetAllSecureDeals());

$smarty->assign('count_secure_deals', $adverts->getCountSecureDeals());


if (!empty($_POST['token'])){
    $new_user = file_get_contents('http://ulogin.ru/token.php?token=' . $_POST['token'] . '&host=' . $_SERVER['HTTP_HOST']);
    $new_user = json_decode($new_user, true);
    if (!empty($new_user)){
        if (!empty($new_user['network']) AND !empty($new_user['uid'])){
            $users->AuthSocial($new_user);
        }
    }
}

$user = $users->Verify();
if (empty($safe_mode_disable) OR !$safe_mode_disable) {

    if ($user === false) {
        $users->Logout();
        header("Location: " . $config->login_page);
        die();
    }

}
if ($user !== false){
    $smarty->assign('user', $user);
    $smarty->assign('user_wallets', $user->getWallets());
    $smarty->assign('notifications', $notifications->GetNotifications($user->getId()));
    $smarty->assign('msgCount', $users->getMessagesCount($user->getId()));
    $smarty->assign('admin_msgCount', $users->getAdminMessagesCount($user->getId()));
} else{
    $users->Logout();
    $smarty->assign('user', null);
}

if (!empty($admin_area) AND $admin_area === true AND $user->getPermissions() >= 6){
    header("Location: " . $config->login_page);
    die();
}

$smarty->assign('files_dir', $config->files_dir);
$smarty->assign('template', $config->template_dir);
$smarty->assign('template_admin', $config->template_dir.'/admin');
$smarty->assign('login_page', $config->login_page);
$smarty->assign('logout_page', $config->logout_page);
$smarty->assign('title', $config->title);

$smarty->assign('settings', new \LiveinCrypto\Settings());

$smarty->assign('sections', $sections->GetSections());

$smarty->assign('locations', $locations->GetLocations());

$smarty->assign('locations_cities', $locations->GetCities());

$breadcrumbs = new \LiveinCrypto\Breadcrumbs();
$smarty->assign('breadcrumbs', $breadcrumbs->Get());

$smarty->assign('favorites_helper', new \LiveinCrypto\Helpers\Favorites());


$world = 'Весь МИР';
$world_id = $locations->GetCountryIdByName($world);
    
$city_id = (!empty($_GET['location_name']) ? $locations->GetCityIdByName($_GET['location_name']) : 0);
$country_id = (!empty($_GET['location']) ? $_GET['location'] : $world_id);

$sec_id = (!empty($_GET['section']) ? $_GET['section'] : 0);
$cat_id = (!empty($_GET['category']) ? $_GET['category'] : 0);
$subcat_id = (!empty($_GET['subcategory']) ? $_GET['subcategory'] : 0);

$smarty->assign('ads', $ads);

// получаем массивы id-шников топовых объявлений
$pos_top_1 = $top_4_prices->getAllTopAdvertsIdByPosition(1, $country_id, $city_id, $sec_id, $cat_id, $subcat_id);
$pos_top_2 = $top_4_prices->getAllTopAdvertsIdByPosition(2, $country_id, $city_id, $sec_id, $cat_id, $subcat_id);
$pos_top_3 = $top_4_prices->getAllTopAdvertsIdByPosition(3, $country_id, $city_id, $sec_id, $cat_id, $subcat_id);
$pos_top_4 = $top_4_prices->getAllTopAdvertsIdByPosition(4, $country_id, $city_id, $sec_id, $cat_id, $subcat_id);

$exchangerates = new \LiveinCrypto\ExchangeRates();
$today_rates = [];
$today_rates[] = $exchangerates->GetExchangeRate('btc');
$today_rates[] = $exchangerates->GetExchangeRate('eth');
$today_rates[] = $exchangerates->GetExchangeRate('ltc');
$today_rates[] = $exchangerates->GetExchangeRate('xrp');
$smarty->assign('today_rates', $today_rates);
$smarty->assign('exchangerates', $exchangerates);

$today_rates_widget = $exchangerates->GetLastExchangeRates(28);
$smarty->assign('today_rates_widget', $today_rates_widget);

$main_section = (!empty($_GET['section'])) ? $_GET['section'] : 1;
if (!empty($_GET['section']) AND is_array($_GET['section'])) $main_section = $_GET['section'][0];

$main_category = (!empty($_GET['category'])) ? $_GET['category'] : null;

if ($main_category != null) {
    $smarty->assign('subcategories', $sections->GetCategorySubcategories($main_category));
}

$smarty->assign('main_category', $main_category);
$smarty->assign('categories', $sections->GetSectionCategories($main_section));
$smarty->assign('main_section', $sections->GetSection($main_section));

$smarty->assign('all_categories_top', $sections->GetCategories());
$smarty->assign('all_subcategories_top', $sections->GetSubcategories());

if (!empty($_COOKIE['lang']) AND $_COOKIE['lang'] == 'en_US') {

    putenv('LC_ALL=en_US');
    setlocale(LC_ALL, 'en_US');

    bind_textdomain_codeset('lange', 'UTF8');
    bindtextdomain('lang', __DIR__.'/../lang');

    textdomain('lang');

    $smarty->assign('lang', 'en_US');
} else{
    $smarty->assign('lang', 'ru_RU');
}