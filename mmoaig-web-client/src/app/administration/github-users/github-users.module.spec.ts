import { GithubUsersModule } from './github-users.module';

describe('GithubUsersModule', () => {
  let githubUsersModule: GithubUsersModule;

  beforeEach(() => {
    githubUsersModule = new GithubUsersModule();
  });

  it('should create an instance', () => {
    expect(githubUsersModule).toBeTruthy();
  });
});
