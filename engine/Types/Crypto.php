<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 5:39
 */

namespace LiveinCrypto\Types;


class Crypto
{

    /**
     * @var int
     */
    private $id = 0;

    /**
     * @var string
     */
    private $name;    

    /**
     * @var string
     */
    private $code = '';

    /**
     * @var string
     */
    private $wallets_address = '';
 
    /**
     * @var int
     */
    private $bs_min_price;



    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @param int $id
     */
    public function setId(int $id): void
    {
        $this->id = $id;
    }

    /**
     * @return string
     */
    public function getName(): string
    {
        return $this->name;
    }

    /**
     * @param string $name
     */
    public function setName(string $name): void
    {
        $this->name = $name;
    }    

    /**
     * @return string
     */
    public function getCode(): string
    {
        return $this->code;
    }

    /**
     * @param string $code
     */
    public function setCode(string $code): void
    {
        $this->code = $code;
    }        

    /**
     * @return string
     */
    public function getWalletsAddress(): string
    {
        return $this->wallets_address;
    }

    /**
     * @param string $wallets_address
     */
    public function setWalletsAddress(string $wallets_address): void
    {
        $this->wallets_address = $wallets_address;
    }    

    /**
     * @return int
     */
    public function getBsMinPrice(): float
    {
        return $this->bs_min_price;
    }

    /**
     * @param int $wallets_min_price
     */
    public function setBsMinPrice(float $bs_min_price): void
    {
        $this->bs_min_price = $bs_min_price;
    }

}