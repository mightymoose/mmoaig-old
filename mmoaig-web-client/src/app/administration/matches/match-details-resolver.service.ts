import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRouteSnapshot, Resolve } from '@angular/router';
import { BackendService, BackendMatchAttributes, MatchEndpoint, JSONAPIResponse, BackendMatchResponse } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class MatchDetailsResolverService implements Resolve<BackendMatchResponse> {
  constructor(private backend: BackendService) {}

  resolve(route: ActivatedRouteSnapshot): Observable<BackendMatchResponse> {
    return this.backend.get(MatchEndpoint, route.params.id);
  }
}
