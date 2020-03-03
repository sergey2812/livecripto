<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 5:39
 */

namespace LiveinCrypto\Types;


class ClientTop4
{

    /**
     * @var int
     */
    private $id = 0;

    /**
     * @var int
     */
    private $user_id = 0;

    /**
     * @var int
     */
    private $advert_id = 0;    

    /**
     * @var date
     */
    private $pay_date;

    /**
     * @var date
     */
    private $pay_sum;

    /**
     * @var int
     */
    private $crypta_code;

    /**
     * @var int
     */
    private $user_wallet;    

    /**
     * @var int
     */
    private $admin_wallet;     

    /**
     * @var int
     */
    private $status = 0;

    /**
     * @var date
     */
    private $start_date;   

    /**
     * @var date
     */
    private $end_date;

    /**
     * @var int
     */
    private $days = 0;

    /**
     * @var int
     */
    private $top_position = 0;

    /**
     * @var int
     */
    private $country = 0;

    /**
     * @var int
     */
    private $city = 0;

    /**
     * @var int
     */
    private $section = 0;

                /**
     * @var int
     */
    private $category = 0;

    /**
     * @var int
     */
    private $subcategory = 0;    

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
     * @return Advert
     */
    public function getAdvert(): Advert
    {
        return $this->advert_id;
    }

    /**
     * @param Advert $advert_id
     */
    public function setAdvert(Advert $advert_id): void
    {
        $this->advert_id = $advert_id;
    }      

    /**
     * @return User
     */
    public function getUser()
    {
        return $this->user_id;
    }

    /**
     * @param User $user_id
     */
    public function setUser($user_id)
    {
        $this->user_id = $user_id;
    }      

    /**
     * @return string
     */
    public function getPayDate()
    {
        return $this->pay_date;
    }

    /**
     * @param string $register_date
     */
    public function setPayDate($pay_date)
    {
        $this->pay_date = $pay_date;
    }

    /**
     * @return int
     */
    public function getPaySum()
    {
        return $this->pay_sum;
    }

    /**
     * @param int $pay_sum
     */
    public function setPaySum($pay_sum)
    {
        $this->pay_sum = $pay_sum;
    }    

    /**
     * @return int
     */
    public function getCryptaCode()
    {
        return $this->crypta_code;
    }

    /**
     * @param int $crypta_code
     */
    public function setCryptaCode($crypta_code)
    {
        $this->crypta_code = $crypta_code;
    }

    /**
     * @return string
     */
    public function getUserWallet(): string
    {
        return $this->user_wallet;
    }

    /**
     * @param string $user_wallet
     */
    public function setUserWallet(string $user_wallet): void
    {
        $this->user_wallet = $user_wallet;
    }

    /**
     * @return string
     */
    public function getAdminWallet(): string
    {
        return $this->admin_wallet;
    }

    /**
     * @param string $admin_wallet
     */
    public function setAdminWallet(string $admin_wallet): void
    {
        $this->admin_wallet = $admin_wallet;
    }    

    /**
     * @return int
     */
    public function getStatus(): int
    {
        return $this->status;
    }

    /**
     * @param int $status
     */
    public function setStatus(int $status): void
    {
        $this->status = $status;
    }

    /**
     * @return string
     */
    public function getStartDate(): string
    {
        return $this->start_date;
    }

    /**
     * @param string $start_date
     */
    public function setStartDate(string $start_date): void
    {
        $this->start_date = $start_date;
    }

    /**
     * @return string
     */
    public function getEndDate(): string
    {
        return $this->end_date;
    }

    /**
     * @param string $end_date
     */
    public function setEndDate(string $end_date): void
    {
        $this->end_date = $end_date;
    }    

    /**
     * @return int
     */
    public function getDays(): int
    {
        return $this->days;
    }

    /**
     * @param int $days
     */
    public function setDays(int $days): void
    {
        $this->days = $days;
    }

    /**
     * @return int
     */
    public function getTopPosition(): int
    {
        return $this->top_position;
    }

    /**
     * @param int $top_position
     */
    public function setTopPosition(int $top_position): void
    {
        $this->top_position = $top_position;
    }    

    /**
     * @return int
     */
    public function getCountry()
    {
        return $this->country;
    }

    /**
     * @param int $country
     */
    public function setCountry($country)
    {
        $this->country = $country;
    }

    public function getCity()
    {
        return $this->city;
    }

    /**
     * @param City $city
     */
    public function setCity($city)
    {
        $this->city = $city;
    }

    /**
     * @return Section
     */
    public function getSection()
    {
        return $this->section;
    }

    /**
     * @param Section $section
     */
    public function setSection($section)
    {
        $this->section = $section;
    }

    /**
     * @return Category
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * @param Category $category
     */
    public function setCategory($category)
    {
        $this->category = $category;
    }

    /**
     * @return Subcategory
     */
    public function getSubcategory()
    {
        return $this->subcategory;
    }

    /**
     * @param Subcategory $subcategory
     */
    public function setSubcategory($subcategory)
    {
        $this->subcategory = $subcategory;
    }
 

}