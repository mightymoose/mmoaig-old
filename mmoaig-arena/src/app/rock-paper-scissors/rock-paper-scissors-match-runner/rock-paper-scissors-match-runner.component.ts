import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { pluck, map } from 'rxjs/operators';
import { BotSourcePathService } from '../../core/bot-source-path.service';

@Component({
  selector: 'arena-rock-paper-scissors-match-runner',
  templateUrl: './rock-paper-scissors-match-runner.component.html',
  styleUrls: ['./rock-paper-scissors-match-runner.component.css']
})
export class RockPaperScissorsMatchRunnerComponent implements OnInit {
  constructor(private route: ActivatedRoute, private botSourcePath: BotSourcePathService) { 
  }

  ngOnInit() {
    this.route.data.pipe(
      pluck('match', 'relationships', 'participants', 'data'),
      map((bots: any) => bots.map(bot => this.botSourcePath.botSourcePath(bot.id))),
      map(botPaths => botPaths.map(botPath => new Worker(botPath))),
    ).subscribe(console.log);
  }

}
