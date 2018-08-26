import { Component, OnInit } from '@angular/core';
import { GithubRepositories } from '../../../model';
import { ActivatedRoute } from '@angular/router';
import { of, Observable } from 'rxjs';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'mmo-github-repository-list',
  templateUrl: './github-repository-list.component.html',
  styleUrls: ['./github-repository-list.component.css']
})
export class GithubRepositoryListComponent implements OnInit {
  public githubRepositories: Observable<GithubRepositories>;

  constructor(private route: ActivatedRoute) {
    this.githubRepositories = of([]);
  }

  ngOnInit() {
    this.githubRepositories = this.route.data.pipe(pluck('githubRepositories', 'data'));
  }

}
