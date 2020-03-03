<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 6:05
 */

namespace LiveinCrypto\Types;


class ChatAdmin
{

    /**
     * @var int
     */
    private $id;

    /**
     * @var Message[]
     */
    private $messages;

    /**
     * @var User
     */
    private $from;

    /**
     * @var User
     */
    private $to;

    /**
     * @var bool
     */
    private $accept = false;
    /**
     * @var 0|status
     */
    private $status = 0;

    public function hasUnread(int $userId): int
    {
        $unread = 0;

        if (!empty($this->messages)){
            foreach ($this->messages as $message){
                if ($message->getRead() == 2 AND $message->getFrom() != $userId) {
                    $unread++;
                }
            }
        }

        return $unread;
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
     * @return User
     */
    public function getFrom()
    {
        return $this->from;
    }

    /**
     * @param User $from
     */
    public function setFrom($from)
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

}