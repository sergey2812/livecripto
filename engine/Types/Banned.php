<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 5:39
 */

namespace LiveinCrypto\Types;


class WalletBs
{

    /**
     * @var int
     */
    private $id = 0;

    /**
     * @var int
     */
    private $user_from;

    /**
     * @var int
     */
    private $user_to;

    /**
     * @var null|string
     */
    private $cause;

    /**
     * @var int
     */
    private $advert_id;
    /**
     * @var int
     */
    private $deal_id;
    /**
     * @var null|string
     */
    private $cause_date = '';
    /**
     * @var null|string
     */
    private $comment;
    /**
     * @var null|string
     */
    private $comment_date = '';
    /**
     * @var int
     */
    private $admin_id;



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
    public function getBannedUserFrom(): User
    {
        return $this->user_from;
    }

    /**
     * @param User $author
     */
    public function setBannedUserFrom(User $user_from): void
    {
        $this->user_from = $user_from;
    }    

    /**
     * @return User
     */
    public function getBannedUserTo(): User
    {
        return $this->user_to;
    }

    /**
     * @param User $author
     */
    public function setBannedUserTo(User $user_to): void
    {
        $this->user_to = $user_to;
    }

    /**
     * @return string
     */
    public function getCause(): string
    {
        return $this->cause;
    }

    /**
     * @param string $login
     */
    public function setCause(string $cause): void
    {
        $this->cause = $cause;
    }

    /**
     * @return Advert
     */
    public function getBannedAdvert(): Advert
    {
        return $this->advert;
    }

    /**
     * @param Advert $advert
     */
    public function setBannedAdvert(Advert $advert): void
    {
        $this->advert = $advert;
    }

    /**
     * @return Deal|null
     */
    public function getBannedDeal(): ?Deal
    {
        return $this->deal;
    }
    /**
     * @param Deal|null $deal
     */
    public function setBannedDeal(?Deal $deal): void
    {
        $this->deal = $deal;
    }        

    /**
     * @return null|string
     */
    public function getBannedCauseDate(): ?string
    {
        return $this->cause_date;
    }

    /**
     * @param null|string $banned_date
     */
    public function setBannedCauseDate(?string $cause_date): void
    {
        $this->cause_date = $cause_date;
    }

    /**
     * @return string
     */
    public function getBannedComment(): string
    {
        return $this->comment;
    }

    /**
     * @param string $login
     */
    public function setBannedComment(string $comment): void
    {
        $this->comment = $comment;
    }    

    /**
     * @return null|string
     */
    public function getBannedCommentDate(): ?string
    {
        return $this->comment_date;
    }

    /**
     * @param null|string $banned_date
     */
    public function setBannedCommentDate(?string $comment_date): void
    {
        $this->comment_date = $comment_date;
    } 

    /**
     * @return User
     */
    public function getBannedAdmin(): User
    {
        return $this->admin;
    }

    /**
     * @param User $author
     */
    public function setBannedAdmin(User $admin): void
    {
        $this->admin = $admin;
    }

}