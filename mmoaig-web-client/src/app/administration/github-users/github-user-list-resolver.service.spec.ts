import { TestBed, inject } from '@angular/core/testing';

import { GithubUserListResolverService } from './github-user-list-resolver.service';

describe('GithubUserListResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [GithubUserListResolverService]
    });
  });

  it('should be created', inject([GithubUserListResolverService], (service: GithubUserListResolverService) => {
    expect(service).toBeTruthy();
  }));
});
