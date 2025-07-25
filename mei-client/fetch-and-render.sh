#!/bin/bash

# 🌐 URL como argumento
URL="$1"
if [ -z "$URL" ]; then
  echo "⚠️  Debes proporcionar una URL como argumento."
  echo "Ejemplo: ./fetch-and-render.sh https://www.linkedin.com"
  exit 1
fi

# 🧁 CONFIG
REMOTE_USER="youruser"
REMOTE_HOST="192.168.0.100"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Paths
REMOTE_INPUT="/home/$REMOTE_USER/puppeteer-ram-bot/input/input.html"
REMOTE_OUTPUT_DIR="/home/$REMOTE_USER/puppeteer-ram-bot/output"
LOCAL_HTML="html/input.html"
LOCAL_OUTPUT_DIR="output"
LOCAL_OUTPUT_PNG="$LOCAL_OUTPUT_DIR/render-$TIMESTAMP.png"
LOCAL_OUTPUT_HTML="$LOCAL_OUTPUT_DIR/render-$TIMESTAMP.html"


echo "🔍 URL que se va a descargar: $URL"

# 1️⃣ Recolectar contenido
echo "🌐 Haciendo request a $URL desde la Raspberry..."
curl -sL "$URL" -o "$LOCAL_HTML"

# 2️⃣ Enviar HTML a Himeryu
echo "📤 Enviando input.html a Himeryu..."
scp "$LOCAL_HTML" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_INPUT"


# 💡 Verificar que el archivo existe antes de renderizar
echo "🔍 Verificando que input.html se encuentra en Himeryu..."
ssh "$REMOTE_USER@$REMOTE_HOST" "ls -lh $REMOTE_INPUT || echo '❌ No existe input.html en Himeryu 😵‍💫'"


# 3️⃣ Ejecutar render remoto
echo "🧠 Ejecutando render desde Himeryu (RAM only)..."
ssh "$REMOTE_USER@$REMOTE_HOST" "/home/$REMOTE_USER/puppeteer-ram-bot/render.sh"

# 4️⃣ Descargar resultado
echo "📥 Descargando render result (screenshot + HTML)..."
scp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_OUTPUT_DIR/render.png" "$LOCAL_OUTPUT_PNG"
scp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_OUTPUT_DIR/render.html" "$LOCAL_OUTPUT_HTML"

# 5️⃣ Mostrar resultado si posible
if command -v xdg-open &> /dev/null; then
  xdg-open "$LOCAL_OUTPUT_PNG"
fi

echo "✅ Proceso completado. Resultados:"
echo "🖼️  Imagen: $LOCAL_OUTPUT_PNG"
echo "📝 HTML:   $LOCAL_OUTPUT_HTML"
