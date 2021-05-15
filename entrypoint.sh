#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

install_cert() {
mkdir -p /etc/cert/$DOMAIN
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh  --issue --dns dns_cf -d $DOMAIN -d *.$DOMAIN --key-file /etc/cert/$DOMAIN/private.key --fullchain-file /etc/cert/$DOMAIN/fullchain.crt
~/.acme.sh/acme.sh --installcert -d $DOMAIN --key-file /var/frp/conf/server.key --cert-file /var/frp/conf/server.crt --ca-file /var/frp/conf/ca.crt
~/.acme.sh/acme.sh --upgrade --auto-upgrade
}

# 查看证书，没有就自动创建
if [ ! -f "/var/frp/conf/server.crt" ]; then
  install_cert
fi

/var/frp/frps -c /var/frp/conf/frps.ini &
/var/frp/frpc -c /var/frp/conf/frpc.ini
