<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.08.2018
 * Time: 12:50
 */

namespace LiveinCrypto\Helpers;


class WalletsChecker
{

    public function CheckBTC(string $wallet): bool
    {
        return preg_match('/^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$/', $wallet);
    }

    public function CheckETH(string $wallet): bool
    {
        return preg_match('/^0x[a-fA-F0-9]{40}$/', $wallet);
    }

    public function CheckLTC(string $wallet): bool
    {
        return preg_match('/^[LM3][a-km-zA-HJ-NP-Z1-9]{26,33}$/', $wallet);
    }

    public function CheckXRP(string $wallet): bool
    {
        return preg_match('/^r[rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz]{27,35}$/', $wallet);
    }

}