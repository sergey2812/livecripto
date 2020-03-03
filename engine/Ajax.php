<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 9:23
 */

namespace LiveinCrypto;


class Ajax extends Config
{

    /**
     * @var array
     */
    private $result = [
        'ok' => false,
        'result' => [],
        'reload' => true
    ];

    /**
     * Ajax constructor.
     */
    public function __construct()
    {
        parent::__construct();
        header('Content-Type: application/json');
    }

    public function GetError(): string
    {
        if (!empty($this->result['error'])){
            return $this->result['error'];
        } else{
            return false;
        }
    }

    public function Success(): void
    {
        $this->result['ok'] = true;
    }

    public function Fail(): void
    {
        $this->result['ok'] = false;
    }

    public function Error(string $text): void
    {
        $this->result['error'] = $text;
    }

    public function ReloadPage(bool $reload): void
    {
        unset($this->result['redirect']);
        $this->result['reload'] = $reload;
    }

    public function RedirectUrl(string $url): void
    {
        $this->result['redirect'] = $url;
    }

    public function AddData(array $array): void
    {
        $this->result['result'] = array_merge($this->result['result'], $array);
    }

    public function Echo(): void
    {
        if (!$this->result['ok']){
            unset($this->result['reload']);
        }
        echo json_encode($this->result);
        die();
    }

}