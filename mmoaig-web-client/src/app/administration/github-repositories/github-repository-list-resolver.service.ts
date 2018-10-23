import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Resolve } from '@angular/router';
import { BackendService, GithubRepositoryEndpoint, BackendGithubRepositoryListResponse } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class GithubRepositoryListResolverService implements Resolve<BackendGithubRepositoryListResponse> {
  constructor(private backend: BackendService) {}

  resolve(): Observable<BackendGithubRepositoryListResponse> {
    return this.backend.list(GithubRepositoryEndpoint);
  }
}
