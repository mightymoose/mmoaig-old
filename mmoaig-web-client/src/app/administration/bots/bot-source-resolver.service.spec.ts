import { TestBed, inject } from '@angular/core/testing';

import { BotSourceResolverService } from './bot-source-resolver.service';

describe('BotSourceResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BotSourceResolverService]
    });
  });

  it('should be created', inject([BotSourceResolverService], (service: BotSourceResolverService) => {
    expect(service).toBeTruthy();
  }));
});
