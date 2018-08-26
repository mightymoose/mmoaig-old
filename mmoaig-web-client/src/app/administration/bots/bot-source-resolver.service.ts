import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { ApiService } from '../../core/api.service';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BotSourceResolverService implements Resolve<string> {
  constructor(private api: ApiService) {}

  resolve(route: ActivatedRouteSnapshot): Observable<string> {
    return this
      .api
      .get<string>(`v1/bots/${route.params.id}/source`, {responseType: 'text'});
  }
}
