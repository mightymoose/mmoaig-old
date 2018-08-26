import { browser, $$, $, ElementFinder } from 'protractor';

export class NextMatch {
    static async load(): Promise<any> {
        return browser.get('/administration/matches/next');
    }

    static get pendingMatchElement(): ElementFinder {
        return $('.pending-match');
    }

    static get noPendingMatchElement(): ElementFinder {
        return $('.no-pending-match');
    }

    static async id(): Promise<any> {
        return await $('.match-id').getText();
    }

    static async status(): Promise<any> {
        return await $('.match-status').getText();
    }

    static async type(): Promise<any> {
        return await $('.match-type').getText();
    }

    static async botIDs(): Promise<any> {
        return await $$('.bot-id').getText();
    }

    static async botPaths(): Promise<any> {
        return await $$('.bot-path').getText();
    }

    static editLink(): ElementFinder {
        return $('.edit-link');
    }
}

