import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [{
  path: 'bots',
  loadChildren: './bots/bots.module#BotsModule'
}, {
  path: 'github-repositories',
  loadChildren: './github-repositories/github-repositories.module#GithubRepositoriesModule'
}, {
  path: 'users',
  loadChildren: './users/users.module#UsersModule'
}, {
  path: 'github-users',
  loadChildren: './github-users/github-users.module#GithubUsersModule'
}, {
  path: 'matches',
  loadChildren: './matches/matches.module#MatchesModule'
}];

@NgModule({
  imports: [
    RouterModule.forChild(routes)
  ],
  exports: [RouterModule]
})
export class AdministrationRoutingModule { }
