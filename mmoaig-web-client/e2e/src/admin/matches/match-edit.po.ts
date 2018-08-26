import { browser, $$, $, ElementFinder, element, by } from 'protractor';

export class MatchEdit {
    static async load(matchId: number): Promise<any> {
        return browser.get(`/administration/matches/${matchId}/edit`);
    }

    static async matchStatus(): Promise<any> {
        return $('.match-status option:checked').getText();
    }

    static async selectMatchStatus(text: string): Promise<any> {
        return element(by.cssContainingText('.match-status option', text)).click();
    }

    static cancelLink(): ElementFinder {
        return $('.cancel-link');
    }

    static submitButton(): ElementFinder {
        return $('input[type="submit"]');
    }
}
