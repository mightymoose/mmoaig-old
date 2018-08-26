import { Injectable, Inject } from '@angular/core';
import { API_BASE } from './injection_tokens';

@Injectable({
  providedIn: 'root'
})
export class BotSourcePathService {
  constructor(@Inject(API_BASE) private apiBase: string) {}

  botSourcePath(botID: number): string {
    return `${this.apiBase}/v1/bots/${botID}/source`
  }
}
