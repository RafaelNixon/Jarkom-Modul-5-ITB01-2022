apt-get update

#Nomor 1
#kalo g bisa pke strix eth0
IPETH0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source "$IPETH0" -s 10.45.0.0/21

route add -net 10.45.4.0 netmask 255.255.252.0 gw 10.45.0.6 #A2_Desmond
route add -net 10.45.0.128 netmask 255.255.252.128 gw 10.45.0.6 #A3_Forger
route add -net 10.45.0.16 netmask 255.255.255.248 gw 10.45.0.6 #A1_WISEEden

route add -net 10.45.2.0 netmask 255.255.254.0 gw 10.45.0.2 #A6_Blackbell
route add -net 10.45.1.0 netmask 255.255.255.0 gw 10.45.0.2 #A7_Briar
route add -net 10.45.0.8 netmask 255.255.255.248 gw 10.45.0.2 #A8_GardenSSS

apt-get install isc-dhcp-relay -y

echo '
    SERVERS="10.45.0.18"
    INTERFACES="eth2 eth1"
    OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo '
    net.ipv4.ip_forward=1
' > /etc/sysctl.conf

service isc-dhcp-relay restart

#Nomor 2
iptables -A FORWARD -d 10.45.0.18 -i eth0 -p tcp --dport 80 -j DROP #WISE
iptables -A FORWARD -d 10.45.0.18 -i eth0 -p udp --dport 53 -j DROP 