#!/bin/bash

USER="youruser"
INPUT_FILE="/home/$USER/puppeteer-ram-bot/input/input.html"
TRIES=10
while [ ! -f "$INPUT_FILE" ] && [ $TRIES -gt 0 ]; do
  echo "⏳ Esperando input.html ($TRIES)..."
  sleep 0.5
  TRIES=$((TRIES - 1))
done

if [ ! -f "$INPUT_FILE" ]; then
  echo "❌ input.html no encontrado. Abortando render..."
  exit 1
fi

echo "📖 Preview del input que se montará en el contenedor:"
head -n 5 "$INPUT_FILE"

echo "🚀 Lanzando render"
docker run --rm \
  -v /home/$USER/puppeteer-ram-bot/input:/app/input:ro \
  -v /home/$USER/puppeteer-ram-bot/output:/app/output \
  puppeteer-ram

chown -R $USER:$USER /home/$USER/puppeteer-ram-bot/output
