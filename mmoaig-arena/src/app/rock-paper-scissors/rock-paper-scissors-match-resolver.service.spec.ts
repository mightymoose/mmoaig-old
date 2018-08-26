import { TestBed } from '@angular/core/testing';

import { RockPaperScissorsMatchResolverService } from './rock-paper-scissors-match-resolver.service';

describe('RockPaperScissorsMatchResolverService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: RockPaperScissorsMatchResolverService = TestBed.get(RockPaperScissorsMatchResolverService);
    expect(service).toBeTruthy();
  });
});
