import { TestBed, inject } from '@angular/core/testing';

import { ServerStateInterceptorService } from './server-state-interceptor.service';

describe('ServerStateInterceptorService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ServerStateInterceptorService]
    });
  });

  it('should be created', inject([ServerStateInterceptorService], (service: ServerStateInterceptorService) => {
    expect(service).toBeTruthy();
  }));
});
