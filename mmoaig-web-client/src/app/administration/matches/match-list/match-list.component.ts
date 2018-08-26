import { Component, OnInit } from '@angular/core';
import { of, Observable } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { Matches } from '../../../model';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'mmo-match-list',
  templateUrl: './match-list.component.html',
  styleUrls: ['./match-list.component.css']
})
export class MatchListComponent implements OnInit {
  public matches: Observable<Matches>;

  constructor(private route: ActivatedRoute) {
    this.matches = of([]);
  }

  ngOnInit() {
    this.matches = this.route.data.pipe(pluck('matches', 'data'));
  }
}
