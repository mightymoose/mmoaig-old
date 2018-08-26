import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RockPaperScissorsMatchRunnerComponent } from './rock-paper-scissors-match-runner.component';

describe('RockPaperScissorsMatchRunnerComponent', () => {
  let component: RockPaperScissorsMatchRunnerComponent;
  let fixture: ComponentFixture<RockPaperScissorsMatchRunnerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RockPaperScissorsMatchRunnerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RockPaperScissorsMatchRunnerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
