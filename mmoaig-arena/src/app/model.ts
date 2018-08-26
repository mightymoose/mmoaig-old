import { Observable } from 'rxjs';

type MatchType = 'rock-paper-scissors';

interface MatchParticipant<T> {
    messages: Observable<string>;
}
