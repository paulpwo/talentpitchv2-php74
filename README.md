# Docker PHP-FPM 7.4 & Nginx 1.18 on Alpine Linux
Base from https://github.com/TrafeX/docker-php-nginx
## Usage

Start the Docker container:

    docker run -p 80:5001 paulpwo/talentpitchv2-php74:amd64

See the PHP info on http://localhost, or the static html page on http://localhost/test.html

Or mount your own code to be served by PHP-FPM & Nginx

    docker run -p 80:5001 -v ~/my-codebase:/var/www/html paulpwo/talentpitchv2-php74:amd64

## Configuration
In [config/](config/) you'll find the default configuration files for Nginx, PHP and PHP-FPM.
If you want to extend or customize that you can do so by mounting a configuration file in the correct folder;

Nginx configuration:

    docker run -v "`pwd`/nginx-server.conf:/etc/nginx/conf.d/server.conf" paulpwo/talentpitchv2-php74:amd64

PHP configuration:

    docker run -v "`pwd`/php-setting.ini:/etc/php7/conf.d/settings.ini" paulpwo/talentpitchv2-php74:amd64

PHP-FPM configuration:

    docker run -v "`pwd`/php-fpm-settings.conf:/etc/php7/php-fpm.d/server.conf" paulpwo/talentpitchv2-php74:amd64

_Note; Because `-v` requires an absolute path I've added `pwd` in the example to return the absolute path to the current directory_


## Adding composer

If you need [Composer](https://getcomposer.org/) in your project, here's an easy way to add it.

```dockerfile
FROM paulpwo/talentpitchv2-php74:amd64

# Install composer from the official image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Run composer install to install the dependencies
RUN composer install --optimize-autoloader --no-interaction --no-progress
```

### Building with composer

If you are building an image with source code in it and dependencies managed by composer then the definition can be improved.
The dependencies should be retrieved by the composer but the composer itself (`/usr/bin/composer`) is not necessary to be included in the image.

```Dockerfile
FROM composer AS composer

# copying the source directory and install the dependencies with composer
COPY <your_directory>/ /app

# run composer install to install the dependencies
RUN composer install \
  --optimize-autoloader \
  --no-interaction \
  --no-progress

# continue stage build with the desired image and copy the source including the
# dependencies downloaded by composer
FROM paulpwo/alpine-nginx-php7
COPY --chown=nginx --from=composer /app /var/www/html
```


## Build
´´´
    docker build -f Dockerfile -t talentpitchv2-php74 . --platform linux/arm64/v8
    docker tag talentpitchv2-php74 paulpwo/talentpitchv2-php74:amd64
    docker push  paulpwo/talentpitchv2-php74:amd64
´´´