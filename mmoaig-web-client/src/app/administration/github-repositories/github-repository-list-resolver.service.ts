import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Resolve } from '@angular/router';
import { JSONAPIListResponse, BackendGithubRepositoryAttributes, BackendService, GithubRepositoryEndpoint } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class GithubRepositoryListResolverService implements 
  Resolve<JSONAPIListResponse<'github_repositories', BackendGithubRepositoryAttributes>> {

  constructor(private backend: BackendService) {}

  // TODO: Add a type for this!
  resolve(): Observable<JSONAPIListResponse<'github_repositories', BackendGithubRepositoryAttributes>> {
    return this.backend.list(GithubRepositoryEndpoint);
  }
}
