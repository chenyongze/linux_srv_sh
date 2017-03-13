server {
    listen   80;
    root /home/www/mysite;
    index index.html index.htm index.php;
    server_name www.lingyun.net;
    client_max_body_size 100m;

    location / {
        try_files $uri $uri/ /index.php?s=$uri&$args;
    }

    # 开启PHP支持
    location ~ \.php {
        fastcgi_split_path_info ^(.+\.php)(.*)$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param PATH_INFO $fastcgi_path_info;

        # 环境变量
        fastcgi_param LY_APP_DEBUG 'true';
        fastcgi_param LY_DEV_MODE 'true';
        fastcgi_param LY_DB_NAME 'mysite';
        fastcgi_param LY_DB_USER 'test';
        fastcgi_param LY_DB_PWD 'test';

        # 加载Nginx默认"服务器环境变量"配置
        include fastcgi_params;
    }


    # 目录及文件权限设置
    location ~ /Runtime/$ {
        deny all;
    }
    location ~ /Uploads/.*\.php$ {
        deny all;
    }
    location ~ /Uploads/$ {
        deny all;
    }
    location ~ /\.ht {
        deny all;
    }
}
