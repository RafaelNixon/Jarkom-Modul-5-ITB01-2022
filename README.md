# :zap: **Jarkom-Modul-5-ITB01-2022** :zap:

| Nama                               | NRP            |
|------------------------------------|----------------|
| 	:adult: Rafael Nixon              | 05311940000025 |
| 	:adult: Fairuz Azka Maulana       | 5027201017     |
| 	:adult: Muhammad Firdho Kustiawan | 5027201005     | 
<br/>

# :large_blue_circle: **Routing** :large_blue_circle: 

# :large_blue_circle: **Topologi** :large_blue_circle: 

# :large_blue_circle: **Soal 1** :large_blue_circle: 
Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Strix menggunakan iptables, tetapi Loid tidak ingin menggunakan MASQUERADE.

### :triangular_flag_on_post: **Jawaban:**

### :rocket: **Router Strix** 
```JavaScript
IPETH0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source "$IPETH0" -s 10.45.0.0/21
```
<br>

# :large_blue_circle: **Soal 2** :large_blue_circle: 
Kalian diminta untuk melakukan drop semua TCP dan UDP dari luar Topologi kalian pada server yang merupakan DHCP Server demi menjaga keamanan.

### :triangular_flag_on_post: **Jawaban:**

### :rocket: **Router Strix** 
```JavaScript
iptables -A FORWARD -d 10.45.0.18 -i eth0 -p tcp --dport 80 -j DROP #WISE
iptables -A FORWARD -d 10.45.0.18 -i eth0 -p udp --dport 53 -j DROP 
```
### :triangular_flag_on_post: **Testing di Server Garden - Web Server**  
<img src="./img/Nomor2aTCP.png">

### :triangular_flag_on_post: **Testing di Server SSS - Web Server**  
<img src="./img/Nomor2bTCP.png">

### :triangular_flag_on_post: **Testing di Client Briar**  
<img src="./img/Nomor2cTCP.png">
<br>
<br>

# :large_blue_circle: **Soal 3** :large_blue_circle: 
Loid meminta kalian untuk membatasi DHCP dan DNS Server hanya boleh menerima maksimal 2 koneksi ICMP secara bersamaan menggunakan iptables, selebihnya didrop yang artinya hanya menerima koneksi 2 host selebihnya maka didrop

### :triangular_flag_on_post: **Jawaban:**
pada WISE masukan iptables
```
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP
```
kemudian melakukan testibg dengan melakukan ping pada Blackbell(Host 1), Briar(Host 2), dan Desmond(Host 3)
Blackbell(Host 1)
<img src="Nomor3a.png">
Briar(Host 2)
<img src="Nomor3b.png">
Desmond(Host 3)
<img src="Nomor3c.png">
kemudian masukan ip tables pada Eden 
```
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP
```
kemudian melakukan testibg dengan melakukan ping pada Blackbell(Host 1), Briar(Host 2), Desmond(Host 3)
Blackbell(Host 1)
<img src="Nomor3d.png">
Briar(Host 2)
<img src="Nomor3e.png">
Desmond(Host 3)
<img src="Nomor3f.png">

# :large_blue_circle: **Soal 4** :large_blue_circle: 
Akses menuju Web Server hanya diperbolehkan disaat jam kerja yaitu Senin sampai Jumat pada pukul 07.00 - 16.00.

### :triangular_flag_on_post: **Jawaban:**
pada soal ini kami melakukan konfigurasi pada Garden dan SSS untuk mengatur waktu Reject, dengan command

```
#Garden
iptables -A INPUT -s 10.45.0.8/29 -m time --weekdays Sat,Sun -j REJECT
iptables -A INPUT -s 10.45.0.8/29 -m time --timestart 00:00 --timestop 06:59 --weekdays Mon,Tue,Wed,Thu,Fri -j REJECT
iptables -A INPUT -s 10.45.0.8/29 -m time --timestart 16:01 --timestop 23:59 --weekdays Mon,Tue,Wed,Thu,Fri -j REJECT
```
Kemudian lakukan testing pada Briar(Host 2)
manggunakan ping 10.45.0.8
<img src="Nomor4a.png">
dan menggunakan ping 10.45.0.8
<img src="Nomor4_Wes Dec 7 09-35-00 UTC 2022.png">

# :large_blue_circle: **Soal 5** :large_blue_circle: 
Karena kita memiliki 2 Web Server, Loid ingin Ostania diatur sehingga setiap request dari client yang mengakses Garden dengan port 80 akan didistribusikan secara bergantian pada SSS dan Garden secara berurutan dan request dari client yang mengakses SSS dengan port 443 akan didistribusikan secara bergantian pada Garden dan SSS secara berurutan.

### :triangular_flag_on_post: **Jawaban:**

# :large_blue_circle: **Soal 6** :large_blue_circle: 
Karena Loid ingin tau paket apa saja yang di-drop, maka di setiap node server dan router ditambahkan logging paket yang di-drop dengan standard syslog level.


### :triangular_flag_on_post: **Jawaban:**
