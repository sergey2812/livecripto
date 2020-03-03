<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 20.09.2018
 * Time: 10:01
 */

$admin_area = true;

require_once __DIR__.'/../engine/autoload.php';

$smarty->assign('page_title', 'Клиенты');

if (!empty($_POST['function']))
    {
        $function = $_POST['function'];

        if ($function == 'ban' AND !empty($_POST['id_user_to']))
            {
                $users->Update($_POST['id_user_to'], ['banned' => 1, 'banned_cause' => 0, 'banned_date' => date('Y-m-d H:i:s')]);

                $last_row_id = $users->GetIdLastRowUserBanned($_POST['id_user_to']);

                if ($last_row_id != 0)
                    {
                        $result = $users->UpdateLastRowUserBanned($last_row_id, $_POST['message'], date('Y-m-d H:i:s'), $_POST['id_admin']);
                    }
                else
                    {
                        $ban_unban = 1;
                        $result = $users->CreateAdminCommentForUserBanned($_POST['id_user_to'], $_POST['message'], date('Y-m-d H:i:s'), $_POST['id_admin'], $ban_unban);
                    }

            } 
        elseif ($function == 'unban' AND !empty($_POST['id_user_to']))
            {
                $users->Update($_POST['id_user_to'], ['banned' => 0]);

                $ban_unban = 0;
                $result = $users->CreateAdminCommentForUserBanned($_POST['id_user_to'], $_POST['message'], date('Y-m-d H:i:s'), $_POST['id_admin'], $ban_unban);
            }       
           
    }

if ($_GET['type'] == 'banned') 
    {
        if (!empty($_POST['search']))
            {
                $search = $adverts->mysqli->escape_string($_POST['search']);
                $search_mysql = " AND (login LIKE '%$search%' OR email LIKE '%$search%')";
            } 
        else
            {
                $search = '';
                $search_mysql = '';
            }

        if (!empty($_POST['function']))
            {
                $function = $_POST['function'];
                if ($function == 'modal_unban' AND !empty($_POST['id_user_to']))
                    { 
                        $banned_users = $users->GetAllRowForUserBanned($_POST['id_user_to']);

                        $user_to = $users->get($_POST['id_user_to']);

                        $smarty->assign('banned_users', $banned_users);
                        $smarty->assign('user_to', $user_to); 

                        $hidden_rows = 0;
                        $smarty->assign('hidden_rows', $hidden_rows); 

                        $all_users = $users->GetAll('banned > \'0\''.$search_mysql, 0, true);

                        $smarty->assign('all_users', $all_users);
                        $smarty->assign('search', $search);
                        $smarty->display('admin/pages/clients/banned.tpl');
                    }
                
                elseif ($function == 'modal_open' AND !empty($_POST['id_user_to']))
                    { 
                        $banned_users = $users->GetAllRowForUserBanned($_POST['id_user_to']);

                        $user_to = $users->get($_POST['id_user_to']);

                        $smarty->assign('banned_users', $banned_users);
                        $smarty->assign('user_to', $user_to); 

                        $hidden_rows = 1;
                        $smarty->assign('hidden_rows', $hidden_rows); 

                        $all_users = $users->GetAll('banned > \'0\''.$search_mysql, 0, true);

                        $smarty->assign('all_users', $all_users);
                        $smarty->assign('search', $search);
                        $smarty->display('admin/pages/clients/banned.tpl');
                    }

                else
                    {
                        $hidden_rows = 0;
                        $smarty->assign('hidden_rows', $hidden_rows);
                        $all_users = $users->GetAll('banned > \'0\''.$search_mysql, 0, true);

                        $smarty->assign('all_users', $all_users);
                        $smarty->assign('search', $search);
                        $smarty->display('admin/pages/clients/banned.tpl');
                    } 
            }
        else
            {        
                $hidden_rows = 0;
                $smarty->assign('hidden_rows', $hidden_rows);
                $all_users = $users->GetAll('banned > \'0\''.$search_mysql, 0, true);

                $smarty->assign('all_users', $all_users);
                $smarty->assign('search', $search);
                $smarty->display('admin/pages/clients/banned.tpl');
            }            
    }

elseif ($_GET['type'] == 'chat')
    {
        $smarty->assign('page_title', 'Чат: ответы админа на запросы клиентов');

        $chats = new \LiveinCrypto\Chats();

        if (!empty($_GET['admin_id']) AND isset($_GET['chat_id']) AND $_GET['chat_id'] == 0 AND !empty($_GET['user_id'])) 
            {
                $chats->CreateChatWithAdmin($_GET['admin_id'], $_GET['user_id'], ''); 
                global  $chat_admin_last_id;
                $chat = $chats->GetForAdmin($chat_admin_last_id, $_GET['user_id']);

                header('Location: /admin/clients.php?type=chat&admin_id='.$_GET['admin_id'].'&user_id='.$_GET['user_id'].'&chat_id='.$chat_admin_last_id);
            }        

        if (!empty($_GET['admin_id']) AND !empty($_GET['chat_id']) AND !empty($_GET['user_id']) AND $_GET['chat_id'] > 0) 
            {
                $chat = $chats->GetForAdmin($_GET['chat_id'], $_GET['user_id']);

                if (!$chat->getTo())
                    {
                        // записать id админа в таблицу чатов
                        $chats->AcceptChatWithAdmin($_GET['admin_id'], $_GET['chat_id']);
                    }

                $last_admin_chat = $chats->GetLastChatAdminByUserId($user->getId());

                if (!empty($last_admin_chat) AND $last_admin_chat[0]->getStatus() == 2)
                    {
                        $chats->CreateChatWithAdmin($_GET['admin_id'], $_GET['user_id'], '');
                        global  $chat_admin_last_id;
                        $chat = $chats->GetForAdmin($chat_admin_last_id, $_GET['user_id']);

                        header('Location: /admin/clients.php?type=chat&admin_id='.$_GET['admin_id'].'&user_id='.$_GET['user_id'].'&chat_id='.$chat_admin_last_id);                        
                    } 
                
                $chat = $chats->GetForAdmin($_GET['chat_id'], $_GET['user_id']);
            }
        
        $smarty->assign('chat', $chat);
        $all_chats = $chats->GetChatsAdminByUser($_GET['user_id']);
        $smarty->assign('chats', $all_chats); 

        $smarty->display('admin/pages/clients/chat_admin.tpl');           
    }

else
    {
        if (!empty($_POST['search']))
            {
                $search = $adverts->mysqli->escape_string($_POST['search']);
                $search_mysql = "login LIKE '%$search%' OR email LIKE '%$search%'";
            } 
        else
            {
                $search = '';
                $search_mysql = '';
            }

        if (!empty($_POST['function']))
            {
                $function = $_POST['function'];
                if ($function == 'modal_ban' AND !empty($_POST['id_user_to']))
                    { 
                        $banned_users = $users->GetAllRowForUserBanned($_POST['id_user_to']);

                        $user_to = $users->get($_POST['id_user_to']);

                        $stats = $_POST['stats'];
                        
                        $smarty->assign('stats', $stats);
                        $smarty->assign('banned_users', $banned_users);
                        $smarty->assign('user_to', $user_to);

                        $all_users = $users->GetAll($search_mysql, 0, true);
                        $smarty->assign('all_users', $all_users);
                        $smarty->assign('search', $search);
                        $smarty->display('admin/pages/clients/all.tpl');                          
                    }
                else
                    {
                        $all_users = $users->GetAll($search_mysql, 0, true);
                        $smarty->assign('all_users', $all_users);
                        $smarty->assign('search', $search);
                        $smarty->display('admin/pages/clients/all.tpl');
                    } 
            }
        else
            {        
                $all_users = $users->GetAll($search_mysql, 0, true);

                $smarty->assign('all_users', $all_users);
                $smarty->assign('search', $search);
                $smarty->display('admin/pages/clients/all.tpl');
            }

    }