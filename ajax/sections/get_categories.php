<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 19:07
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if ($_POST['id']) {

    $sections = new \LiveinCrypto\Sections();
    $result = $sections->GetSectionCategories($_POST['id']);

    if (!empty($result)) {
        $data = [];
        foreach ($result as $cat){
            $data[] = [
                'id' => $cat->getId(),
                'name' => _($cat->getName())
            ];
        }
        $ajax->AddData($data);
        $ajax->Success();
    } else{
        $ajax->Error(_('В этом разделе нет категорий'));
    }

} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();