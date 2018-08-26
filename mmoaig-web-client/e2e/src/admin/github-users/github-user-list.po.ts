import { browser, $$ } from 'protractor';

export class AdminGithubUserList {
    static async load(): Promise<any> {
        return browser.get('/administration/github-users');
    }

    static async usernames(): Promise<any> {
        return await $$('.username').getText();
    }

   static async ids(): Promise<any> {
        return await $$('.id').getText();
    }

   static async userIds(): Promise<any> {
        return await $$('.user-id').getText();
    }
}
