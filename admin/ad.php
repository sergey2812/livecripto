<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 20.09.2018
 * Time: 10:18
 */

$admin_area = true;

require_once __DIR__.'/../engine/autoload.php';

$smarty->assign('page_title', 'Объявления');

if ($_GET['type'] == 'email') {

    if (!empty($_POST["function"]) AND $_POST["function"] == 'del_mailing' AND !empty($_POST["mailing_id"]))
        {
            $params = [
                        'id' => $_POST["mailing_id"]
                    ];

            $del_mailing = $ads->DeleteMailing($params);
            $smarty->assign('status', $del_mailing);
                

//  $ads->CronMailing();
        }

    

    $smarty->assign('all_mailings', $ads->GetAllMailings());
    $smarty->display('admin/pages/ad/email.tpl');

} elseif ($_GET['type'] == 'block'){

    $smarty->assign('all_ads', $ads->GetAll());
    $smarty->display('admin/pages/ad/block.tpl');

} elseif ($_GET['type'] == 'icon'){

    $smarty->assign('all_ads', $ads->GetAllIcons());
    $smarty->display('admin/pages/ad/icon.tpl');

}

elseif ($_GET['type'] == 'create-email'){

    if (!empty($_POST['status']) AND !empty($_POST['mailing_date']) AND !empty($_POST['name_mailing']) AND !empty($_POST['subject']))
        {
            if (isset($_POST['content']))
                {
                    $content = $_POST['content'];
                }
            else
                {
                    $content = '';
                }

            if (isset($_POST['html']))
                {
                    $html = $_POST['html'];
                }
            else
                {
                    $html = '';
                }                
            $params = [
                'name_mailing' => $_POST['name_mailing'],
                'method' => $_POST['method'],
                'status' => $_POST['status'],
                'subject' => $_POST['subject'],
                'content' => $content,
                'content_html' => $html,
                'creation_date' => date('Y-m-d'),
                'mailing_date' => $_POST['mailing_date'],
                'author_admin' => $_GET['admin_id']
            ];

            $result = $ads->CreateMailing($params);

            if ($result) {
                header('Location: /admin/ad.php?type=email');
                die();
            }
        }

    $smarty->assign('edit_mode', false);
    $smarty->display('admin/pages/ad/create-email.tpl');

} elseif ($_GET['type'] == 'edit-email'){

    if (!empty($_POST['status']) AND !empty($_POST['mailing_date']) AND !empty($_POST['name_mailing']) AND !empty($_POST['subject']) AND (!empty($_POST['content']) OR !empty($_POST['html'])))
        {
            $result = $ads->UpdateMailing($_GET['id'], [
                'name_mailing' => $_POST['name_mailing'],
                'method' => $_POST['method'],
                'status' => $_POST['status'],
                'subject' => $_POST['subject'],
                'content' => !empty($_POST['content']) ? $_POST['content'] : '',
                'content_html' => !empty($_POST['html']) ? $_POST['html'] : '',
                'creation_date' => date('Y-m-d'),
                'mailing_date' => $_POST['mailing_date'],
                'author_admin' => $_GET['admin_id']
            ]);

            if ($result) {
                header('Location: /admin/ad.php?type=email');
                die();
            }
        }

    $smarty->assign('ad', $ads->GetMailing($_GET['id']));
    $smarty->assign('edit_mode', true);
    $smarty->display('admin/pages/ad/create-email.tpl');

}

elseif ($_GET['type'] == 'create-block'){

    if (!empty($_POST['status']) AND !empty($_POST['date_start']) AND !empty($_POST['date_end']) AND !empty($_POST['name']) AND !empty($_POST['html']) AND !empty($_POST['title']) AND !empty($_POST['description'])){

        $result = $ads->Create([
            'status' => $_POST['status'],
            'date_start' => $_POST['date_start'],
            'date_end' => $_POST['date_end'],
            'name' => $_POST['name'],
            'content' => $_POST['html'],
            'title' => $_POST['title'],
            'description' => $_POST['description'],
            'section' => !empty($_POST['section']) ? $_POST['section'] : null,
            'category' => !empty($_POST['category']) ? $_POST['category'] : null,
            'subcategory' => !empty($_POST['subcategory']) ? $_POST['subcategory'] : null,
            'position' => $_POST['position']
        ]);

        if ($result) {
            header('Location: /admin/ad.php?type=block');
            die();
        }

    }

    $smarty->assign('sections', $sections->GetSections());
    $smarty->assign('edit_mode', false);
    $smarty->display('admin/pages/ad/create-block.tpl');

} elseif ($_GET['type'] == 'edit-block'){

    if (!empty($_POST['status']) AND !empty($_POST['date_start']) AND !empty($_POST['date_end']) AND !empty($_POST['name']) AND !empty($_POST['html']) AND !empty($_POST['title']) AND !empty($_POST['description'])){

        $result = $ads->Update($_GET['id'], [
            'status' => $_POST['status'],
            'date_start' => $_POST['date_start'],
            'date_end' => $_POST['date_end'],
            'name' => $_POST['name'],
            'content' => $_POST['html'],
            'title' => $_POST['title'],
            'description' => $_POST['description'],
            'section' => !empty($_POST['section']) ? $_POST['section'] : null,
            'category' => !empty($_POST['category']) ? $_POST['category'] : null,
            'subcategory' => !empty($_POST['subcategory']) ? $_POST['subcategory'] : null,
            'position' => $_POST['position']
        ]);

        if ($result) {
            header('Location: /admin/ad.php?type=block');
            die();
        }

    }

    $smarty->assign('ad', $ads->Get($_GET['id']));
    $smarty->assign('all_cats', $sections->GetCategories());
    $smarty->assign('edit_mode', true);
    $smarty->display('admin/pages/ad/create-block.tpl');

} elseif ($_GET['type'] == 'create-icon'){

    if (!empty($_POST['status']) AND !empty($_POST['date_start']) AND !empty($_POST['date_end']) AND !empty($_POST['name']) AND !empty($_POST['html']) AND !empty($_POST['title'])){

        $result = $ads->CreateIcon([
            'status' => $_POST['status'],
            'date_start' => $_POST['date_start'],
            'date_end' => $_POST['date_end'],
            'name' => $_POST['name'],
            'content' => $_POST['html'],
            'title' => $_POST['title'],
            'section' => !empty($_POST['section']) ? $_POST['section'] : null,
            'category' => !empty($_POST['category']) ? $_POST['category'] : null,
            'subcategory' => !empty($_POST['subcategory']) ? $_POST['subcategory'] : null
        ]);

        if ($result) {
            header('Location: /admin/ad.php?type=icon');
            die();
        }

    }

    $smarty->assign('sections', $sections->GetSections());
    $smarty->assign('edit_mode', false);
    $smarty->display('admin/pages/ad/create-icon.tpl');

} elseif ($_GET['type'] == 'edit-icon'){

    if (!empty($_POST['status']) AND !empty($_POST['date_start']) AND !empty($_POST['date_end']) AND !empty($_POST['name']) AND !empty($_POST['title'])){

        $result = $ads->UpdateIcon($_GET['id'], [
            'status' => $_POST['status'],
            'date_start' => $_POST['date_start'],
            'date_end' => $_POST['date_end'],
            'name' => $_POST['name'],
            'content' => $_POST['html'],
            'title' => $_POST['title'],
            'section' => !empty($_POST['section']) ? $_POST['section'] : null,
            'category' => !empty($_POST['category']) ? $_POST['category'] : null,
            'subcategory' => !empty($_POST['subcategory']) ? $_POST['subcategory'] : null,
        ]);

        if ($result) {
            header('Location: /admin/ad.php?type=icon');
            die();
        }

    }

    $smarty->assign('ad', $ads->GetIcon($_GET['id']));
    $smarty->assign('all_cats', $sections->GetCategories());
    $smarty->assign('edit_mode', true);
    $smarty->display('admin/pages/ad/create-icon.tpl');

} 

elseif ($_GET['type'] == 'payment-top')
    {
        if (!empty($_POST['action']) AND $_POST['action'] == 'Принять заявку' AND !empty($_POST['control_start_date']) AND !empty($_POST['control_end_date']) AND !empty($_POST['advert_top_id']))
            {
                
                $start = date('Y.m.d', strtotime($_POST['control_start_date']));
                
                $end = date('Y.m.d', strtotime($_POST['control_end_date']));

                $params = [
                            'id' => $_POST["advert_top_id"],
                            'start_date' => $start,
                            'end_date' => $end,
                            'status' => 2
                        ];

                $advert_top_status = $top_4_prices->TakeClientsPaymentTop($params);

                $smarty->assign('status', $advert_top_status);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            }

        if (!empty($_POST['action']) AND $_POST['action'] == 'Отклонить' AND !empty($_POST['away_date']) AND !empty($_POST['advert_top_id']))
            {
                $params = [
                            'id' => $_POST["advert_top_id"],
                            'end_date' => date('Y-m-d'),
                            'status' => 3
                        ];

                $advert_top_status = $top_4_prices->AwayClientsPaymentTop($params);

                $smarty->assign('status', $advert_top_status);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            }            
        
        $smarty->display('admin/pages/advertising/payment_top.tpl');
    }

elseif ($_GET['type'] == 'payment-update')
    {
        if (!empty($_POST['action']) AND $_POST['action'] == 'Принять заявку' AND !empty($_POST['control_date']) AND !empty($_POST['id_row_clients_update']) AND !empty($_POST['id_row_clients_update']))
            {
                $start = date('Y.m.d', strtotime($_POST['control_date']));
                
                $params = [
                            'id' => $_POST['id_row_clients_update'],
                            'start_date' => $start,
                            'advert_id' => $_POST['advert_id_from_adverts'],
                            'status' => 2
                        ];

                $advert_update_status = $update_prices->TakeClientsPaymentUpdate($params);

                $smarty->assign('status', $advert_update_status);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            }

        if (!empty($_POST['action']) AND $_POST['action'] == 'Отклонить' AND !empty($_POST['away_date']) AND !empty($_POST['advert_update_id']))
            {
                $params = [
                            'id' => $_POST["advert_update_id"],
                            'away_date' => date('Y-m-d'),
                            'status' => 3
                        ];

                $advert_update_status = $update_prices->AwayClientsPaymentUpdate($params);

                $smarty->assign('status', $advert_update_status);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            } 
        
        $smarty->display('admin/pages/advertising/payment_update.tpl');
    }

elseif ($_GET['type'] == 'secure-deal')
    {
        if (!empty($_POST['action']) AND $_POST['action'] == 'Подтвердить перевод' AND !empty($_POST['deal_id']) AND !empty($_POST['summ_to_seller']) AND !empty($_POST['royalty']) AND !empty($_POST['admin_id']))
            {

                $params = [
                            'id' => $_POST["deal_id"],
                            'admin_id' => $_POST['admin_id'],
                            'summ_to_seller' => $_POST['summ_to_seller'],
                            'royalty' => $_POST['royalty'],
                            'status' => 1
                        ];

                $deal_status = $adverts->UpdateSecureDealPayed($params);

                $smarty->assign('status', $deal_status);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            }

        if (!empty($_POST['action']) AND $_POST['action'] == 'Отправить перевод продавцу' AND !empty($_POST['deal_id']))
            {

                $adverts->UpdateSendPayToSellerDate($_POST["deal_id"]);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            }  

        if (!empty($_POST['action']) AND $_POST['action'] == 'Перевод НЕ пришел' AND !empty($_POST['deal_id']) AND !empty($_POST['admin_id']))
            {

                $params = [
                            'id' => $_POST["deal_id"],
                            'admin_id' => $_POST['admin_id'],
                            'status' => 6
                        ];

                $deal_status = $adverts->UpdateSecureDealNoPayed($params);

                $smarty->assign('status', $deal_status);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            }

        if (!empty($_POST['action']) AND $_POST['action'] == 'Есть решение по арбитражу? Да, завершить сделку!' AND !empty($_POST['deal_id']) AND !empty($_POST['admin_id']))
            {

                $params = [
                            'id' => $_POST["deal_id"]
                        ];

                $deal_status = $adverts->SecureDealArbitrationDelete($params);

                $smarty->assign('status', $deal_status);

                header("Location: {$_SERVER['HTTP_REFERER']}");
            }              

        $smarty->display('admin/pages/advertising/secure_deals.tpl');
    }        

else{
    $smarty->assign('title_type', 'ТОП-4');
    $smarty->assign('all_adverts', $adverts->GetAll());
    $smarty->display('admin/pages/adverts/all.tpl');
}