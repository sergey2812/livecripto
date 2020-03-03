<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 6:05
 */

namespace LiveinCrypto\Types;


class Chat
{

    /**
     * @var int
     */
    private $id;

    /**
     * @var string
     */
    private $subject;

    /**
     * @var Message[]
     */
    private $messages;

    /**
     * @var User
     */
    private $from;
    /**
     * @var Advert
     */
    private $advert;

    /**
     * @var User
     */
    private $to;

    /**
     * @var bool
     */
    private $accept = false;
    /**
     * @var null|Deal
     */
    private $deal = null;

    public function hasUnread(int $userId): int
    {
        $unread = 0;

        if (!empty($this->messages)){
            foreach ($this->messages as $message){
                if ($message->getRead() == 0 AND $message->getFrom() != $userId) {
                    $unread++;
                }
            }
        }

        return $unread;
    }

    /**
     * @return Deal|null
     */
    public function getDeal(): ?Deal
    {
        return $this->deal;
    }
   

    /**
     * @param Deal|null $deal
     */
    public function setDeal(?Deal $deal): void
    {
        $this->deal = $deal;
    }

    /**
     * @return bool
     */
    public function isAccept(): bool
    {
        return $this->accept;
    }

    /**
     * @param bool $accept
     */
    public function setAccept(bool $accept): void
    {
        $this->accept = $accept;
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
    public function getFrom(): User
    {
        return $this->from;
    }

    /**
     * @param User $from
     */
    public function setFrom(User $from): void
    {
        $this->from = $from;
    }

    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param int $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    /**
     * @return string
     */
    public function getSubject()
    {
        return $this->subject;
    }

    /**
     * @param string $subject
     */
    public function setSubject($subject)
    {
        $this->subject = $subject;
    }

    /**
     * @return Message[]
     */
    public function getMessages(): array
    {
        return $this->messages;
    }

    /**
     * @param Message[] $messages
     */
    public function setMessages(array $messages): void
    {
        $this->messages = $messages;
    }

    /**
     * @return User
     */
    public function getTo()
    {
        return $this->to;
    }

    /**
     * @param User $to
     */
    public function setTo($to)
    {
        $this->to = $to;
    }

}