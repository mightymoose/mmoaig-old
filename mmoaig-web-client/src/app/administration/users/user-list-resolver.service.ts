import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Observable } from 'rxjs';
import { BackendService, UserEndpoint, BackendUserListResponse } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class UserListResolverService implements Resolve<BackendUserListResponse> {

  constructor(private backend: BackendService) {}

  resolve(): Observable<BackendUserListResponse> {
    return this.backend.list(UserEndpoint);
  }
}
