import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { BotsRoutingModule } from './bots-routing.module';
import { BotListComponent } from './bot-list/bot-list.component';
import { BotSourceComponent } from './bot-source/bot-source.component';

@NgModule({
  imports: [
    CommonModule,
    BotsRoutingModule
  ],
  declarations: [BotListComponent, BotSourceComponent]
})
export class BotsModule { }
