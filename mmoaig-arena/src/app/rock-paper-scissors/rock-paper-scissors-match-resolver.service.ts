import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { ApiService } from '../core/api.service';

@Injectable({
  providedIn: 'root'
})
export class RockPaperScissorsMatchResolverService implements Resolve<any> {

  constructor(private api: ApiService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<any> {
    return this.api.get(`v1/matches/${route.params.id}`);
  }
}
