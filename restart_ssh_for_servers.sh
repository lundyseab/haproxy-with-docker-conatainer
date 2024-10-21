mydir="$(basename $PWD)"
for container in $(docker ps --format '{{.Names}}' | grep -E ${mydir}'-server[0-9]+-1'); do
  docker exec "$container" service ssh restart
done
