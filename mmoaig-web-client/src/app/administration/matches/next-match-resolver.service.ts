import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class NextMatchResolverService {
  resolve(route: ActivatedRouteSnapshot): Observable<any> {
    return of('test');
  }
}
