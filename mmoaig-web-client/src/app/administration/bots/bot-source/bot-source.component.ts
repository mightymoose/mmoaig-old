import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { ActivatedRoute, Data } from '@angular/router';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'mmo-bot-source',
  templateUrl: './bot-source.component.html',
  styleUrls: ['./bot-source.component.css']
})
export class BotSourceComponent implements OnInit {
  public botSource: Observable<string>;

  constructor(private route: ActivatedRoute) {
    this.botSource = of('');
  }

  ngOnInit() {
    this.botSource = this.route.data.pipe(pluck('source'));
  }

}
