const puppeteer = require('puppeteer');

(async () => {
    const browser = await puppeteer.launch({args: ['--no-sandbox']});
    const page = await browser.newPage();
    await page.goto('https://www.mmoaig.com/administration/matches');
    const html = await page.evaluate(() => document.body.innerHTML);
    console.log(html);
    await browser.close();
})();

