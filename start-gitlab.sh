docker stop gitlab-mysql gitlab-redis gitlab
docker rm gitlab-mysql gitlab-redis gitlab

docker run --name gitlab-mysql -d \
    --env-file ./gitlab.env \
    --volume /volume1/docker/mysql:/var/lib/mysql \
    -p 3336:3306 \
    sameersbn/mysql:latest
    
docker run --name gitlab-redis -d \
    --volume /volume1/docker/redis:/var/lib/redis \
    sameersbn/redis:latest
    
docker run --name gitlab -d  \
    --link gitlab-mysql:mysql \
    --link gitlab-redis:redisio \
    --publish 30001:22 --publish 30000:80 \
    --env-file ./gitlab.env \
    --volume /volume1/docker/gitlab:/home/git/data \
    sameersbn/gitlab:10.2.2