import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class MatchRunnerRouteService {
  matchRunnerRoute(s: {id: number, attributes: {type: string}}): any[] {
    const formatters = {
      'RockPaperScissors': (id: number) => ['/', 'rock-paper-scissors', 1]
    };
    const defaultFormatter = (id: number) => ['/', 'error'];
    const formatter = formatters[s.attributes.type] || defaultFormatter;
    return formatter(s.id);
  }
}
