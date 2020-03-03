<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 5:39
 */

namespace LiveinCrypto\Types;


class User
{

    /**
     * @var int
     */
    private $id = 0;

    /**
     * @var string
     */
    private $login;

    /**
     * @var null|string
     */
    private $email;

    /**
     * @var null|string
     */
    private $phone;

    /**
     * @var null|string
     */
    private $avatar = '/avatars/12.png';
    /**
     * @var null|string
     */
    private $color;
    /**
     * @var null|array
     */
    private $wallets;

    /**
     * @var int
     */
    private $permissions;

    /**
     * @var string
     */
    private $password;

    /**
     * @var null|string
     */
    private $auth_key;

    /**
     * @var string
     */
    private $register_date;

    /**
     * @var null|string
     */
    private $last_login;

    /**
     * @var null|array
     */
    private $favorites;

    /**
     * @var float
     */
    private $rating = 1;

    /**
     * @var int
     */
    private $likes = 0;

    /**
     * @var int
     */
    private $dislikes = 0;
    /**
     * @var array
     */
    private $stats = [];
    /**
     * @var int
     */
    private $banned = 0;
    /**
     * @var null|string
     */
    private $banned_date = '';

    /**
     * @var int
     */
    private $banned_cause = 0;    
    /**
     * @var array
     */
    private $last_comments = [];
    /**
     * @var null|string
     */
    private $social_key = '';
    /**
     * @var int
     */
    private $chat = 0;

    /**
     * @return bool
     * Возвращает true, если пользователь имеет актинвую блокировку
     */
    public function hasBanned(): bool
    {
        if ($this->getBanned() > 0) {
            return true;
        } else{
            return false;
        }
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
     * @return string|null
     */
    public function getColor(): ?string
    {
        return $this->color;
    }

    /**
     * @param string|null $color
     */
    public function setColor(?string $color): void
    {
        $this->color = $color;
    }

    /**
     * @return null|string
     */
    public function getSocialKey(): ?string
    {
        return $this->social_key;
    }

    /**
     * @param null|string $social_key
     */
    public function setSocialKey(?string $social_key): void
    {
        $this->social_key = $social_key;
    }

    /**
     * @return array
     */
    public function getLastComments(): array
    {
        return $this->last_comments;
    }

    /**
     * @param array $last_comments
     */
    public function setLastComments(array $last_comments): void
    {
        $this->last_comments = $last_comments;
    }

    /**
     * @return int
     */
    public function getBanned(): int
    {
        return $this->banned;
    }

    /**
     * @param int $banned
     */
    public function setBanned(int $banned): void
    {
        $this->banned = $banned;
    }

    /**
     * @return null|string
     */
    public function getBannedDate(): ?string
    {
        return $this->banned_date;
    }

    /**
     * @param null|string $banned_date
     */
    public function setBannedDate(?string $banned_date): void
    {
        $this->banned_date = $banned_date;
    }

    /**
     * @return int
     */
    public function getBannedCause(): int
    {
        return $this->banned_cause;
    }

    /**
     * @param int $banned
     */
    public function setBannedCause(int $banned_cause): void
    {
        $this->banned_cause = $banned_cause;
    }

    /**
     * @return array
     */
    public function getStats(): array
    {
        return $this->stats;
    }

    /**
     * @param array $stats
     */
    public function setStats(array $stats): void
    {
        $this->stats = $stats;
    }

    /**
     * @return int
     */
    public function getLikes(): int
    {
        return $this->likes;
    }

    /**
     * @param int $likes
     */
    public function setLikes(int $likes): void
    {
        $this->likes = $likes;
    }

    /**
     * @return int
     */
    public function getDislikes(): int
    {
        return $this->dislikes;
    }

    /**
     * @param int $dislikes
     */
    public function setDislikes(int $dislikes): void
    {
        $this->dislikes = $dislikes;
    }

    /**
     * @return float
     */
    public function getRating(): float
    {
        return $this->rating;
    }

    /**
     * @param float $rating
     */
    public function setRating(float $rating): void
    {
        $this->rating = $rating;
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
     * @return string
     */
    public function getLogin(): string
    {
        return $this->login;
    }

    /**
     * @param string $login
     */
    public function setLogin(string $login): void
    {
        $this->login = $login;
    }

    /**
     * @return null|string
     */
    public function getEmail(): ?string
    {
        return $this->email;
    }

    /**
     * @param null|string $email
     */
    public function setEmail(?string $email): void
    {
        $this->email = $email;
    }

    /**
     * @return null|string
     */
    public function getPhone(): ?string
    {
        return $this->phone;
    }

    /**
     * @param null|string $phone
     */
    public function setPhone(?string $phone): void
    {
        $this->phone = $phone;
    }

    /**
     * @return null|string
     */
    public function getAvatar(): ?string
    {
        return $this->avatar;
    }

    /**
     * @param null|string $avatar
     */
    public function setAvatar(?string $avatar): void
    {
        $this->avatar = $avatar;
    }

    /**
     * @return array|null
     */
    public function getWallets(): ?array
    {
        return $this->wallets;
    }

    /**
     * @param array|null $wallets
     */
    public function setWallets(?array $wallets): void
    {
        $this->wallets = $wallets;
    }

    /**
     * @return int
     */
    public function getPermissions(): int
    {
        return $this->permissions;
    }

    /**
     * @param int $permissions
     */
    public function setPermissions(int $permissions): void
    {
        $this->permissions = $permissions;
    }

    /**
     * @return string
     */
    public function getPassword(): string
    {
        return $this->password;
    }

    /**
     * @param string $password
     */
    public function setPassword(string $password): void
    {
        $this->password = $password;
    }

    /**
     * @return null|string
     */
    public function getAuthKey(): ?string
    {
        return $this->auth_key;
    }

    /**
     * @param null|string $auth_key
     */
    public function setAuthKey(?string $auth_key): void
    {
        $this->auth_key = $auth_key;
    }

    /**
     * @return string
     */
    public function getRegisterDate(): string
    {
        return $this->register_date;
    }

    /**
     * @param string $register_date
     */
    public function setRegisterDate(string $register_date): void
    {
        $this->register_date = $register_date;
    }

    /**
     * @return null|string
     */
    public function getLastLogin(): ?string
    {
        return $this->last_login;
    }

    /**
     * @param null|string $last_login
     */
    public function setLastLogin(?string $last_login): void
    {
        $this->last_login = $last_login;
    }

    /**
     * @return array|null
     */
    public function getFavorites(): ?array
    {
        return $this->favorites;
    }

    /**
     * @param array|null $favorites
     */
    public function setFavorites(?array $favorites): void
    {
        $this->favorites = $favorites;
    }

}