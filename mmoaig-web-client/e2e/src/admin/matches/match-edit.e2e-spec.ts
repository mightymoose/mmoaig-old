import { browser } from 'protractor';
import { MatchEdit } from './match-edit.po';
import { MatchDetails } from './match-details.po';

describe('/administration/matches/:id/edit', () => {
    beforeEach(async () => {
        await MatchEdit.load(10);
    });

    it('links to the match details page', async () => {
        await MatchEdit.cancelLink().click();
        expect(browser.getCurrentUrl()).toMatch(/\/administration\/matches\/10$/);
    });

    it('loads the match status', async () => {
        expect(await MatchEdit.matchStatus()).toBe('MatchCancelled');
    });

    describe('when submitting', () => {
        beforeEach(async () => {
            await MatchEdit.selectMatchStatus('MatchComplete');
            await MatchEdit.submitButton().click();
        });

        afterEach(async () => {
            await MatchEdit.load(10);
            await MatchEdit.selectMatchStatus('MatchCancelled');
            await MatchEdit.submitButton().click();
        });

        it('redirects to the match details page', () => {
            expect(browser.getCurrentUrl()).toMatch(/\/administration\/matches\/10$/);
        });

        it('updates the status', async () => {
            await MatchDetails.load(10);
            expect(MatchDetails.status()).toBe('MatchComplete');
        });
    });
});
