<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 19:56
 */


require_once __DIR__.'/engine/autoload.php';

$page = (!empty($_GET['page'])) ? $_GET['page'] : '';
$smarty->assign('page', $page);

if (!empty($_GET['user_id']) AND ($user->getPermissions() <= 5 OR ($_GET['page'] == 'my_sells' OR $_GET['page'] == 'my_adverts')))
    {
        $smarty->assign('mainUser', $user);
        $user = $users->Get($_GET['user_id']);

        if ($user === false) header('Location: /404.php');

        $smarty->assign('user', $user);
        $smarty->assign('user_id', $_GET['user_id']);
    } 

elseif (!empty($_GET['user_id']))
    {
        header('Location /dashboard.php');
        die();
    }

if ($page == 'wallets') 
    {
        $smarty->assign('page_title', 'Кошелёк');
        $smarty->display('dashboard/wallets.tpl');
    } 

elseif ($page == 'chat') 
    {
        $smarty->assign('page_title', 'Чат');

        $chats = new \LiveinCrypto\Chats();

        $type = (!empty($_GET['type']) AND $_GET['type'] == 'buy') ? 'buy' : 'sell';

        $all_chats = $chats->GetChatsByUser($user->getId(), $type);

        if (!empty($all_chats)) 
            {
                $smarty->assign('chats', $all_chats);
            }


        if (!empty($_GET['new_chat']) AND !empty($_GET['subject'])) 
            {
                $chat_fierst = 1;
                $smarty->assign('chat_fierst', $chat_fierst);

                $uncorrect_status = '0,1,2,3,6,7,8'; // это номера некорректного статуса завершеной сделки, только для объявления, по которому сделка завершена на 4 можно открывать новый чат, а для объявлений в сделках с этими статусами нельзя открывать новые чаты

                $uncorrect_deals = $adverts->GetDeals("status IN ($uncorrect_status)"); // получаем для заданных статусов в $uncorrect_deals массив cо всеми сделками, завершенными НЕ на 4

                $smarty->assign('deals', $uncorrect_deals);

                $new_chat = '';

                foreach ($uncorrect_deals as $uncorrect_deal)
                    {
                        $deal_status = $uncorrect_deal->getStatus();  // из каждой сделки, завершенной НЕ на 4, получаем статус сделки для контроля
                      

                        $deal_advert = $uncorrect_deal->getAdvert();  // для каждой сделки, завершенной НЕ на 4, получаем строку объявления

                        $deal_uncorrect_advert_id = $deal_advert->getId(); // из каждой строки объявления, из сделки, завершенной НЕ на 4, получаем id объявления, для которого нельзя открывать новые чаты.

                        if ($_GET['advert'] == $deal_uncorrect_advert_id)
                        {
                            
                            $new_chat = 'no';
                        }

                    }

                // Если любой статус сделки, кроме 4, и user есть автор объявления, то открываем только имеющийся чат
                if ($_GET['new_chat'] == $user->getId() && $new_chat == 'no') 
                    {
                        header('Location: /dashboard.php?page=chat&type=buy&chat_id='.$_GET['new_chat']);
                                die();
                    } 
                else
                    {
                        $chat_id = $chats->GetChatByUserId($user->getId(), $_GET['new_chat'], $_GET['subject'], $_GET['advert']);

                        $deal_id = $chats->GetDealIdFromChat($user->getId(), $_GET['new_chat'], $_GET['subject'], $_GET['advert']); 

                        $correct_status = '4';
                        $correct_deals = $adverts->GetDeals("status IN ($correct_status)");

                        $new_corr_chat = 'no';

                        foreach ($correct_deals as $correct_deal)
                            {
                                $deal_corr_status = $correct_deal->getStatus();  // из каждой сделки, завершенной на 4, получаем статус сделки для контроля
                              
                                $deal_corr_advert = $correct_deal->getAdvert();  // для каждой сделки, завершенной на 4, получаем строку объявления

                                $deal_corr_advert_id = $deal_corr_advert->getId(); // из каждой строки объявления, из сделки, завершенной на 4, получаем id объявления, для которого надо открывать новые чаты.

                                $deal_corr_chat_id = $correct_deal->getChat(); // из каждой сделки, завершенной на 4, получаем id чата, для проверки соответствия сделки чату.

                                if ($_GET['advert'] == $deal_corr_advert_id)
                                {
                                    
                                    if ($chat_id == $deal_corr_chat_id && $deal_corr_status < 4)
                                        {
                                            $new_corr_chat = 'no';
                                        }
                                    if ($chat_id == $deal_corr_chat_id && $deal_corr_status == 4)
                                        {
                                            $new_corr_chat = 'yes';
                                        }                                       
                                }
                            }                        

                        // Если любой статус сделки, кроме 4, и user не автор объявления, то открываем только имеющийся чат
                        if ($chat_id > 0 && $new_chat == 'no') 
                            {
                                header('Location: /dashboard.php?page=chat&type=buy&chat_id='.$chat_id);
                                die();
                            }
                        // Если статус сделки 4, и user не автор объявления, но уже есть начатый чат по данному товару, то открываем только имеющийся чат 
                        elseif ($chat_id > 0 && $new_chat == '' && $new_corr_chat == 'no') 
                            {
                                header('Location: /dashboard.php?page=chat&type=buy&chat_id='.$chat_id);
                                die();
                            }
                        // Если user не автор объявления и статус предыдущих сделок только 4, то открываем новый чат 
                        else
                            {
                                // Если статус сделки 4, то создаем новый чат с таким же товаром для того же покупателя                                
                                $chats->CreateChat($user->getId(), $_GET['new_chat'], $_GET['subject'], '', $_GET['advert']);

                global  $chat_last_id;

                                header('Location: /dashboard.php?page=chat&type=buy&chat_id='.$chat_last_id);
                            }
                    }
            }

        elseif (!empty($_GET['chat_id']))
            {

                $chat_id = $_GET['chat_id'];
                $smarty->assign('chat', $chats->Get($chat_id, $user->getId()));
                $chat_fierst = 1;
                $smarty->assign('chat_fierst', $chat_fierst);

            } 
        else
            {
                if (!empty($all_chats)) 
                    {
                        $smarty->assign('chat', $all_chats[0]);
                        $chat_fierst = 0;
                        $smarty->assign('chat_fierst', $chat_fierst);
                    }
            }

        $smarty->display('dashboard/chat.tpl');
    } 

elseif ($page == 'chat_admin') 
    {
        $smarty->assign('page_title', 'Чат c администратором');

        $chats = new \LiveinCrypto\Chats();

        $all_admin_chats = $chats->GetChatsAdminByUser($user->getId());
        
        if (!empty($all_admin_chats)) 
            {
                $smarty->assign('admin_chats', $all_admin_chats);
            }        

        if (!empty($_GET['new_chat']) || isset($_GET['new_chat']) && $_GET['new_chat'] == 0) 
            {
                $chat_fierst = 0;
                $smarty->assign('chat_fierst', $chat_fierst);

                $last_admin_chat = $chats->GetLastChatAdminByUserId($user->getId());

                if (!empty($last_admin_chat) AND $last_admin_chat[0]->getStatus() == 1)
                    {
                        header('Location: /dashboard.php?page=chat_admin&chat_id='.$last_admin_chat[0]->getId());
                        die();
                    }
                else
                    {
                        $chats->CreateChatWithAdmin($user->getId(), 0, '');
                    }

    global  $chat_admin_last_id;

                header('Location: /dashboard.php?page=chat_admin&chat_id='.$chat_admin_last_id);
                    
            }

        elseif (!empty($_GET['chat_id']) AND $_GET['chat_id'] > 0)
            {              
                $chat_id = $_GET['chat_id'];
                $smarty->assign('chat', $chats->GetForAdmin($chat_id, $user->getId()));
                $chat_fierst = 1;
                $smarty->assign('chat_fierst', $chat_fierst);
            } 
        else
            {
                if (!empty($all_admin_chats)) 
                    {
                        $smarty->assign('chat', $all_admin_chats[0]);
                        $chat_fierst = 0;
                        $smarty->assign('chat_fierst', $chat_fierst);
                    }
            }

        $smarty->display('dashboard/chat_admin.tpl');
    }

elseif($page == 'my_favorites')
    {
        if (!empty($user->getFavorites()))
            {
                $adverts = $adverts->GetAll('id IN ('.implode(', ', $user->getFavorites()).') AND status = 2', 16);
            } 
        else
            {
                $adverts = [];
            }

        $smarty->assign('adverts', $adverts);

        $smarty->assign('page_title', 'Избранное');
        $smarty->display('dashboard/my_favorites.tpl');
    } 

elseif($page == 'my_purchases')
    {

        $type = (!empty($_GET['type'])) ? $_GET['type'] : '';
        if ($type == 'open')
            {
                $smarty->assign('type', 'open');
                $status = '1, 2, 3';

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'purchases-open');
                    }
            } 
        elseif ($type == 'close')
            {
                $smarty->assign('type', 'close');
                $status = '4, 6, 7, 8';

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'purchases-close');
                    }
            } 
        else
            {
                $smarty->assign('type', 'moderation');
                $status = 0;

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'purchases');
                    }
            }

        $buyer_id = $adverts->mysqli->escape_string($user->getId());

        $user_deals = $adverts->GetDeals("status IN ($status) AND buyer_id = '$buyer_id'");

        $smarty->assign('deals', $user_deals);

        $smarty->assign('page_title', 'Мои покупки');
        $smarty->display('dashboard/my_purchases.tpl');

    } 

elseif($page == 'my_sells')
    {
        $type = (!empty($_GET['type'])) ? $_GET['type'] : '';
        if (!empty($_GET['user_id'])) $type = 'close';
        if ($type == 'open')
            {
                $smarty->assign('type', 'open');
                $status = '1, 2, 3';

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'sells-open');
                    }
            } 

        elseif ($type == 'close')
            {
                $smarty->assign('type', 'close');
                $status = '4, 6, 7, 8';

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'sells-close');
                    }
            } 

        else
            {
                $smarty->assign('type', 'moderation');
                $status = 0;

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'sells');
                    }
            }

        $seller_id = $adverts->mysqli->escape_string($user->getId());

        $deals = $adverts->GetDeals("status IN ($status) AND seller_id = '$seller_id'");

        $smarty->assign('deals', $deals);

        $smarty->assign('page_title', 'Мои продажи');
        $smarty->display('dashboard/my_sells.tpl');
    } 

elseif($page == 'my_adverts')
    {
        $type = (!empty($_GET['type'])) ? $_GET['type'] : '';
        if ($type == 'moderation')
            {
                $smarty->assign('type', 'moderation');
                $status_id = 1;

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'adverts-moderation');
                    }
            }

        elseif ($type == 'close')
            {
                $smarty->assign('type', 'close');
                $status_id = 3;

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'adverts-close');
                    }
            } 

        else
            {
                $smarty->assign('type', 'open');
                $status_id = 2;

                if (empty($_GET['user_id']))
                    {
                        $notifications->RemoveNotifications($user->getId(), 'adverts');
                    }
            }

        $user_adverts = $adverts->GetUserAdverts($user->getId(), $status_id);

        $smarty->assign('adverts', $user_adverts);
        $smarty->assign('country', $locations);
        $smarty->assign('cryptos', $currencies);
        $smarty->assign('top_4_prices', $top_4_prices);

        $smarty->assign('page_title', 'Мои объявления');
        $smarty->display('dashboard/my_adverts.tpl');

    }

else
    {
        $smarty->assign('page_title', 'Личный кабинет');
        $smarty->display('dashboard/index.tpl');
    }