import { TestBed, inject } from '@angular/core/testing';

import { MatchDetailsResolverService } from './match-details-resolver.service';

describe('MatchDetailsResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [MatchDetailsResolverService]
    });
  });

  it('should be created', inject([MatchDetailsResolverService], (service: MatchDetailsResolverService) => {
    expect(service).toBeTruthy();
  }));
});
