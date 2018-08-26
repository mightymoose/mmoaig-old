import { browser, $$, ElementArrayFinder } from 'protractor';

export class AdminBotList {
    static async load(): Promise<any> {
        return browser.get('/administration/bots');
    }

    static async githubRepositoryIds(): Promise<any> {
        return await $$('.github-repository-id').getText();
    }

   static async ids(): Promise<any> {
        return await $$('.id').getText();
    }

   static async paths(): Promise<any> {
        return await $$('.path').getText();
    }

   static botSourceLinks(): ElementArrayFinder {
        return $$('.source-link');
    }
}
