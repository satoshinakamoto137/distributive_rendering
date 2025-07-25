
const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
  const content = fs.readFileSync('/app/input/input.html', 'utf-8');
  const browser = await puppeteer.launch({
    headless: "new",
    executablePath: '/usr/bin/chromium',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  const page = await browser.newPage();
  await page.setContent(content, { waitUntil: 'networkidle2' });
  await page.screenshot({ path: '/app/output/render.png' });
  const finalHTML = await page.content();
  fs.writeFileSync('/app/output/render.html', finalHTML);
  await browser.close();
})();
