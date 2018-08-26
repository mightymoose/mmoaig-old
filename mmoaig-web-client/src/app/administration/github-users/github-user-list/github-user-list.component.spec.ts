import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { GithubUserListComponent } from './github-user-list.component';

describe('GithubUserListComponent', () => {
  let component: GithubUserListComponent;
  let fixture: ComponentFixture<GithubUserListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ GithubUserListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GithubUserListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
