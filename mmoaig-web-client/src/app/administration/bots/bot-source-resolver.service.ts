import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BotSourceResolverService implements Resolve<string> {
  resolve(route: ActivatedRouteSnapshot): Observable<string> {
    return of('test');
  }
}
