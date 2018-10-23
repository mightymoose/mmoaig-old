import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, Resolve } from '@angular/router';
import { Observable, of } from 'rxjs';
import { BackendMatchResponse, MatchService } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class NextMatchResolverService implements Resolve<BackendMatchResponse> {

  constructor(private match: MatchService) {}

  resolve(route: ActivatedRouteSnapshot): Observable<BackendMatchResponse> {
    return this.match.next();
  }
}
