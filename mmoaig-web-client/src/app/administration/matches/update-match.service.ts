import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { BackendService, BackendMatchAttributes, MatchEndpoint } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class UpdateMatchService {

  constructor(private backend: BackendService) {}

  update(matchId: number, attributes: BackendMatchAttributes): Observable<any> {
    return this.backend.update(MatchEndpoint, matchId, attributes);
  }
}
