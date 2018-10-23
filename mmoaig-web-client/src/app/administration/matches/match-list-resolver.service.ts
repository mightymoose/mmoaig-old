import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { BackendService, JSONAPIListResponse, BackendMatchAttributes, MatchEndpoint, BackendMatchListResponse } from '@mmoaig/mmoaig-core';
import { Resolve } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class MatchListResolverService implements Resolve<BackendMatchListResponse> {

  constructor(private backend: BackendService) {}

  resolve(): Observable<BackendMatchListResponse> {
    return this.backend.list(MatchEndpoint);
  }
}
