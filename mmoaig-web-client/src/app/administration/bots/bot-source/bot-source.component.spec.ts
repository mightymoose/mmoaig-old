import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { BotSourceComponent } from './bot-source.component';

describe('BotSourceComponent', () => {
  let component: BotSourceComponent;
  let fixture: ComponentFixture<BotSourceComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ BotSourceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BotSourceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
