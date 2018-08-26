import { TestBed } from '@angular/core/testing';

import { BotSourcePathService } from './bot-source-path.service';

describe('BotSourcePathService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: BotSourcePathService = TestBed.get(BotSourcePathService);
    expect(service).toBeTruthy();
  });
});
