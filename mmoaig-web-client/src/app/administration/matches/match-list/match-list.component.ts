import { Component, OnInit } from '@angular/core';
import { of, Observable } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { pluck } from 'rxjs/operators';
import { JSONAPIListResponse, BackendMatchAttributes, BackendMatchListResponse } from '@mmoaig/mmoaig-core';

@Component({
  selector: 'mmo-match-list',
  templateUrl: './match-list.component.html',
  styleUrls: ['./match-list.component.css']
})
export class MatchListComponent implements OnInit {
  public matches: Observable<BackendMatchListResponse>;

  constructor(private route: ActivatedRoute) {
    this.matches = of({data: []});
  }

  ngOnInit() {
    this.matches = this.route.data.pipe(pluck('matches', 'data'));
  }
}
