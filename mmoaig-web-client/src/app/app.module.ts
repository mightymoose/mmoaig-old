import { BrowserModule, BrowserTransferStateModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { MmoaigCoreModule } from '@mmoaig/mmoaig-core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { ServiceWorkerModule } from '@angular/service-worker';
import { environment } from '../environments/environment';
import { BrowserStateInterceptorService } from './browser-state-interceptor.service';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'mmoaig' }),
    BrowserTransferStateModule,
    AppRoutingModule,
    MmoaigCoreModule.forRoot({apiBase: environment.apiBase}),
    HttpClientModule,
    ServiceWorkerModule.register('ngsw-worker.js', { enabled: environment.production })
  ],
  providers: [{
    provide: HTTP_INTERCEPTORS,
    useClass: BrowserStateInterceptorService,
    multi: true
  }],
  bootstrap: [AppComponent]
})
export class AppModule { }
