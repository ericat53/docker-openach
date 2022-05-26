FROM docker/whalesay:latest
LABEL Name=dockeropenach Version=0.0.1
RUN apt-get -y update && apt-get install -y fortunes
CMD ["sh", "-c", "/usr/games/fortune -a | cowsay"]
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
   Organization Name (eg, company) [Internet Widgits Pty Ltd]:Your Company, Inc.
   Organizational Unit Name (eg, section) []:
   Common Name (e.g. server FQDN or YOUR name) []:localhost
   Email Address []:info@yourcompany.com

    