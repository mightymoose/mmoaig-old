import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RedirectToMatchRunnerComponent } from './redirect-to-match-runner/redirect-to-match-runner.component';
import { NextMatchResolverService } from './core/next-match-resolver.service';
import { MatchCompleteComponent } from './match-complete/match-complete.component';

const routes: Routes = [{
  path: 'match-complete',
  component: MatchCompleteComponent
}, {
  path: 'rock-paper-scissors',
  loadChildren: './rock-paper-scissors/rock-paper-scissors.module#RockPaperScissorsModule'
}, {
  path: '',
  component: RedirectToMatchRunnerComponent,
  resolve: {
    nextMatch: NextMatchResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
