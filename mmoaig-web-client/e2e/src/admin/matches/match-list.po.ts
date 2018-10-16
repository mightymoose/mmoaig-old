import { browser, $$, ElementArrayFinder } from 'protractor';

export class MatchList {
    static async load(): Promise<any> {
        return browser.get('/administration/matches');
    }

    static async statuses(): Promise<any> {
        return await $$('.status').getText();
    }

   static async ids(): Promise<any> {
        return await $$('.id').getText();
    }

    static detailsLinks(): ElementArrayFinder {
        return $$('.details-link');
    }

    static async matchTypes(): Promise<any> {
        return $$('.type').getText();
    }
}

