import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { Bots } from '../../../model';
import { ActivatedRoute } from '@angular/router';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'mmo-bot-list',
  templateUrl: './bot-list.component.html',
  styleUrls: ['./bot-list.component.css']
})
export class BotListComponent implements OnInit {
  public bots: Observable<Bots>;

  constructor(private route: ActivatedRoute) {
    this.bots = of([]);
  }

  ngOnInit() {
    this.bots = this.route.data.pipe(pluck('bots', 'data'));
  }

}
