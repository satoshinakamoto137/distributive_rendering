#!/bin/bash

# 🧁 CONFIG
REMOTE_USER="renderbot"
REMOTE_HOST="192.168.0.100"
REMOTE_INPUT="/home/$REMOTE_USER/puppeteer-ram-bot/input/input.html"
REMOTE_OUTPUT_DIR="/home/$REMOTE_USER/puppeteer-ram-bot/output"
LOCAL_HTML="html/input.html"
LOCAL_OUTPUT_png="output/render.png"
LOCAL_OUTPUT_html="output/render.html"

# 1️⃣ Recolectar contenido de LinkedIn
echo "🌐 Haciendo request a LinkedIn desde la Raspberry..."
curl -sL "https://www.linkedin.com" -o "$LOCAL_HTML"

# 2️⃣ Enviar HTML a Himeryu
echo "📤 Enviando input.html a Himeryu..."
scp "$LOCAL_HTML" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_INPUT"

# 3️⃣ Ejecutar render remoto
echo "🧠 Ejecutando render desde Himeryu (RAM only)..."
ssh "$REMOTE_USER@$REMOTE_HOST" "/home/$REMOTE_USER/puppeteer-ram-bot/render.sh"

# 4️⃣ Traer la imagen generada
echo "📥 Descargando render result (screenshot)..."
scp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_OUTPUT_DIR/render.png" "$LOCAL_OUTPUT_png"

# Descargar también el HTML final procesado
scp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_OUTPUT_DIR/render.html" "$LOCAL_OUTPUT_html"

echo "✅ Proceso completado. Abriendo imagen renderizada..."
xdg-open "$LOCAL_OUTPUT"
