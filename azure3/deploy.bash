mkdir -p ./{pgdata,static}

docker run -d -p 8080:80 -p 22:1234 --name mycontainer -e SECRET_KEY_BASE=secret \
  -v pgdata:/var/openproject/pgdata \
  -v static:/var/openproject/assets \
  openproject/community:latest
