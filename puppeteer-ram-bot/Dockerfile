FROM node:18-slim

# Instala Chromium y herramientas necesarias
RUN apt-get update && apt-get install -y \
    chromium \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Crea una carpeta de trabajo no-root
WORKDIR /app

# Crea el package.json y lo copia antes de instalar
COPY package.json . 
RUN npm install

# Copia el render.js luego de tener todo el entorno listo
COPY render.js .

CMD ["node", "render.js"]
