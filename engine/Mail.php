<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.07.2019
 * Time: 9:11
 */

namespace LiveinCrypto;


class Mail extends Config
{
    private $smarty;

    /**
     * Mail constructor.
     * @param $smarty
     */
    public function __construct($smarty)
    {
        parent::__construct();
        $this->smarty = $smarty;
    } 

    public function sendMail($to, $subject, $template, $data = []): bool
    {
        if (!empty($data)) {
            foreach ($data as $key => $value) {
                $this->smarty->assign($key, $value);
            }
        }

        $headers = 'MIME-Version: 1.0' . "\r\n";
        $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";

        $message = $this->smarty->fetch('emails/'.$template);

        return mail($to, $subject, $message, $headers);
    }

}