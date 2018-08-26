import { Injectable } from '@angular/core';
import { ApiService } from '../../core/api.service';
import { Observable } from 'rxjs';
import { GithubRepositories } from '../../model';
import { Resolve } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class GithubRepositoryListResolverService implements Resolve<GithubRepositories> {

  constructor(private api: ApiService) {}

  resolve(): Observable<GithubRepositories> {
    return this
      .api
      .get<GithubRepositories>('v1/github-repositories');
  }
}
