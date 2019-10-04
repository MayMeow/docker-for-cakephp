# Docker for CakePHP

## Installation

Copy theese files to your cakephp project and siply run `docker-compose build` and `docker-compose start`

## Configuration

Look at files and update configuration as you need. This docker compose running with postgres so you need update your configuration file and use `Postgres driver`
Then change folloving lines to looks like this

```php
'port' => env('DB_PORT', '5435'),
'username' => env('DB_USER', '__DB_USER__'),
'password' => env('DB_PASSWORD', '__DB_SECRET__'),
'database' => env('DB_NAME', '___DB_NAME__'),
```

## Startup script

Check `docker/php/docker-entry-sh` and update it how you need. This file runs migrations every start and checking if file `/var/www/html/vendor/autoload.php` exists if not then it runs `composer install`...

```bash
echo "Running migrations..."
cd /var/www/html

# This script is runniing every start of php container
bin/cake migrations migrate -p Identity
bin/cake migrations migrate -p Blog
bin/cake migrations migrate -p Settings
bin/cake migrations migrate -p PostBox

echo "Starting server..."
php-fpm
```