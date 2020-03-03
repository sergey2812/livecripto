<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 20.09.2018
 * Time: 10:21
 */

$admin_area = true;

require_once __DIR__.'/../engine/autoload.php';

$smarty->assign('page_title', 'Объявления');

if (!empty($_GET['type']) AND $_GET['type'] != 'my')
    {
        if ($_GET['type'] == 'users') 
            {
                $all_users = $users->GetAll('permissions <= 5');

                $smarty->assign('all_users', $all_users);
                $smarty->display('admin/pages/profiles/users.tpl');

            } 
 
        elseif ($_GET['type'] == 'create')
            {
                if (!empty($_POST['login']) AND !empty($_POST['email']) AND !empty($_POST['phone']) AND !empty($_POST['permissions']) AND !empty($_POST['password'])){

                    $params = [
                        'login' => $_POST['login'],
                        'email' => $_POST['email'],
                        'phone' => $_POST['phone'],
                        'password' => $_POST['password'],
                        'permissions' => $_POST['permissions'],
                        'avatar' => (!empty($_POST['avatar'])) ? $_POST['avatar'] : null
                    ];

                    $result = $users->Register($params, false);

                    if ($params !== false)
                        {
                            header('Location: /admin/profiles.php?type=users');
                            die();
                        }
                }

                $smarty->display('admin/pages/profiles/create_profile.tpl');

            } 
        elseif($_GET['type'] == 'edit' AND !empty($_GET['id'])) 
            {

                if (!empty($_POST['password']) OR !empty($_POST['permissions']) OR !empty($_POST['email']) OR !empty($_POST['phone']))
                    {
                        $_POST['avatar'] = (!empty($_POST['avatar'])) ? 'avatars/'.$_POST['avatar'] : null;

                        foreach ($_POST as $key => $value)
                            {
                                if (empty($value))
                                    {
                                        unset($_POST[$key]);
                                    }
                            }

                        $result = $users->Update($_GET['id'], $_POST);

                        if ($result)
                            {
                                header('Location: /admin/profiles.php?type=edit&id='.$_GET['id']);
                                die();
                            }
                    }

                $smarty->assign('profile', $users->Get($_GET['id']));

                $smarty->display('admin/pages/profiles/edit.tpl');
            }
    } 
else
    {
        $user_id = (!empty($_GET['id'])) ? $_GET['id'] : $user->getId();

        if (!empty($_POST['password']) OR !empty($_POST['permissions']) OR !empty($_POST['email']) OR !empty($_POST['phone']))
            {
                $_POST['avatar'] = (!empty($_POST['avatar'])) ? 'avatars/'.$_POST['avatar'] : null;

                        foreach ($_POST as $key => $value)
                            {
                                if (empty($value))
                                    {
                                        unset($_POST[$key]);
                                    }
                            }

                        $result = $users->Update($user_id, $_POST);

                if ($result)
                    {
                        header('Location: /admin/profiles.php?type=my');
                        die();
                    }
            }

        $smarty->assign('profile', $user);

        $smarty->display('admin/pages/profiles/edit.tpl');
    }