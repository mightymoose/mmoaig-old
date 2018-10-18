import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { BackendService, JSONAPIListResponse, BackendMatchAttributes, MatchEndpoint } from '@mmoaig/mmoaig-core';
import { Resolve } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class MatchListResolverService implements Resolve<JSONAPIListResponse<'matches', BackendMatchAttributes>> {

  constructor(private backend: BackendService) {}

  // TODO: Add a type for this
  resolve(): Observable<JSONAPIListResponse<'matches', BackendMatchAttributes>> {
    return this.backend.list(MatchEndpoint);
  }
}
