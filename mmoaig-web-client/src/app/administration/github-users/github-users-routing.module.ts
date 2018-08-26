import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { GithubUserListComponent } from './github-user-list/github-user-list.component';
import { GithubUserListResolverService } from './github-user-list-resolver.service';

const routes: Routes = [{
  path: '',
  component: GithubUserListComponent,
  resolve: {
    githubUsers: GithubUserListResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GithubUsersRoutingModule { }
