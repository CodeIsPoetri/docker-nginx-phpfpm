FROM ubuntu

MAINTAINER Pablo Dorado <pablo@poetri.co>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        curl \
        php-mysql \
        php-mbstring \
        php-simplexml \
        php-dom \
        ca-certificates \
        nginx \
        php-fpm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://getcomposer.org/installer | php
RUN phpenmod pdo_mysql mbstring
RUN mv composer.phar /usr/local/bin/composer

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    ln -sf /dev/stderr /var/log/php-fpm.log

RUN mkdir /run/php

RUN rm -rf /var/www/ && \
    mkdir -p /var/www/ && \
    echo "<?php echo \"OK\";" > /var/www/index.php

COPY default /etc/nginx/sites-available/
COPY fastcgi-php.conf /etc/nginx/snippets/

EXPOSE 5000

COPY run.sh /

CMD ["/run.sh"]
