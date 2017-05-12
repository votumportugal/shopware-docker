FROM phpdockerio/php7-cli:latest

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
     apache2 \
	 wget \
	 unzip \
	 mysql-client \
     nano \
     libapache2-mod-php7.0 \
     nodejs \
     netcat-openbsd \
     php7.0-memcached \
     php7.0-mysql \
     php7.0-redis \
     php7.0-bz2 \
     php7.0-mbstring \
     php7.0-gd \
     php7.0-intl \
     php7.0-xdebug \
     php7.0-soap \
     git-core \
     vim \
     mc \
     patch \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install IonCube Loader
RUN	wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O /tmp/ioncube_loaders_lin_x86-64.tar.gz
RUN	tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ && \
#	php_ext_dir="$(php -i | grep extension_dir | head -n1 | awk '{print $3}')" && \
	rm /tmp/ioncube_loaders_lin_x86-64.tar.gz && \
	mkdir -p /usr/local/ioncube && \
	cp /tmp/ioncube/ioncube_loader_lin_7.0.so /usr/local/ioncube/ && \
	cp /tmp/ioncube/ioncube_loader_lin_7.0_ts.so /usr/local/ioncube/ && \
	echo "zend_extension = /usr/local/ioncube/ioncube_loader_lin_7.0.so" > /etc/php/7.0/apache2/conf.d/00-ioncube-loader.ini && \
	echo "zend_extension_ts = /usr/local/ioncube/ioncube_loader_lin_7.0_ts.so" >> /etc/php/7.0/apache2/conf.d/00-ioncube-loader.ini && \
	echo "zend_extension = /usr/local/ioncube/ioncube_loader_lin_7.0.so" > /etc/php/7.0/cli/conf.d/00-ioncube-loader.ini && \
	echo "zend_extension_ts = /usr/local/ioncube/ioncube_loader_lin_7.0_ts.so" >> /etc/php/7.0/cli/conf.d/00-ioncube-loader.ini && \
	rm -rf /tmp/ioncube

#enable headers & rewrite mods
RUN a2enmod headers
RUN a2enmod rewrite

#modify www-data uid to match dev user
RUN usermod -u 1001 www-data
RUN mkdir -p /var/www && mkdir -p /var/www/.composer && chown -R 1001:1001 /var/www

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY start-apache.sh /
RUN chmod +x /start-apache.sh


#USER "www-data"

CMD ["/start-apache.sh"]

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR "/var/www/htdocs/"
