import { TestBed, inject } from '@angular/core/testing';

import { GithubRepositoryListResolverService } from './github-repository-list-resolver.service';

describe('GithubRepositoryListResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [GithubRepositoryListResolverService]
    });
  });

  it('should be created', inject([GithubRepositoryListResolverService], (service: GithubRepositoryListResolverService) => {
    expect(service).toBeTruthy();
  }));
});
