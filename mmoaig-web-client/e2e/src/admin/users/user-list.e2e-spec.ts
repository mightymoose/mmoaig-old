import { AdministrationUserList } from './user-list.po';
import { async } from '@angular/core/testing';

describe('/administration/users', () => {
    beforeEach(() => AdministrationUserList.load());

    it('displays the first page of usernames', async () => {
        const usernames: string[] = await AdministrationUserList.usernames();
        expect(usernames).toEqual([
            'MightyMoose',
            'User #2',
            'User #3',
            'User #4',
            'User #5',
            'User #6',
            'User #7',
            'User #8',
            'User #9',
            'User #10',
            'User #11',
            'User #12',
            'User #13',
            'User #14',
            'User #15',
            'User #16',
            'User #17',
            'User #18',
            'User #19',
            'User #20',
            'User #21',
            'User #22',
            'User #23',
            'User #24',
            'User #25'
        ]);
    });

    it('displays the first page of user ids', async () => {
        const ids: string[] = await AdministrationUserList.ids();
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

    it('displays the first page of the active flag', async () => {
        const ids: string[] = await AdministrationUserList.active();
        expect(ids).toEqual([
            'true',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false',
            'false'
        ]);
    });
});
