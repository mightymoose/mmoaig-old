import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { BackendService, MatchEndpoint } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class RockPaperScissorsMatchResolverService implements Resolve<any> {

  constructor(private backend: BackendService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<any> {
    return this.backend.get(MatchEndpoint, route.params.id);
  }
}
