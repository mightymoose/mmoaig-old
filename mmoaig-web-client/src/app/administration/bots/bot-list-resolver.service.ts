import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Bots, Bot } from '../../model';
import { ApiService } from '../../core/api.service';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BotListResolverService implements Resolve<Bot[]> {
  constructor(private api: ApiService) {}

  resolve(): Observable<Bot[]> {
    return this
      .api
      .get<Bots>('v1/bots');
  }

}
