<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.05.2019
 * Time: 19:56
 */

namespace LiveinCrypto;


use GuzzleHttp\Client;

class Captcha extends Config
{

    /**
     * @var Client
     */
    private $guzzle;

    public function __construct()
    {
        parent::__construct();
        $this->guzzle = new Client([
            'base_uri' => 'https://www.google.com/recaptcha/api/siteverify'
        ]);
    }

    public function check(string $key): bool
    {
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        }

        $response = $this->guzzle->request('POST', '', [
            'form_params' => [
                'secret' => $this->recaptchaPrivateKey,
                'response' => $key,
                'remoteip' => $ip,
            ]
        ]);

        if ($response->getStatusCode() == 200) {
            $json = json_decode($response->getBody(), true);
            if ($json['success']) return true;
        }

        return false;
    }
}