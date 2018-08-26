import { browser, $$ } from 'protractor';

export class AdminGithubRepositoryList {
    static async load(): Promise<any> {
        return browser.get('/administration/github-repositories');
    }

    static async names(): Promise<any> {
        return await $$('.name').getText();
    }

   static async ids(): Promise<any> {
        return await $$('.id').getText();
    }

   static async githubUserIds(): Promise<any> {
        return await $$('.github-user-id').getText();
    }
}
