import { TestBed } from '@angular/core/testing';

import { NextMatchResolverService } from './next-match-resolver.service';

describe('NextMatchResolverService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: NextMatchResolverService = TestBed.get(NextMatchResolverService);
    expect(service).toBeTruthy();
  });
});
