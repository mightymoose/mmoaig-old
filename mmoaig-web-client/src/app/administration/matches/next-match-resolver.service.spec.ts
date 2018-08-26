import { TestBed, inject } from '@angular/core/testing';

import { NextMatchResolverService } from './next-match-resolver.service';

describe('NextMatchResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [NextMatchResolverService]
    });
  });

  it('should be created', inject([NextMatchResolverService], (service: NextMatchResolverService) => {
    expect(service).toBeTruthy();
  }));
});
