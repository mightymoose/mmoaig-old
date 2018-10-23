import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot } from '@angular/router';
import { MatchService } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class NextMatchResolverService {

  constructor(private match: MatchService) {}

  resolve(route: ActivatedRouteSnapshot) {
    return this.match.next();
  }
}
