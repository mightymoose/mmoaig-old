import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { ApiService } from '../../core/api.service';
import { Observable } from 'rxjs';
import { GithubUsers } from '../../model';

@Injectable({
  providedIn: 'root'
})
export class GithubUserListResolverService implements Resolve<GithubUsers> {

  constructor(private api: ApiService) {}

  resolve(): Observable<GithubUsers> {
    return this
      .api
      .get<GithubUsers>('v1/github-users');
  }
}
