import { browser, $$ } from 'protractor';

export class AdministrationUserList {
    static async load(): Promise<any> {
        return browser.get('/administration/users');
    }

    static async usernames(): Promise<any> {
        return await $$('.username').getText();
    }

    static async ids(): Promise<any> {
        return await $$('.id').getText();
    }

    static async active(): Promise<any> {
        return await $$('.active').getText();
    }
}
