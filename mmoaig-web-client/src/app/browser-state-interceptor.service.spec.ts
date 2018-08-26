import { TestBed, inject } from '@angular/core/testing';

import { BrowserStateInterceptorService } from './browser-state-interceptor.service';

describe('BrowserStateInterceptorService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BrowserStateInterceptorService]
    });
  });

  it('should be created', inject([BrowserStateInterceptorService], (service: BrowserStateInterceptorService) => {
    expect(service).toBeTruthy();
  }));
});
