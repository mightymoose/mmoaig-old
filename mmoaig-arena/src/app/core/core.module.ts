import { NgModule, ModuleWithProviders, SkipSelf, Optional } from '@angular/core';
import { CommonModule } from '@angular/common';
import { API_BASE } from './injection_tokens';
import { HttpClientModule } from '@angular/common/http';

interface CoreModuleConfig {
  apiBase: string;
}

@NgModule({
  imports: [
    CommonModule,
    HttpClientModule
  ],
  declarations: []
})
export class CoreModule {
  constructor( @Optional() @SkipSelf() parentModule: CoreModule) {
    if (parentModule) {
      throw new Error('CoreModule has already been loaded. You should only import Core modules in the AppModule only.');
    }
  }

  static forRoot(config: CoreModuleConfig): ModuleWithProviders {
    return {
      ngModule: CoreModule,
      providers: [
        {provide: API_BASE, useValue: config.apiBase}
      ]
    };
  }
 }
