import { GithubRepositoriesModule } from './github-repositories.module';

describe('GithubRepositoriesModule', () => {
  let githubRepositoriesModule: GithubRepositoriesModule;

  beforeEach(() => {
    githubRepositoriesModule = new GithubRepositoriesModule();
  });

  it('should create an instance', () => {
    expect(githubRepositoriesModule).toBeTruthy();
  });
});
