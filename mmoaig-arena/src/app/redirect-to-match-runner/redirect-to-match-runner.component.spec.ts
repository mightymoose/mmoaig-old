import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RedirectToMatchRunnerComponent } from './redirect-to-match-runner.component';

describe('RedirectToMatchRunnerComponent', () => {
  let component: RedirectToMatchRunnerComponent;
  let fixture: ComponentFixture<RedirectToMatchRunnerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RedirectToMatchRunnerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RedirectToMatchRunnerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
