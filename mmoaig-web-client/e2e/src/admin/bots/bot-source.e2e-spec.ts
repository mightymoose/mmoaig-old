import { AdminBotSource } from './bot-source.po';

describe('/administration/bots', () => {
    beforeEach(() => AdminBotSource.load(1));

    it('displays the bot source', async () => {
        const source: string[] = await AdminBotSource.source();
        expect(source.map(s => s.trim())).toEqual(['function takeTurn(round) {\n    round.chooseRock();\n}']);
    });
});
