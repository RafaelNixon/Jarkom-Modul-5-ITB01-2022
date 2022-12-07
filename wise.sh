echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install isc-dhcp-server -y

echo '
    INTERFACES="eth0"
' > /etc/default/isc-dhcp-server

echo '
    ddns-update-style none;
    option domain-name "example.org";
    option domain-name-servers ns1.example.org, ns2.example.org;
    default-lease-time 600;
    max-lease-time 7200;
    log-facility local7;

    #A2
    subnet 10.45.4.0 netmask 255.255.252.0 {
        range 10.45.4.2 10.45.7.254;
        option routers 10.45.4.1;
        option broadcast-address 10.45.7.255;
        option domain-name-servers 10.45.0.19;
        default-lease-time 360;
        max-lease-time 7200;
    }

    #A6
    subnet 10.45.2.0 netmask 255.255.254.0 {
        range 10.45.2.2 10.45.3.254;
        option routers 10.45.2.1;
        option broadcast-address 10.45.3.255;
        option domain-name-servers 10.45.0.19;
        default-lease-time 720;
        max-lease-time 7200;
    }

    #A7
    subnet 10.45.1.0 netmask 255.255.255.0 {
        range 10.45.1.2 10.45.1.254;
        option routers 10.45.1.1;
        option broadcast-address 10.45.1.255;
        option domain-name-servers 10.45.0.19;
        default-lease-time 720;
        max-lease-time 7200;
    }

    #A3
    subnet 10.45.0.128 netmask 255.255.255.128 {
        range 10.45.0.130 10.45.0.254;
        option routers 10.45.0.129;
        option broadcast-address 10.45.0.255;
        option domain-name-servers 10.45.0.19;
        default-lease-time 720;
        max-lease-time 7200;
    }

    #A5
    subnet 10.45.0.0 netmask 255.255.255.252 {}

    #A4
    subnet 10.45.0.4 netmask 255.255.255.252 {}

    #A8
    subnet 10.45.0.8 netmask 255.255.255.248 {}

    #A1
    subnet 10.45.0.16 netmask 255.255.255.248 {}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart

#Nomor 3
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP