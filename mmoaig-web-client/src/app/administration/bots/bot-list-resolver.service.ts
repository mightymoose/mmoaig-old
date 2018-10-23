import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Observable } from 'rxjs';
import { BackendService, BotEndpoint, BackendBotListResponse } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class BotListResolverService implements Resolve<BackendBotListResponse> {
  constructor(private backend: BackendService) {}

  resolve(): Observable<BackendBotListResponse> {
    return this.backend.list(BotEndpoint);
  }

}
