<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 25.09.2018
 * Time: 14:24
 */

namespace LiveinCrypto\Types;


/**
 * Class Deal
 * @package LiveinCrypto\Types
 */
class Deal
{
    /**
     * @var int
     */
    private $id;
    /**
     * @var Advert
     */
    private $advert;
    /**
     * @var User
     */
    private $seller;
    /**
     * @var User
     */
    private $buyer;
    /**
     * @var int
     */
    private $admin_id;    
    /**
     * @var string
     */
    private $buyer_wallet;
    /**
     * @var string
     */
    private $seller_wallet;
    /**
     * @var string
     */
    private $admin_wallet;        
    /**
     * @var string
     */
    private $buyer_type;
    /**
     * @var float
     */
    private $price;
    /**
     * @var float
     */
    private $summ_to_seller;
    /**
     * @var float
     */
    private $royalty;        
    /**
     * @var int
     */
    private $status;
    /**
     * @var int
     */
    private $secure_deal;
    /**
     * @var string
     */
    private $date;
    /**
     * @var int
     */
    private $incident;
    /**
     * @var int
     * 0 - Нет инцидента
     * 1 - Инцидент открыл покупатель
     * 2 - Инцидент открыл продавец
     */
    private $incident_opener;
    /**
     * @var null|string
     */
    private $pay_date;
    /**
     * @var null|string
     */
    private $pay_confirmation_date;
    /**
     * @var null|string
     */
    private $send_product_date;
    /**
     * @var null|string
     */
    private $resive_confirmation_date;  
                  /**
     * @var null|string
     */
    private $send_pay_to_seller_date;  
    /**
     * @var int
     */
    private $rating = 0;
    /**
     * @var int|bool
     */
    private $like = -1;
    /**
     * @var int
     */
    private $chat = 0;
    /**
     * @var null|array
     */
    private $rating_from = null;
    /**
     * @var null|array
     */
    private $rating_to = null;
    /**
     * @var null|array
     */
    private $likes_from = null;
    /**
     * @var null|array
     */
    private $likes_to = null;

    /**
     * @return array|null
     */
    public function getRatingFrom(): ?array
    {
        return $this->rating_from;
    }
   

    /**
     * @param array|null $rating_from
     */
    public function setRatingFrom(?array $rating_from): void
    {
        $this->rating_from = $rating_from;
    }

    /**
     * @return array|null
     */
    public function getRatingTo(): ?array
    {
        return $this->rating_to;
    }

    /**
     * @param array|null $rating_to
     */
    public function setRatingTo(?array $rating_to): void
    {
        $this->rating_to = $rating_to;
    }

    /**
     * @return array|null
     */
    public function getLikesFrom(): ?array
    {
        return $this->likes_from;
    }

    /**
     * @param array|null $likes_from
     */
    public function setLikesFrom(?array $likes_from): void
    {
        $this->likes_from = $likes_from;
    }

    /**
     * @return array|null
     */
    public function getLikesTo(): ?array
    {
        return $this->likes_to;
    }

    /**
     * @param array|null $likes_to
     */
    public function setLikesTo(?array $likes_to): void
    {
        $this->likes_to = $likes_to;
    }

    /**
     * @return int
     */
    public function getChat(): int
    {
        return $this->chat;
    }

    /**
     * @param int $chat
     */
    public function setChat(int $chat): void
    {
        $this->chat = $chat;
    }

    /**
     * @return bool|int
     */
    public function getLike()
    {
        return $this->like;
    }

    /**
     * @param bool|int $like
     */
    public function setLike($like): void
    {
        $this->like = $like;
    }

    /**
     * @return int
     */
    public function getRating(): int
    {
        return $this->rating;
    }

    /**
     * @param int $rating
     */
    public function setRating(int $rating): void
    {
        $this->rating = $rating;
    }

    /**
     * @return null|string
     */
    public function getPayDate(): ?string
    {
        return $this->pay_date;
    }

    /**
     * @param null|string $pay_date
     */
    public function setPayDate(?string $pay_date): void
    {
        $this->pay_date = $pay_date;
    }

    /**
     * @return null|string
     */
    public function getPayConfirmationDate(): ?string
    {
        return $this->pay_confirmation_date;
    }

    /**
     * @param null|string $pay_confirmation_date
     */
    public function setPayConfirmationDate(?string $pay_confirmation_date): void
    {
        $this->pay_confirmation_date = $pay_confirmation_date;
    }

    /**
     * @return null|string
     */
    public function getSendProductDate(): ?string
    {
        return $this->send_product_date;
    }

    /**
     * @param null|string $send_product_date
     */
    public function setSendProductDate(?string $send_product_date): void
    {
        $this->send_product_date = $send_product_date;
    }

    /**
     * @return null|string
     */
    public function getResiveConfirmationDate(): ?string
    {
        return $this->resive_confirmation_date;
    }

    /**
     * @param null|string $resive_confirmation_date
     */
    public function setResiveConfirmationDate(?string $resive_confirmation_date): void
    {
        $this->resive_confirmation_date = $resive_confirmation_date;
    }

    /**
     * @return null|string
     */
    public function getSendPayToSellerDate(): ?string
    {
        return $this->send_pay_to_seller_date;
    }

    /**
     * @param null|string $send_pay_to_seller_date
     */
    public function setSendPayToSellerDate(?string $send_pay_to_seller_date): void
    {
        $this->send_pay_to_seller_date = $send_pay_to_seller_date;
    }        

    /**
     * @return string
     */
    public function getBuyerType(): string
    {
        return $this->buyer_type;
    }

    /**
     * @param string $buyer_type
     */
    public function setBuyerType(string $buyer_type): void
    {
        $this->buyer_type = $buyer_type;
    }

    /**
     * @return float
     */
    public function getPrice(): float
    {
        return $this->price;
    }

    /**
     * @param float $price
     */
    public function setPrice(float $price): void
    {
        $this->price = $price;
    }

    /**
     * @return float
     */
    public function getSummToSeller(): float
    {
        return $this->summ_to_seller;
    }

    /**
     * @param float $summ_to_seller
     */
    public function setSummToSeller(float $summ_to_seller): void
    {
        $this->summ_to_seller = $summ_to_seller;
    }

    /**
     * @return float
     */
    public function getRoyalty(): float
    {
        return $this->royalty;
    }

    /**
     * @param float $royalty
     */
    public function setRoyalty(float $royalty): void
    {
        $this->royalty = $royalty;
    }        

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
        return $this->advert;
    }

    /**
     * @param Advert $advert
     */
    public function setAdvert(Advert $advert): void
    {
        $this->advert = $advert;
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
     * @return int
     */
    public function getAdmin()
    {
        return $this->admin_id;
    }

    /**
     * @param User $admin_id
     */
    public function setAdmin($admin_id)
    {
        $this->admin_id = $admin_id;
    }    

    /**
     * @return string
     */
    public function getBuyerWallet(): string
    {
        return $this->buyer_wallet;
    }

    /**
     * @param string $buyer_wallet
     */
    public function setBuyerWallet(string $buyer_wallet): void
    {
        $this->buyer_wallet = $buyer_wallet;
    }

    /**
     * @return string
     */
    public function getSellerWallet(): string
    {
        return $this->seller_wallet;
    }

    /**
     * @param string $seller_wallet
     */
    public function setSellerWallet(string $seller_wallet): void
    {
        $this->seller_wallet = $seller_wallet;
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
     * @return int
     */
    public function getSecureDeal(): int
    {
        return $this->secure_deal;
    }

    /**
     * @param int $secure_deal
     */
    public function setSecureDeal(int $secure_deal): void
    {
        $this->secure_deal = $secure_deal;
    }

    /**
     * @return string
     */
    public function getDate(): string
    {
        return $this->date;
    }

    /**
     * @param string $date
     */
    public function setDate(string $date): void
    {
        $this->date = $date;
    }

    /**
     * @return int
     */
    public function getIncident(): int
    {
        return $this->incident;
    }

    /**
     * @param int $incident
     */
    public function setIncident(int $incident): void
    {
        $this->incident = $incident;
    }

    /**
     * @return int
     */
    public function getIncidentOpener(): int
    {
        return $this->incident_opener;
    }

    /**
     * @param int $incident_opener
     */
    public function setIncidentOpener(int $incident_opener): void
    {
        $this->incident_opener = $incident_opener;
    }
}