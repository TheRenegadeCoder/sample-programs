/* -*- P4_16 -*- */



/*************************************************************************

    This is a P4 Even Odd code:

    We defined a new packet header "operation" as follow:

                    0                                     1
    +----------------------------------+------------------------------------+
    |             number           | v |                 flag               |
    +----------------------------------+------------------------------------+                                        
    
    number = the 7 bits of the number
    v      = bit 0 of the number will be used to define if it is even or odd
    flag   = will be 0 if even, or 1 if odd

    Let us assume that the operation header is carried over Ethernet and uses
    the Ethertype 0x123 to indicate the presence of the header.

    When a packet arrives to the switch it is validated the header operation.
    Then it is verified the last bit of the number. Is odd if its last digit 
    is 1; it is even if its last digit is 0. The result will be set in flag.




    @ecwolf

*************************************************************************/

#include <core.p4>
#include <v1model.p4>

const bit<16> TYPE_OPERATION = 0x123;

/*************************************************************************
*********************** H E A D E R S  ***********************************
*************************************************************************/

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}

header operation_t {
    bit<7>   number;
    bit<1>   validator;
    bit<8>   flag;
}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t          ethernet;
    operation_t         operation;
}

/*************************************************************************
*********************** P A R S E R  ***********************************
*************************************************************************/

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        transition parse_ethernet;
    }

    state parse_ethernet {
        packet.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            TYPE_OPERATION: parse_operation;
            default: accept;
        }
    }

    state parse_operation {
        packet.extract(hdr.operation);
        transition accept;
    }

}

/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {   
    apply {  }
}

/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {
    
    action odd(){
        standard_metadata.egress_spec = 2;
        hdr.operation.flag = 1;
    }

    action even(){
        standard_metadata.egress_spec = 2;
        hdr.operation.flag = 0;
    }

    
    table evenodd_match {
        key = {
            hdr.operation.validator: exact;
        }
        actions = {
            even;
            odd;
            NoAction;
        }
        
        default_action = even();

        const entries = {
            0x1 : odd(); // match last digit with 1
        }
    }

    apply {
        evenodd_match.apply();
    }
}

/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {}
}

/*************************************************************************
*************   C H E C K S U M    C O M P U T A T I O N   **************
*************************************************************************/

control MyComputeChecksum(inout headers  hdr, inout metadata meta) {
     apply {}
}

/*************************************************************************
***********************  D E P A R S E R  *******************************
*************************************************************************/

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.operation);
    }
}

/*************************************************************************
***********************  S W I T C H  *******************************
*************************************************************************/

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;
