import { TestBed, inject } from '@angular/core/testing';

import { MatchListResolverService } from './match-list-resolver.service';

describe('MatchListResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [MatchListResolverService]
    });
  });

  it('should be created', inject([MatchListResolverService], (service: MatchListResolverService) => {
    expect(service).toBeTruthy();
  }));
});
