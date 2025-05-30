echo "Удаляю все контейнеры вида alpine-[0-9]+..."
docker ps -a --format '{{.Names}}' | grep -E '^alpine-[0-9]+$' | xargs -r docker rm -f
echo "✅ Готово."
