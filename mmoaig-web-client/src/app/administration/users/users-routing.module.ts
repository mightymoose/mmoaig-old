import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { UserListComponent } from './user-list/user-list.component';
import { UserListResolverService } from './user-list-resolver.service';

const routes: Routes = [{
  path: '',
  component: UserListComponent,
  resolve: {
    users: UserListResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UsersRoutingModule { }
