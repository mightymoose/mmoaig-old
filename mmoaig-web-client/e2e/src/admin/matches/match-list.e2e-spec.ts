import { MatchList } from './match-list.po';
import { browser } from 'protractor';

describe('/administration/matches', () => {
    beforeEach(() => MatchList.load());

    it('links to the next match details page');

    it('links to the match details page', async () => {
        await MatchList.detailsLinks().first().click();
        expect(browser.getCurrentUrl()).toContain('/administration/matches/1');
    });

    it('displays the first page of match statuses', async () => {
        const usernames: string[] = await MatchList.statuses();
        expect(usernames).toEqual([
            'MatchPending',
            'MatchInProgress',
            'MatchComplete',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled',
            'MatchCancelled'
        ]);
    });

    it('displays the first page of match ids', async () => {
        const ids: string[] = await MatchList.ids();
        expect(ids).toEqual([
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            '10',
            '11',
            '12',
            '13',
            '14',
            '15',
            '16',
            '17',
            '18',
            '19',
            '20',
            '21',
            '22',
            '23',
            '24',
            '25'
        ]);
    });

    it('displays the first page of match ids', async () => {
        const matchTypes: string[] = await MatchList.matchTypes();
        expect(matchTypes).toEqual([
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors',
            'RockPaperScissors'
        ]);
    });
});

