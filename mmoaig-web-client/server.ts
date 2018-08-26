import 'zone.js/dist/zone-node';
import 'reflect-metadata';

import { renderModuleFactory } from '@angular/platform-server';
import { enableProdMode } from '@angular/core';

import * as express from 'express';
import { join } from 'path';
import { readFileSync } from 'fs';

const { AppServerModuleNgFactory, LAZY_MODULE_MAP } = require('./dist/mmoaig-web-client-server/main');
import { provideModuleMap } from '@nguniversal/module-map-ngfactory-loader';

enableProdMode();

const app = express();

const PORT = process.env.PORT || 4000;
const DIST_FOLDER = process.cwd();

const template = readFileSync(join(DIST_FOLDER, 'mmoaig-web-client', 'index.html')).toString();

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
app.set('views', join(DIST_FOLDER, 'mmoaig-web-client'));

app.get('*.*', express.static(join(DIST_FOLDER, 'mmoaig-web-client')));

app.get('*', (req, res) => {
  res.render(join(DIST_FOLDER, 'mmoaig-web-client', 'index.html'), { req });
});

app.listen(PORT, () => {
  console.log(`Node server listening on http://localhost:${PORT}`);
});
