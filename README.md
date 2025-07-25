# Tenmei.tech Bot Series #2: Distributed Web Rendering 🚀

> **Distributed, Secure, and Realistic Web Rendering with Docker + Puppeteer**



---

## ✨ Overview

This repo demonstrates a minimal, production-grade architecture for distributed web rendering and scraping — perfect for bot farms, automation, and research scenarios. The client (e.g., Raspberry Pi or any lightweight node) sends HTML input to a powerful, isolated render backend running Docker + Puppeteer, and receives screenshots/HTML in return.

**Features:**

- Distributed, scalable architecture
- Real headless Chrome (Puppeteer) in Docker for true-to-life rendering
- Secure file transfer with SSH/SCP (passwordless ready)
- Easy to extend for login, navigation, or stealth automation

---

## 📦 Directory Structure

```
puppeteer-ram-bot/
├── input/
│   └── input.html
├── output/
│   ├── render.png
│   └── render.html
├── render.sh
├── render.js
├── Dockerfile
├── package.json
└── README.md
```

---

## 🚀 Quickstart: Deploy on a Fresh Raspberry Pi (Client) & Ubuntu (Render Server)

### 1. **Prepare the Client (Raspberry Pi, etc.)**

```bash
# On your Pi
sudo apt update && sudo apt install -y curl openssh-client python3
mkdir -p ~/mei-client/html ~/mei-client/output
# Copy fetch-and-render.sh and py_render.py to ~/mei-client/
chmod +x ~/mei-client/fetch-and-render.sh
```

### 2. **Prepare the Render Server (Ubuntu + Docker)**

```bash
# On your render server
sudo apt update && sudo apt install -y docker.io nodejs npm openssh-server
sudo systemctl enable --now docker
git clone https://github.com/youruser/puppeteer-ram-bot.git
cd puppeteer-ram-bot
sudo docker build -t puppeteer-ram .
mkdir -p input output
# (Recommended) Setup passwordless SSH between Pi and server
```

### 3. **Test the Flow!**

On the **client**, run:

```bash
cd ~/mei-client
python3 py_render.py https://google.com
```

Result: You’ll receive the screenshot and rendered HTML in your `output/` folder!

---

## 🛡️ Why This Architecture?

- **Security:** Dockerized backend isolates all browser activity. No browser on your Pi, zero attack surface.
- **Realism:** Puppeteer with full Chromium gives real browser fingerprints — perfect for anti-bot bypassing.
- **Scalability:** Easily expand to bot farms (multiple clients, many render backends).
- **Modularity:** Simple, stateless transfers. Plug in proxies, login flows, and custom scripts with ease.

---

## 🧠 Next Steps

-

---

## 🤝 License & Credits

MIT.\
Built by [Tenmei.tech](https://tenmei.tech) for advanced web automation, research, and fun.\
*Give us a star if you like it! ⭐*

---

## 🥰 Portfolio & Article

Want a full technical deep dive?\
Read the illustrated article & architecture breakdown:\
👉 https://tenmei.tech/distributed-web-rendering/

---

# distributive_rendering
sample model directories for tenmei article about distributive rendering architecture mainly for bots
