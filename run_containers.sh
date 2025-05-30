COUNT=${1:-20}
IMAGE="alpine:latest"
START_PORT=${2:-8081}

PORT=$START_PORT

./delete_trash.sh

echo "Запускаю $COUNT контейнеров с образом $IMAGE..."
for i in $(seq 1 $COUNT); do
  NAME="alpine-$i"
  docker run -d \
    --name "$NAME" \
    -p "$PORT:80" \
    "$IMAGE" sh -c "while true; do sleep 1000; done"

  PORT=$(($START_PORT + i))
done

echo "Генерирую Ansible inventory и переменные..."
./generate_inv.sh "$COUNT" "$START_PORT"

while true; do
  sleep 1000;
done