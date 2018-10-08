import 'zone.js/dist/zone-node';
import 'reflect-metadata';

import { renderModuleFactory } from '@angular/platform-server';
import { enableProdMode } from '@angular/core';

import * as express from 'express';
import { join } from 'path';
import { readFileSync } from 'fs';

const { AppServerModuleNgFactory, LAZY_MODULE_MAP } = require('./dist/mmoaig-arena-server/main');
import { provideModuleMap } from '@nguniversal/module-map-ngfactory-loader';

const puppeteer = require('puppeteer');

enableProdMode();

const app = express();

const PORT = process.env.PORT || 4000;
const DIST_FOLDER = process.cwd();

const template = readFileSync(join(DIST_FOLDER, 'mmoaig-arena', 'index.html')).toString();

app.engine('html', (_: any, options: any, callback: any) => {
  renderModuleFactory(AppServerModuleNgFactory, {
    document: template,
    url: options.req.url,
    extraProviders: [
      provideModuleMap(LAZY_MODULE_MAP)
    ]
  }).then(html => {
    callback(null, html);
  });
});

app.set('view engine', 'html');
app.set('views', join(DIST_FOLDER, 'mmoaig-arena'));

app.get('*.*', express.static(join(DIST_FOLDER, 'mmoaig-arena')));

app.get('*', (req, res) => {
  res.render(join(DIST_FOLDER, 'mmoaig-arena', 'index.html'), { req });
});

const server = app.listen(PORT, () => {
  console.log(`Node server listening on http://localhost:${PORT}`);
});

(async () => {
  const browser = await puppeteer.launch({dumpio: true});
  const page = await browser.newPage();
  await page.goto('https://example.com');
  await browser.close();
  server.close();
})();
