import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { ApiService } from '../../core/api.service';

@Injectable({
  providedIn: 'root'
})
export class UpdateMatchService {

  constructor(private api: ApiService) {}

  update(matchId: number, x: any): Observable<any> {
    return this.api.put(`/v1/matches/${matchId}`, x);
  }
}
