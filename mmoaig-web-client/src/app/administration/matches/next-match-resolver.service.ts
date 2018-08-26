import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of, throwError } from 'rxjs';
import { Match } from '../../model';
import { ApiService } from '../../core/api.service';
import { catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class NextMatchResolverService {

  constructor(private api: ApiService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<Match | any> {
    return this
      .api
      .get<Match>('v1/matches/next')
      .pipe(
        catchError(error => {
          return  (error.status === 404) ? of({data: null}) : throwError(error);
        })
      );
  }
}
