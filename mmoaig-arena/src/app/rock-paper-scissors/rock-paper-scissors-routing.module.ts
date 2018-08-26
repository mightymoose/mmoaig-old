import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RockPaperScissorsMatchRunnerComponent } from './rock-paper-scissors-match-runner/rock-paper-scissors-match-runner.component';
import { RockPaperScissorsMatchResolverService } from './rock-paper-scissors-match-resolver.service';

const routes: Routes = [{
  path: ':id',
  component: RockPaperScissorsMatchRunnerComponent,
  resolve: {
    match: RockPaperScissorsMatchResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RockPaperScissorsRoutingModule { }
