import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRouteSnapshot, Resolve } from '@angular/router';
import { BackendService, BackendMatchAttributes, MatchEndpoint, JSONAPIResponse } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class MatchDetailsResolverService implements Resolve<JSONAPIResponse<'matches', BackendMatchAttributes>> {
  constructor(private backend: BackendService) {}

  resolve(route: ActivatedRouteSnapshot): Observable<JSONAPIResponse<'matches', BackendMatchAttributes>> {
    return this.backend.get(MatchEndpoint, route.params.id);
  }
}
