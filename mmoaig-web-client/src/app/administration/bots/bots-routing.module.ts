import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { BotListComponent } from './bot-list/bot-list.component';
import { BotListResolverService } from './bot-list-resolver.service';
import { BotSourceComponent } from './bot-source/bot-source.component';
import { BotSourceResolverService } from './bot-source-resolver.service';

const routes: Routes = [{
  path: '',
  component: BotListComponent,
  resolve: {
    bots: BotListResolverService
  }
}, {
  path: ':id/source',
  component: BotSourceComponent,
  resolve: {
    source: BotSourceResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class BotsRoutingModule { }
