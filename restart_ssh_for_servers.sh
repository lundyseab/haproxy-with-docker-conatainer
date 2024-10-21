for container in $(docker ps --format '{{.Names}}' | grep -E 'student_server-server[0-9]+-1'); do
  docker exec "$container" service ssh restart
done
