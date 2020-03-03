<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.08.2018
 * Time: 4:33
 */

namespace LiveinCrypto\Types;


class SecureDeal
{

    /**
     * @var int
     */
    private $id;
    /**
     * @var User
     */
    private $buyer;
    /**
     * @var User
     */
    private $seller;
    /**
     * @var Advert
     */
    private $advert;

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
     * @return User
     */
    public function getBuyer(): User
    {
        return $this->buyer;
    }

    /**
     * @param User $buyer
     */
    public function setBuyer(User $buyer): void
    {
        $this->buyer = $buyer;
    }

    /**
     * @return User
     */
    public function getSeller(): User
    {
        return $this->seller;
    }

    /**
     * @param User $seller
     */
    public function setSeller(User $seller): void
    {
        $this->seller = $seller;
    }

    /**
     * @return Advert
     */
    public function getAdvert(): Advert
    {
        return $this->advert;
    }

    /**
     * @param Advert $advert
     */
    public function setAdvert(Advert $advert): void
    {
        $this->advert = $advert;
    }

    /*todo-hard Доработать тип безопасной сделки*/

}