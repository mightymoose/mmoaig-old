import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MatchListComponent } from './match-list/match-list.component';
import { MatchListResolverService } from './match-list-resolver.service';
import { MatchDetailsComponent } from './match-details/match-details.component';
import { MatchDetailsResolverService } from './match-details-resolver.service';
import { MatchEditComponent } from './match-edit/match-edit.component';
import { NextMatchResolverService } from './next-match-resolver.service';
import { NextMatchComponent } from './next-match/next-match.component';

const routes: Routes = [{
  path: '',
  component: MatchListComponent,
  resolve: {
    matches: MatchListResolverService
  }
}, {
  path: 'next',
  component: NextMatchComponent,
  resolve: {
    match: NextMatchResolverService
  }
}, {
  path: ':id',
  resolve: {
    match: MatchDetailsResolverService
  },
  children: [{
    path: '',
    component: MatchDetailsComponent
  }, {
    path: 'edit',
    component: MatchEditComponent
  }]

}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MatchesRoutingModule { }
