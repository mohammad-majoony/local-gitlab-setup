#!/bin/sh

CONTAINER_NAME="gitlab-runner"

docker exec "$CONTAINER_NAME" /bin/sh -c "
    gitlab-runner register \
        --non-interactive \
        --url 'http://gitlab-server:80' \
        --registration-token 'register' \
        --name 'DIND' \
        --docker-image 'docker:27.2.0' \
        --docker-privileged \
        --executor 'docker' \
        --docker-volumes '/certs/client' \
        --docker-network-mode 'gitlab-in-docker' \
        --docker-pull-policy 'if-not-present' \
        --clone-url 'http://gitlab-server:80' \
    && gitlab-runner run --user=gitlab-runner --working-directory=/etc/gitlab-runner
"

if [ $? -eq 0 ]; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
