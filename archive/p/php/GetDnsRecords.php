<?php

class GetDnsRecords
{
    protected $types = [
        'A' => DNS_A,
        'NS' => DNS_NS,
        'MX' => DNS_MX,
        'SOA' => DNS_SOA
    ];

    public function getAllRecords($domain)
    {
        $records = [];
        foreach ($this->types as $key => $type) {
            $records[$key] = dns_get_record($domain,$type);
        }

        echo $records;
    }
}