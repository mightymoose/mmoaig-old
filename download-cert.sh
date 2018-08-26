docker run -it --rm \
    -v "/home/ryan/Documents/mmoaig/letsencrypt_certs:/etc/letsencrypt" \
        certbot/certbot \
        certonly \
	--manual --preferred-challenges dns \
        -d mmoaig.com \
        -d www.mmoaig.com
