import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { MatchRunnerRouteService } from '../core/match-runner-route.service';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'arena-redirect-to-match-runner',
  templateUrl: './redirect-to-match-runner.component.html',
  styleUrls: ['./redirect-to-match-runner.component.css']
})
export class RedirectToMatchRunnerComponent implements OnInit {

  constructor(private matchRunnerRoute: MatchRunnerRouteService, private router: Router, private route: ActivatedRoute) { }

  ngOnInit() {
    this.route.data
      .pipe(pluck('nextMatch', 'data'))
      .subscribe((d: any) => {
        this.router.navigate(this.matchRunnerRoute.matchRunnerRoute(d));
      });
  }
}
