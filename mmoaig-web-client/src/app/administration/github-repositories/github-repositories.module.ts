import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GithubRepositoriesRoutingModule } from './github-repositories-routing.module';
import { GithubRepositoryListComponent } from './github-repository-list/github-repository-list.component';

@NgModule({
  imports: [
    CommonModule,
    GithubRepositoriesRoutingModule
  ],
  declarations: [GithubRepositoryListComponent]
})
export class GithubRepositoriesModule { }
