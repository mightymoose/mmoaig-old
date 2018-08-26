import { AdminGithubUserList } from './github-user-list.po';

describe('/administration/github-repositories', () => {
    beforeEach(() => AdminGithubUserList.load());

    it('displays the first page of github repository full names', async () => {
        const usernames: string[] = await AdminGithubUserList.usernames();
        expect(usernames).toEqual([
            'mightymoose',
            'github_user #2',
            'github_user #3',
            'github_user #4',
            'github_user #5',
            'github_user #6',
            'github_user #7',
            'github_user #8',
            'github_user #9',
            'github_user #10',
            'github_user #11',
            'github_user #12',
            'github_user #13',
            'github_user #14',
            'github_user #15',
            'github_user #16',
            'github_user #17',
            'github_user #18',
            'github_user #19',
            'github_user #20',
            'github_user #21',
            'github_user #22',
            'github_user #23',
            'github_user #24',
            'github_user #25',
        ]);
    });

    it('displays the first page of github repository ids', async () => {
        const ids: string[] = await AdminGithubUserList.ids();
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
