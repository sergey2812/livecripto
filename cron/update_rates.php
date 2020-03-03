<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 11.09.2018
 * Time: 15:53
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../engine/autoload.php";

//todo-hard Сделать обновление каждый ЧАС, а не ДЕНЬ

$urls = [
    'tusd' => 'https://api.coinmarketcap.com/v2/ticker/2563/',
    'waves' => 'https://api.coinmarketcap.com/v2/ticker/1274/',
    'doge' => 'https://api.coinmarketcap.com/v2/ticker/74/',
    'etc' => 'https://api.coinmarketcap.com/v2/ticker/1321/',
    'bnb' => 'https://api.coinmarketcap.com/v2/ticker/1839/',
    'dash' => 'https://api.coinmarketcap.com/v2/ticker/131/',
    'xmr' => 'https://api.coinmarketcap.com/v2/ticker/328/',
    'usdt' => 'https://api.coinmarketcap.com/v2/ticker/825/',
    'ltc' => 'https://api.coinmarketcap.com/v2/ticker/2/',
    'bch' => 'https://api.coinmarketcap.com/v2/ticker/1831/',
    'xrp' => 'https://api.coinmarketcap.com/v2/ticker/52/',
    'eth' => 'https://api.coinmarketcap.com/v2/ticker/1027/',
    'btc' => 'https://api.coinmarketcap.com/v2/ticker/1/',
];

$guzzle = new \GuzzleHttp\Client();
foreach ($urls as $url) {
    $res = $guzzle->request('GET', $url);
    if ($res->getStatusCode() == 200) {
        $result = json_decode($res->getBody(), true);
        $result = $result['data'];

        $slug = strtolower($result['symbol']);
        $rate = round($result['quotes']['USD']['price'], 2);

        $array = [
            'currency' => $slug,
            'rate' => $rate
        ];
        $exchangerates->Add($array);
    }
}