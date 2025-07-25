const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

(async () => {
  try {
    const inputPath = '/app/input/input.html';
    const outputDir = '/app/output';
    const screenshotPath = path.join(outputDir, 'render.png');
    const htmlPath = path.join(outputDir, 'render.html');

    // 💌 Leer HTML
    const content = fs.readFileSync(inputPath, 'utf-8');
    console.log(`📥 Input cargado: ${inputPath} (${content.length} chars)`);

    // 💻 Lanzar Chromium
    const browser = await puppeteer.launch({
      headless: "new",
      executablePath: '/usr/bin/chromium',
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();

    // ⏳ Esperar carga JS
    await page.setContent(content, { waitUntil: 'networkidle2' });

    // 📸 Guardar screenshot
    await page.screenshot({ path: screenshotPath });
    console.log(`🖼️ Screenshot guardado: ${screenshotPath}`);

    // 💾 Guardar HTML renderizado
    const finalHTML = await page.content();
    fs.writeFileSync(htmlPath, finalHTML);
    console.log(`📝 HTML guardado: ${htmlPath} (${finalHTML.length} chars)`);

    await browser.close();
    console.log("🎉 Render finalizado con éxito");

  } catch (err) {
    console.error("💥 ERROR durante el render:", err.message || err);
  }
})();

//cd ~/puppeteer-ram-bot
//docker build -t puppeteer-ram .