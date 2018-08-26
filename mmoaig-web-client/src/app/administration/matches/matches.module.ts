import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MatchesRoutingModule } from './matches-routing.module';
import { MatchListComponent } from './match-list/match-list.component';
import { MatchDetailsComponent } from './match-details/match-details.component';
import { MatchEditComponent } from './match-edit/match-edit.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NextMatchComponent } from './next-match/next-match.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatchesRoutingModule
  ],
  declarations: [MatchListComponent, MatchDetailsComponent, MatchEditComponent, NextMatchComponent]
})
export class MatchesModule { }
