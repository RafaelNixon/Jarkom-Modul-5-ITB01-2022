echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install bind9 -y

echo '
options {
        directory "/var/cache/bind";
        forwarders {
                192.168.122.1;
        };
        allow-query { any; };
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};

' > /etc/bind/named.conf.options

service bind9 restart

#Nomor 3
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP

#Nomor 4
#Garden
iptables -A INPUT -s 10.45.0.8/29 -m time --weekdays Sat,Sun -j REJECT
iptables -A INPUT -s 10.45.0.8/29 -m time --timestart 00:00 --timestop 06:59 --weekdays Mon,Tue,Wed,Thu,Fri -j REJECT
iptables -A INPUT -s 10.45.0.8/29 -m time --timestart 16:01 --timestop 23:59 --weekdays Mon,Tue,Wed,Thu,Fri -j REJECT