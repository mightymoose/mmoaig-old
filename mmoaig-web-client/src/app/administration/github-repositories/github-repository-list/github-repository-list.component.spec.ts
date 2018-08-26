import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { GithubRepositoryListComponent } from './github-repository-list.component';

describe('GithubRepositoryListComponent', () => {
  let component: GithubRepositoryListComponent;
  let fixture: ComponentFixture<GithubRepositoryListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ GithubRepositoryListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GithubRepositoryListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
