import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GithubUsersRoutingModule } from './github-users-routing.module';
import { GithubUserListComponent } from './github-user-list/github-user-list.component';

@NgModule({
  imports: [
    CommonModule,
    GithubUsersRoutingModule
  ],
  declarations: [GithubUserListComponent]
})
export class GithubUsersModule { }
