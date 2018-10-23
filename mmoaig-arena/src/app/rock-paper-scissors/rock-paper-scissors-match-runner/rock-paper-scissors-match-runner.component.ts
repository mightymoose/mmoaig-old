import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { pluck, map, flatMap, filter } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { BackendService, MatchEndpoint, BackendMatchResponse } from '@mmoaig/mmoaig-core';
import { BotSourcePathService } from '../../core/bot-source-path.service';

@Component({
  selector: 'arena-rock-paper-scissors-match-runner',
  templateUrl: './rock-paper-scissors-match-runner.component.html',
  styleUrls: ['./rock-paper-scissors-match-runner.component.css']
})
export class RockPaperScissorsMatchRunnerComponent implements OnInit {
  constructor(
    private route: ActivatedRoute,
    private botSourcePath: BotSourcePathService,
    private router: Router,
    private backend: BackendService) {}

  ngOnInit() {
    this.route.data.pipe(
      pluck('match', 'data', 'relationships', 'participants', 'data'),
      map((bots: any) => bots.map(bot => this.botSourcePath.botSourcePath(bot.id))),
      map(botPaths => botPaths.map(botPath => new Worker(botPath))),
      flatMap(() => this.createRound()),
      flatMap(() => this.checkForMatchCompletion()),
      filter(t => t)
    ).subscribe(() => this.router.navigate(['match-complete']));
  }

  checkForMatchCompletion(): Observable<boolean> {
    return this.backend
      .get(MatchEndpoint, 1)
      .pipe(
        map((match: BackendMatchResponse) => match.data.attributes.status === 'MatchComplete')
      );
  }

  // TODO: This is the good stuff here
  createRound(): Observable<any> {
    return this.backend
      .update(MatchEndpoint, 1, {status: 'MatchComplete'});
  }
}
