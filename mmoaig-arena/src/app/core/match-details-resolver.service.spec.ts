import { TestBed } from '@angular/core/testing';

import { MatchDetailsResolverService } from './match-details-resolver.service';

describe('MatchDetailsResolverService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: MatchDetailsResolverService = TestBed.get(MatchDetailsResolverService);
    expect(service).toBeTruthy();
  });
});
