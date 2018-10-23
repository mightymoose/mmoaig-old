import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Observable } from 'rxjs';
import { BackendService, GithubUserEndpoint, BackendGithubUserListResponse } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class GithubUserListResolverService implements Resolve<BackendGithubUserListResponse> {

  constructor(private backend: BackendService) {}

  resolve(): Observable<BackendGithubUserListResponse> {
    return this.backend.list(GithubUserEndpoint);
  }
}
