<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 19:13
 */

$safe_mode_disable = true;

require_once __DIR__.'/engine/autoload.php';

if (!empty($_GET['page'])) {

    $page = $_GET['page'];

    if ($page == 'about_us') {
        $smarty->assign('page_title', 'О нас');
        $smarty->display('pages/about_us.tpl');
    } elseif ($page == 'terms_of_use') {
        $smarty->assign('page_title', 'Пользовательское соглашение');
        $smarty->display('pages/terms_of_use.tpl');
    } elseif ($page == 'cookie_policy') {
        $smarty->assign('page_title', 'Политика Cookie');
        $smarty->display('pages/cookie_policy.tpl');
    } elseif ($page == 'help') {

        $smarty->assign('page_title', 'Помощь');

        if (empty($_GET['id'])) {
            $smarty->display('pages/help.tpl');
        } else{
            $article_id = $_GET['id'];
            if (file_exists(__DIR__.'/template/pages/help/'.$article_id.'.tpl')) {
                $smarty->display('pages/help/'.$article_id.'.tpl');
            } else{
                header('Location: /pages.php?page=help');
            }
        }

    } elseif ($page == 'support_the_project') {
        $smarty->assign('page_title', 'Поддержать проект');
        $smarty->display('pages/support_the_project.tpl');
    } elseif ($page == 'wishes') {
        $smarty->assign('page_title', 'Пожелания');
        $smarty->display('pages/wishes.tpl');
    } else{
        header('Location: /');
    }
} else{
    header('Location: /');
}
