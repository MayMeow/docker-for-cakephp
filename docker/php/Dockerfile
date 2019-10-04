FROM maymeow/cakephp-ci:php-7.2-fpm

COPY docker-entry.sh /usr/local/bin/docker-entry
RUN chmod +x /usr/local/bin/docker-entry

CMD ["docker-entry"]
