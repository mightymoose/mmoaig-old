const puppeteer = require('puppeteer');

(async () => {
    console.log('Launching the match runner...');
    const browser = await puppeteer.launch({args: ['--no-sandbox']});
    console.log('Match runner launched...');

    console.log('Creating a new page...');
    const page = await browser.newPage();
    page.on('console', msg => console.log('PAGE LOG:', msg.text()));
    console.log('New page created...');

    console.log('Loading the arena...');
    await page.goto('http://mmoaig-arena:4000/');
    console.log('Arena loaded...');

    await page.waitForSelector('.match-complete');
    console.log('Match complete!');

    await browser.close();
})();

