route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.45.0.1

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install isc-dhcp-relay -y

echo '
    SERVERS="10.45.0.18"
    INTERFACES="eth2 eth3 eth1 eth0"
    OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo '
    net.ipv4.ip_forward=1
' > /etc/sysctl.conf

service isc-dhcp-relay restart

#Nomor 5
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.45.0.11 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.45.0.10:80 #SSS
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.45.0.11 -j DNAT --to-destination 10.45.0.11:80 #Garden

iptables -A PREROUTING -t nat -p udp --dport 443 -d 10.45.0.10 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.45.0.11:80 #Garden
iptables -A PREROUTING -t nat -p udp --dport 443 -d 10.45.0.10 -j DNAT --to-destination 10.45.0.10:80 #SSS