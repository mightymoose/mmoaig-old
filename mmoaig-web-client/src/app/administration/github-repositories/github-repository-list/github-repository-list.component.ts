import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { of, Observable } from 'rxjs';
import { pluck } from 'rxjs/operators';
import { JSONAPIListResponse, BackendGithubRepositoryAttributes, BackendGithubRepositoryListResponse } from '@mmoaig/mmoaig-core';

@Component({
  selector: 'mmo-github-repository-list',
  templateUrl: './github-repository-list.component.html',
  styleUrls: ['./github-repository-list.component.css']
})
export class GithubRepositoryListComponent implements OnInit {
  public githubRepositories: Observable<BackendGithubRepositoryListResponse>;

  constructor(private route: ActivatedRoute) {
    this.githubRepositories = of({data: []});
  }

  ngOnInit() {
    this.githubRepositories = this.route.data.pipe(pluck('githubRepositories', 'data'));
  }

}
