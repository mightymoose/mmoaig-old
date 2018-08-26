import { MatchesModule } from './matches.module';

describe('MatchesModule', () => {
  let matchesModule: MatchesModule;

  beforeEach(() => {
    matchesModule = new MatchesModule();
  });

  it('should create an instance', () => {
    expect(matchesModule).toBeTruthy();
  });
});
