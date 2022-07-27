# Contao-on-docker

This simple repository holds a docker-compose.yml File bundled to run a local environment. Within a few simple steps, you have a working contao installation with the Contao Manager run by Docker.

Just clone the repo, install and enjoy!

## SSL
If you like to have a local SSL connection to your environment, then simply install `mkcert` from this repo: [FiloSottile/mkcert](https://github.com/FiloSottile/mkcert). Follow the installation instructions in the README file.

IMPORTANT: Name the directory **ssl-certs** so the certificates get copied in the container during the building process. Also name the certs **contao.local**, so the command would be `mkcert contao.local`.
If you'd like to change that, then you have to change the certificate entry in the apache2 config and maybe change the directory name, which gets copied in the **php.dockerfile**.

Finally you have to create an entry in your hosts file.
```
$ sudo vim /etc/hosts
```
The entry is: `127.0.0.1  contao.local`

## Docker Compose
Make sure you have Docker and Docker Compose install on your system. To start the building process and run the environment, run this commands:

```
$ docker compose up -d --build
```
Voilà, this ist it. You can now open your Browser of choice and navigate to **http(s)://contao.local/contao-manager.phar.php**.
