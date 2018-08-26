import { browser } from 'protractor';
import { NextMatch } from './next-match.po';
import { MatchEdit } from './match-edit.po';
import { MatchDetails } from './match-details.po';

describe('/administration/matches/next', () => {
    let nextMatchId: string;

    beforeEach(async () => {
        await NextMatch.load();
        nextMatchId = await NextMatch.id();
    });

    afterEach(async () => {
        await MatchEdit.load(Number(nextMatchId));
        await MatchEdit.selectMatchStatus('MatchPending');
        await MatchEdit.submitButton().click();
    });

    describe('when there is no pending match', () => {

        beforeEach(async () => {
            await MatchEdit.load(Number(nextMatchId));
            await MatchEdit.selectMatchStatus('MatchComplete');
            await MatchEdit.submitButton().click();
        });

        beforeEach(async () => {
            await NextMatch.load();
        });

        it('shows that there is no pending match', () => {
            expect(NextMatch.noPendingMatchElement.isPresent()).toBe(true);
        });

        it('does not show a pending match', () => {
            expect(NextMatch.pendingMatchElement.isPresent()).toBe(false);
        });
    });

    describe('with a pending match', () => {
        it('marks the match as in progress', async () => {
            await MatchDetails.load(Number(nextMatchId));
            expect(MatchDetails.status()).toBe('MatchInProgress');
        });

        it('does not show that there is no next match', () => {
            expect(NextMatch.noPendingMatchElement.isPresent()).toBe(false);
        });

        it('links to the match edit page', async () => {
            await NextMatch.editLink().click();
            expect(browser.getCurrentUrl()).toContain('/administration/matches/1/edit');
        });

        it('shows the match id', async () => {
            const id: string = await NextMatch.id();
            expect(id).toBe('1');
        });

        it('shows the match type', async () => {
            const type: string = await NextMatch.type();
            expect(type).toBe('RockPaperScissors');
        });

        it('shows the match status', async () => {
            const status: string = await NextMatch.status();
            expect(status).toBe('MatchPending');
        });

        it('shows the participant ids', async () => {
            const botIDs: string[] = await NextMatch.botIDs();
            expect(botIDs).toEqual(['2', '3']);
        });

        it('shows the participant paths', async () => {
            const paths: string[] = await NextMatch.botPaths();
            expect(paths).toEqual([
                'rock-paper-scissors/paper-bot.js',
                'rock-paper-scissors/scissors-bot.js'
            ]);
        });
    });
});
