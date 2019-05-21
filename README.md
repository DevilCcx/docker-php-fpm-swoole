# docker-php-fpm-swoole
docker laravel/lumen php-fpm swoole

#### docker
* 启动php-fpm容器
```
# 构建镜像
docker build -t php:v1 .
# 运行容器
docker run -d -p 9000:9000 -v 项目路径:/var/www/html php:v1
```
* 配合nginx
```
location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME /var/www/html/public$fastcgi_script_name;
        include fastcgi_params;
    }
```
