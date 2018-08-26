import { Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { ActivatedRouteSnapshot } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class NextMatchResolverService {

  constructor(private api: ApiService) {}

  resolve(route: ActivatedRouteSnapshot) {
    return this
      .api
      .get<any>('v1/matches/next');
  }
}
