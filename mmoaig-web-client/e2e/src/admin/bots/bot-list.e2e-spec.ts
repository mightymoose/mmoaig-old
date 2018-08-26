import { AdminBotList } from './bot-list.po';
import { browser } from 'protractor';

describe('/administration/bots', () => {
    beforeEach(() => AdminBotList.load());

    it('links to the bot source', async () => {
        await AdminBotList.botSourceLinks().first().click();
        expect(browser.getCurrentUrl()).toContain('/administration/bots/1/source');
    });

    it('displays the first page of bot paths', async () => {
        const paths: string[] = await AdminBotList.paths();
        expect(paths).toEqual([
            'rock-paper-scissors/rock-bot.js',
            'rock-paper-scissors/paper-bot.js',
            'rock-paper-scissors/scissors-bot.js',
            'bot_path #4',
            'bot_path #5',
            'bot_path #6',
            'bot_path #7',
            'bot_path #8',
            'bot_path #9',
            'bot_path #10',
            'bot_path #11',
            'bot_path #12',
            'bot_path #13',
            'bot_path #14',
            'bot_path #15',
            'bot_path #16',
            'bot_path #17',
            'bot_path #18',
            'bot_path #19',
            'bot_path #20',
            'bot_path #21',
            'bot_path #22',
            'bot_path #23',
            'bot_path #24',
            'bot_path #25',
        ]);
    });

    it('displays the first page of bot ids', async () => {
        const ids: string[] = await AdminBotList.ids();
        expect(ids).toEqual([
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            '10',
            '11',
            '12',
            '13',
            '14',
            '15',
            '16',
            '17',
            '18',
            '19',
            '20',
            '21',
            '22',
            '23',
            '24',
            '25'
        ]);
    });

});
