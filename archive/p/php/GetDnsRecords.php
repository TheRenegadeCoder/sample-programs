<?php

class GetDnsRecords
{
    protected $domain = 'google.com';

    protected $types = [
        'A' => DNS_A,
        'NS' => DNS_NS,
        'MX' => DNS_MX,
        'SOA' => DNS_SOA
    ];

    public function getAllRecords()
    {
        $records = [];
        foreach ($this->types as $key => $type) {
            $records[$key] = dns_get_record($this->domain,$type);
        }

        echo $records;
    }
}