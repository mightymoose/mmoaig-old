import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { BackendService, MatchEndpoint } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class MatchDetailsResolverService {
  constructor(private backend: BackendService) {}

  resolve(route: ActivatedRouteSnapshot): Observable<any> {
    return this
      .backend
      .get(MatchEndpoint, route.params.id);
  }
}
