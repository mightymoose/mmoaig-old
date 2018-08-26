import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { GithubRepositoryListComponent } from './github-repository-list/github-repository-list.component';
import { GithubRepositoryListResolverService } from './github-repository-list-resolver.service';

const routes: Routes = [{
  path: '',
  component: GithubRepositoryListComponent,
  resolve: {
    githubRepositories: GithubRepositoryListResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GithubRepositoriesRoutingModule { }
