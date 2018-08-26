import { browser, $$ } from 'protractor';

export class AdminBotSource {
    static async load(botId: number): Promise<any> {
        return browser.get(`/administration/bots/${botId}/source`);
    }

    static async source(): Promise<any> {
        return await $$('.bot-source').getText();
    }
}
