import { MatchDetails } from './match-details.po';
import { browser } from 'protractor';

describe('/administration/matches/:id', () => {
    beforeEach(async () => {
        await MatchDetails.load(1);
    });

    it('links to the match edit page', async () => {
        await MatchDetails.editLink().click();
        expect(browser.getCurrentUrl()).toContain('/administration/matches/1/edit');
    });

    it('shows the match id', async () => {
        const id: string = await MatchDetails.id();
        expect(id).toBe('1');
    });

    it('shows the match status', async () => {
        const status: string = await MatchDetails.status();
        expect(status).toBe('MatchPending');
    });

    it('shows the match type', async () => {
        const type: string = await MatchDetails.type();
        expect(type).toBe('RockPaperScissors');
    });

    it('shows the participant ids', async () => {
        const botIDs: string[] = await MatchDetails.botIDs();
        expect(botIDs).toEqual(['2', '3']);
    });

    it('shows the participant paths', async () => {
        const paths: string[] = await MatchDetails.botPaths();
        expect(paths).toEqual([
            'rock-paper-scissors/paper-bot.js',
            'rock-paper-scissors/scissors-bot.js'
        ]);
    });
});
