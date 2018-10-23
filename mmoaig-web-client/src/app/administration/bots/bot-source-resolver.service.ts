import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { BotService } from '@mmoaig/mmoaig-core';

@Injectable({
  providedIn: 'root'
})
export class BotSourceResolverService implements Resolve<string> {

  constructor(private bot: BotService) {}

  resolve(route: ActivatedRouteSnapshot): Observable<string> {
    return this.bot.source(route.params.id);
  }
}
