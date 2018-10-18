import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Observable } from 'rxjs';
import { BackendService, JSONAPIListResponse, BackendGithubUserAttributes, GithubUserEndpoint } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class GithubUserListResolverService implements Resolve<JSONAPIListResponse<'github_users', BackendGithubUserAttributes>> {

  constructor(private backend: BackendService) {}

  // TODO: Add a type for this
  resolve(): Observable<JSONAPIListResponse<'github_users', BackendGithubUserAttributes>> {
    return this.backend.list(GithubUserEndpoint);
  }
}
