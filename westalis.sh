route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.45.0.5

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install isc-dhcp-relay -y

echo '
    SERVERS="10.45.0.18"
    INTERFACES="eth2 eth3 eth0 eth1"
    OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo '
    net.ipv4.ip_forward=1
' > /etc/sysctl.conf

service isc-dhcp-relay restart