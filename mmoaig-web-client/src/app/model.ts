export interface User {
    id: number;
    attributes: {
        username: string;
        active: boolean;
    };
}

export type Users = User[];
export interface GithubRepository {
    id: number;
    attributes: {
        name: string;
        githubUserId: number;
    };
}

export type GithubRepositories = GithubRepository[];

export interface GithubUser {
    id: number;
    attributes: {
        username: string;
        userId: number;
    };
}

export type GithubUsers = GithubUser[];

export interface Bot {
    id: number;
    attributes: {
        path: string;
        githubRepositoryId: number;
    };
}

export type Bots = Bot[];

type MatchStatus = 'MatchComplete' | 'MatchInProgress' | 'MatchComplete' | 'MatchCanceled';
type MatchType = 'RockPaperScissors';

export interface Match {
    id: number;
    attributes: {
        status: MatchStatus;
        type: MatchType;
    };
}

export type Matches = Match[];
