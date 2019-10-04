#!/bin/bash

echo -ne "Update folder and files rights..."
chmod +x /var/www/html/bin/cake

if [ ! -f /var/www/html/vendor/autoload.php ]; then
    echo "Autoload file not found! Installing dependencies..."
    composer selfupdate
    composer install
fi

echo "Wait until database $MYSQL_HOST:5432 is ready..."
until nc -z $DB_HOST 5432
do
    sleep 1
done

# Wait to avoid "panic: Failed to open sql connection pq: the database system is starting up"
sleep 1

echo "Running migrations..."
cd /var/www/html

# This script is runniing every start of php container
bin/cake migrations migrate -p Identity
bin/cake migrations migrate -p Blog
bin/cake migrations migrate -p Settings
bin/cake migrations migrate -p PostBox

echo "Starting server..."
php-fpm
