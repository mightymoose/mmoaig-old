import { AdminGithubRepositoryList } from './github-repository-list.po';

describe('/administration/github-repositories', () => {
    beforeEach(() => AdminGithubRepositoryList.load());

    it('displays the first page of github repository full names', async () => {
        const usernames: string[] = await AdminGithubRepositoryList.names();
        expect(usernames).toEqual([
            'bots',
            'fake_repo #2',
            'fake_repo #3',
            'fake_repo #4',
            'fake_repo #5',
            'fake_repo #6',
            'fake_repo #7',
            'fake_repo #8',
            'fake_repo #9',
            'fake_repo #10',
            'fake_repo #11',
            'fake_repo #12',
            'fake_repo #13',
            'fake_repo #14',
            'fake_repo #15',
            'fake_repo #16',
            'fake_repo #17',
            'fake_repo #18',
            'fake_repo #19',
            'fake_repo #20',
            'fake_repo #21',
            'fake_repo #22',
            'fake_repo #23',
            'fake_repo #24',
            'fake_repo #25'
        ]);
    });

    it('displays the first page of github repository ids', async () => {
        const ids: string[] = await AdminGithubRepositoryList.ids();
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
