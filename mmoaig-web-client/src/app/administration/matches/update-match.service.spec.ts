import { TestBed, inject } from '@angular/core/testing';

import { UpdateMatchService } from './update-match.service';

describe('UpdateMatchService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [UpdateMatchService]
    });
  });

  it('should be created', inject([UpdateMatchService], (service: UpdateMatchService) => {
    expect(service).toBeTruthy();
  }));
});
