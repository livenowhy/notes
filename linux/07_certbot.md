## 使⽤ Certbot ⾃动申请并续订阿⾥云 DNS 免费泛域名证书

### Certbot 和 certbot-dns-aliyun

    $ pip install certbot certbot-nginx certbot-dns-aliyun

### 申请并配置阿⾥云 DNS 访问密钥

    创建阿⾥云⼦账号并授予权限，然后为⼦账号创建 AccessKey 并记录(AliyunDNSFullAccess)

    创建 certbot-dns-aliyun 配置⽂件:
    $ cat > /root/certbot/credentials.ini <<EOF
    certbot_dns_aliyun:dns_aliyun_access_key = LTAI5tLJREf4XxVaP3QpT4rc
    certbot_dns_aliyun:dns_aliyun_access_key_secret = SbLjWeGhC1bnNR2jyxLd8D7ihSYz7E
    EOF
    
    修改⽂件权限
    $ chmod 600 /root/certbot/credentials.ini

    申请证书
    /opt/venv/bin/certbot certonly \
    -a certbot-dns-aliyun:dns-aliyun \
    --certbot-dns-aliyun:dns-aliyun-credentials /root/certbot/credentials.ini \
    -d livenowhy.com \
    -d "*.livenowhy.com"

## 问题解决

    遇到下列问题忽略，输入你的邮箱即可
    Enter email address (used for urgent renewal and security notices)
    (Enter 'c' to cancel)
    
## 配置⾃动续订
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && /opt/venv/bin/certbot renew -q" | sudo tee -a /etc/crontab > /dev/null