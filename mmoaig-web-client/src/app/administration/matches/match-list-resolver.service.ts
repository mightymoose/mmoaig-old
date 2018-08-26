import { Injectable } from '@angular/core';
import { ApiService } from '../../core/api.service';
import { Observable } from 'rxjs';
import { Matches } from '../../model';

@Injectable({
  providedIn: 'root'
})
export class MatchListResolverService {

  constructor(private api: ApiService) {}

  resolve(): Observable<Matches> {
    return this
      .api
      .get<Matches>('v1/matches');
  }
}
