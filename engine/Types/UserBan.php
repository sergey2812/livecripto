<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 5:39
 */

namespace LiveinCrypto\Types;


class UserBan
{

    /**
     * @var int
     */
    private $id = 0;

    /**
     * @var string
     */
    private $user_from = '';

    /**
     * @var string
     */
    private $user_to = '';    

    /**
     * @var string
     */
    private $cause = '';

    /**
     * @var string
     */
    private $cause_date = '';

    /**
     * @var int
     */
    private $advert = 0;

    /**
     * @var int
     */
    private $deal = 0;   

    /**
     * @var string
     */
    private $comment = '';

    /**
     * @var string
     */
    private $comment_date = '';

    /**
     * @var string
     */
    private $admin = '';

    /**
     * @var int
     */
    private $ban_unban = 0;

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
     * @return int
     */
    public function getUserBanFromId(): int
    {
        return $this->user_from;
    }

    /**
     * @param int $id
     */
    public function setUserBanFromId(int $user_from): void
    {
        $this->user_from = $user_from;
    }

    /**
     * @return int
     */
    public function getUserBanToId(): int
    {
        return $this->user_to;
    }

    /**
     * @param int $id
     */
    public function setUserBanToId(int $user_to): void
    {
        $this->user_to = $user_to;
    }    

    /**
     * @return string
     */
    public function getUserBanCause(): string
    {
        return $this->cause;
    }

    /**
     * @param string $password
     */
    public function setUserBanCause(string $cause): void
    {
        $this->cause = $cause;
    }    

    /**
     * @return string
     */
    public function getUserBanCauseDate(): string
    {
        return $this->cause_date;
    }

    /**
     * @param string $register_date
     */
    public function setUserBanCauseDate(string $cause_date): void
    {
        $this->cause_date = $cause_date;
    }

    /**
     * @return int
     */
    public function getUserBanAdvertId(): int
    {
        return $this->advert;
    }

    /**
     * @param int $id
     */
    public function setUserBanAdvertId(int $advert): void
    {
        $this->advert = $advert;
    }

    /**
     * @return int
     */
    public function getUserBanDealId(): int
    {
        return $this->deal;
    }

    /**
     * @param int $id
     */
    public function setUserBanDealId(int $deal): void
    {
        $this->deal = $deal;
    }

    /**
     * @return string
     */
    public function getUserBanComment(): string
    {
        return $this->comment;
    }

    /**
     * @param string $password
     */
    public function setUserBanComment(string $comment): void
    {
        $this->comment = $comment;
    }    

    /**
     * @return string
     */
    public function getUserBanCommentDate(): string
    {
        return $this->comment_date;
    }

    /**
     * @param string $register_date
     */
    public function setUserBanCommentDate(string $comment_date): void
    {
        $this->comment_date = $comment_date;
    }

    /**
     * @return int
     */
    public function getUserBanAdminId(): int
    {
        return $this->admin;
    }

    /**
     * @param int $id
     */
    public function setUserBanAdminId(int $admin): void
    {
        $this->admin = $admin;
    }    

    /**
     * @return int
     */
    public function getUserBanStatus(): int
    {
        return $this->ban_unban;
    }

    /**
     * @param int $permissions
     */
    public function setUserBanStatus(int $ban_unban): void
    {
        $this->ban_unban = $ban_unban;
    }

}