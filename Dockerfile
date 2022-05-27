FROM ubuntu:14.04
MAINTAINER Steven Brendtro <info@openach.com>

# Turn off apt's cache in the container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Update and install system base packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        git \
        subversion \
        sqlite3 \
        apache2 \
        php5 \
        php5-cli \
        php5-mcrypt \
        php5-sqlite \
        php5-pgsql \
        php5-curl \
        build-essential \
        php5-dev \
        php-pear && \
    apt-get clean && \
    pecl install doublemetaphone && \
    echo 'extension=doublemetaphone.so' > /etc/php5/mods-available/doublemetaphone.ini && \
    php5enmod doublemetaphone mcrypt sqlite pgsql curl && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Initialize application
WORKDIR /home/www/
ADD setup.d/yii-1.1.16.bca042.tar.gz /home/www/
ADD setup.d/openach-1.5.tar.gz /home/www/openach/
RUN ln -s yii-1.1.16.bca042/ yii

# Create some symlinks to simplify things when running the docker
RUN ln -s /home/www/openach/protected/config /config && \
    ln -s /home/www/openach/protected/runtime /runtime && \
    ln -s /home/www/openach/protected/openach /openach

RUN chmod 777 /home/www/openach/protected/runtime/log

RUN chown -R www-data:www-data /home/www/openach/protected/runtime/
RUN chown -R www-data:www-data /home/www/openach/assets/

ADD setup.d/openach-init.php /openach-init.php

# Configure Apache
ADD setup.d/etc/apache2/sites-available/* /etc/apache2/sites-available/
RUN a2enmod alias dir mime php5 rewrite status && \
    a2ensite 000-default
RUN a2enmod ssl && \
    a2ensite default-ssl

# Expose HTTP and HTTPS
EXPOSE 80 443

# Add a start management script
ADD setup.d/openach-start /openach-start

# By default, run our start scripts
CMD ["bash", "/openach-start"]


   # ./makecerts.sh 
   Generating a 4086 bit RSA private key
   ....++
   .................................++

   writing new private key to './ssl/openach-self-signed.key'
   -----

   You are about to be asked to enter information that will be incorporated
   into your certificate request.
   What you are about to enter is what is called a Distinguished Name or a DN.
   There are quite a few fields but you can leave some blank
   For some fields there will be a default value,
   If you enter '.', the field will be left blank.
   -----
   Country Name (2 letter code) [AU]:US
   State or Province Name (full name) [Some-State]:New York
   Locality Name (eg, city) []:New York
   Organization Name (eg, company) [Internet Widgits Pty Ltd]:Open Doors
   Organizational Unit Name (eg, section) []:
   Common Name (e.g. server FQDN or YOUR name) []:localhost
   Email Address []:susanketterer4@gmail.com
   