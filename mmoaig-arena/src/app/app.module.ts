import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { CoreModule } from './core/core.module';
import { RedirectToMatchRunnerComponent } from './redirect-to-match-runner/redirect-to-match-runner.component';
import { environment } from '../environments/environment';

@NgModule({
  declarations: [
    AppComponent,
    RedirectToMatchRunnerComponent
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'serverApp' }),
    AppRoutingModule,
    CoreModule.forRoot({apiBase: environment.apiBase})
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
