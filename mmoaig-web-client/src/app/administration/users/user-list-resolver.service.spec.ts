import { TestBed, inject } from '@angular/core/testing';

import { UserListResolverService } from './user-list-resolver.service';

describe('UserListResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [UserListResolverService]
    });
  });

  it('should be created', inject([UserListResolverService], (service: UserListResolverService) => {
    expect(service).toBeTruthy();
  }));
});
