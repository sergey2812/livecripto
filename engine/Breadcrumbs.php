<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 19:43
 */

namespace LiveinCrypto;


class Breadcrumbs
{

    /**
     * @var array
     */
    private $array = [];

    /**
     * @var string
     */
    private $path;

    /**
     * @var string
     */
    private $get;
    private $adverts;
    private $users;

    /**
     * Breadcrumbs constructor.
     */
    public function __construct()
    {
        $path = explode('/', $_SERVER['REQUEST_URI']);
        unset($path[0]);
        if (!empty($path)) {
            foreach ($path as $i => $val){
                $path[$i] = strtok($val, '?');
            }
        }
        $this->path = $path;
        $this->get = $_GET;

        $this->adverts = new Adverts();
        $this->users = new Users();
    }

    /**
     * @return array
     */
    public function Get(): array
    {
        $this->array = [
            [
                'name' => _('Главная'),
                'link' => '/'
            ]
        ];

        if($this->path[1] == 'dashboard.php'){
            $this->array[] = [
                'name' => _('Личный кабинет'),
                'link' => '/dashboard.php'
            ];
            if (empty($_GET['page'])){
                $this->array[] = [
                    'name' => _('Кабинет')
                ];
            } elseif ($_GET['page'] == 'wallets'){
                $this->array[] = [
                    'name' => _('Кошелек')
                ];
            } elseif ($_GET['page'] == 'chat'){
                $this->array[] = [
                    'name' => _('Чат')
                ];
            } elseif ($_GET['page'] == 'chat_admin'){
                $this->array[] = [
                    'name' => _('Чат с администратором')
                ];
            } elseif ($_GET['page'] == 'my_favorites'){
                $this->array[] = [
                    'name' => _('Избранное')
                ];
            } elseif ($_GET['page'] == 'my_purchases'){
                $this->array[] = [
                    'name' => _('Мои покупки')
                ];
            } elseif ($_GET['page'] == 'my_sells'){
                if (empty($_GET['user_id'])) {
                    $this->array[] = [
                        'name' => _('Мои продажи')
                    ];
                } else{
                    $userLogin = $this->users->getLogin($_GET['user_id']);
                    array_pop($this->array);
                    $this->array[] = [
                        'name' => $userLogin,
                        'link' => '/dashboard.php?page=my_adverts&user_id='.$_GET['user_id']
                    ];
                    $this->array[] = [
                        'name' => 'Продажи'
                    ];
                }
            } elseif ($_GET['page'] == 'my_adverts'){
                if (empty($_GET['user_id'])) {
                    $this->array[] = [
                        'name' => _('Мои объявления')
                    ];
                } else{
                    $userLogin = $this->users->getLogin($_GET['user_id']);
                    array_pop($this->array);
                    $this->array[] = [
                        'name' => $userLogin,
                        'link' => '/dashboard.php?page=my_adverts&user_id='.$_GET['user_id']
                    ];
                    $this->array[] = [
                        'name' => 'Объявления'
                    ];
                }
            }
        } elseif($this->path[1] == 'create_ad.php'){
            $this->array[] = [
                'name' => _('Создать объявление')
            ];
        } elseif($this->path[1] == 'pages.php'){
            if (empty($_GET)){
                $this->array[] = [
                    'name' => _('Страница')
                ];
            } elseif ($_GET['page'] == 'about_us'){
                $this->array[] = [
                    'name' => _('О нас')
                ];
            } elseif ($_GET['page'] == 'terms_of_use'){
                $this->array[] = [
                    'name' => _('Пользовательское соглашение')
                ];
            } elseif ($_GET['page'] == 'cookie_policy'){
                $this->array[] = [
                    'name' => _('Политика Cookie')
                ];
            } elseif ($_GET['page'] == 'help'){
                $this->array[] = [
                    'name' => _('Помощь')
                ];
            } elseif ($_GET['page'] == 'support_the_project'){
                $this->array[] = [
                    'name' => _('Поддержать проект')
                ];
            } elseif ($_GET['page'] == 'wishes'){
                $this->array[] = [
                    'name' => _('Пожелания')
                ];
            }
        } elseif($this->path[1] == 'advert.php') {
            $advert = $this->adverts->Get($_GET['id']);

            if ($advert->getId() > 0) {
                $this->array[] = [
                    'name' => $advert->getSection()->getName(),
                    'link' => '/?section='.$advert->getSection()->getId()
                ];

                $this->array[] = [
                    'name' => $advert->getCategory()->getName(),
                    'link' => '/?section='.$advert->getSection()->getId().'&category='.$advert->getCategory()->getId()
                ];

                $this->array[] = [
                    'name' => $advert->getSubcategory()->getName(),
                    'link' => '/?section='.$advert->getSection()->getId().'&category='.$advert->getCategory()->getId().'&subcategory='.$advert->getSubcategory()->getId()
                ];

                $this->array[] = [
                    'name' => $advert->getName()
                ];
            }
        }

        return $this->array;
    }

}