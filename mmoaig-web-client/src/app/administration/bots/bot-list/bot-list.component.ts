import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { pluck } from 'rxjs/operators';
import { BackendBot, JSONAPIListResponse, BackendBotListResponse } from '@mmoaig/mmoaig-core';

@Component({
  selector: 'mmo-bot-list',
  templateUrl: './bot-list.component.html',
  styleUrls: ['./bot-list.component.css']
})
export class BotListComponent implements OnInit {
  public bots: Observable<BackendBotListResponse>;

  constructor(private route: ActivatedRoute) {
    this.bots = of({data: []});
  }

  ngOnInit() {
    this.bots = this.route.data.pipe(pluck('bots', 'data'));
  }

}
