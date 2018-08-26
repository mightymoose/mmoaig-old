import { Injectable } from '@angular/core';
import { ApiService } from '../../core/api.service';
import { Observable } from 'rxjs';
import { Match } from '../../model';
import { ActivatedRouteSnapshot } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class MatchDetailsResolverService {
  constructor(private api: ApiService) {}

  resolve(route: ActivatedRouteSnapshot): Observable<Match> {
    return this
      .api
      .get<Match>(`v1/matches/${route.params.id}`);
  }
}
