import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Observable } from 'rxjs';
import { BackendService, BotEndpoint, JSONAPIListResponse, BackendBotAttributes } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class BotListResolverService implements Resolve<JSONAPIListResponse<'bots', BackendBotAttributes>> {
  constructor(private backend: BackendService) {}

  // TODO: Add an endpoint for the next match
  // TODO: Add an endpoint for bot source 
  // TODO: Add a type for this:
  resolve(): Observable<JSONAPIListResponse<'bots', BackendBotAttributes>> {
    return this.backend.list(BotEndpoint);
  }

}
