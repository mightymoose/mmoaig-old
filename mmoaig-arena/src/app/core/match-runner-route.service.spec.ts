import { TestBed } from '@angular/core/testing';

import { MatchRunnerRouteService } from './match-runner-route.service';

describe('MatchRunnerRouteService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: MatchRunnerRouteService = TestBed.get(MatchRunnerRouteService);
    expect(service).toBeTruthy();
  });
});
