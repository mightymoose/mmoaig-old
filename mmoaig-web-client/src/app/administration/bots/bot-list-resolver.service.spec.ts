import { TestBed, inject } from '@angular/core/testing';

import { BotListResolverService } from './bot-list-resolver.service';

describe('BotListResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BotListResolverService]
    });
  });

  it('should be created', inject([BotListResolverService], (service: BotListResolverService) => {
    expect(service).toBeTruthy();
  }));
});
