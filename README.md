Docker for frp

使用docker配置frp服务，用于没有公网IP内网透传

     docker run -itd --name frps \
        -p 10000-10020:10000-10020 \
        -p 80:80/tcp -p 443:443/tcp \
        -p 80:80/udp -p 443:443/udp \
        -e DASHBOARD_PWD=password \
        -e TOKEN=12345678 \
        -e SUBDOMAIN_HOST=frps.com \
         lihaixin/frp
         
 或者直接使用宿主机网络
 
     docker run -itd --name frps \
        --net=host \
        -e DASHBOARD_PWD=password \
        -e TOKEN=12345678 \
        -e SUBDOMAIN_HOST=frps.com \
        -e FRP_PORT=443 \
        -e V_HTTP_PORT=80 \
        -e V_HTTPS_PORT=443 \
         lihaixin/frp

自签证书创建方法：

     openssl genrsa 1024 > wrt.key
     openssl req -new -key wrt.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=localhost" > wrt.csr
     openssl req -x509 -days 3650 -key wrt.key -in wrt.csr > wrt.crt
     
     

