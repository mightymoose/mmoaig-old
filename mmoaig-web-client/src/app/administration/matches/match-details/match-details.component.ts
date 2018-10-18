import { Component } from '@angular/core';
import { Observable, of } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { pluck } from 'rxjs/operators';
import { JSONAPIListResponse, BackendMatchAttributes } from '@mmoaig/mmoaig-core';

@Component({
  selector: 'mmo-match-details',
  templateUrl: './match-details.component.html',
  styleUrls: ['./match-details.component.css']
})
export class MatchDetailsComponent {
  constructor(private route: ActivatedRoute) {
  }

  get matchId(): Observable<string> {
    return this.match.pipe(pluck('id'));
  }

  get matchStatus(): Observable<string> {
    return this.match.pipe(pluck('attributes', 'status'));
  }

  get matchType(): Observable<string> {
    return this.match.pipe(pluck('attributes', 'type'));
  }

  get bots(): Observable<any> {
    return this.route.data.pipe(pluck('match', 'data', 'relationships', 'participants', 'data'));
  }

  private get match(): Observable<JSONAPIListResponse<'matches', BackendMatchAttributes>> {
    return this.route.data.pipe(pluck('match', 'data'));
  }
}
