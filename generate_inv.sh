#!/bin/bash

COUNT=${1:-20}
START_PORT=${2:-8081}
INVENTORY_FILE="inventory.ini"
HOSTVARS_DIR="host_vars"

# Очистка inventory , hostwars и старых контейнеров
echo "Очищаю старые inventory и host_vars..."
rm -f "$INVENTORY_FILE"
rm -rf "$HOSTVARS_DIR"
mkdir -p "$HOSTVARS_DIR"

echo "[alpine_containers]" > "$INVENTORY_FILE"

for i in $(seq 1 $COUNT); do
  PORT=$((START_PORT + i - 1))
  NAME="alpine-$i"
  echo "$NAME ansible_connection=docker" >> "$INVENTORY_FILE"

  NEXT_PORT=$((PORT + 1))
  [ "$i" -eq "$COUNT" ] && NEXT_PORT=$START_PORT

  cat > "$HOSTVARS_DIR/$NAME.yml" <<EOF
next_port: $NEXT_PORT
EOF
done

echo "Готово: inventory.ini и host_vars обновлены."