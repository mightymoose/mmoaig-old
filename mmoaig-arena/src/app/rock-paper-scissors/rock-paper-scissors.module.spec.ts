import { RockPaperScissorsModule } from './rock-paper-scissors.module';

describe('RockPaperScissorsModule', () => {
  let rockPaperScissorsModule: RockPaperScissorsModule;

  beforeEach(() => {
    rockPaperScissorsModule = new RockPaperScissorsModule();
  });

  it('should create an instance', () => {
    expect(rockPaperScissorsModule).toBeTruthy();
  });
});
