import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { RockPaperScissorsRoutingModule } from './rock-paper-scissors-routing.module';
import { RockPaperScissorsMatchRunnerComponent } from './rock-paper-scissors-match-runner/rock-paper-scissors-match-runner.component';

@NgModule({
  imports: [
    CommonModule,
    RockPaperScissorsRoutingModule
  ],
  declarations: [RockPaperScissorsMatchRunnerComponent]
})
export class RockPaperScissorsModule { }
