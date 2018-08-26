import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { GithubUsers } from '../../../model';
import { ActivatedRoute } from '@angular/router';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'mmo-github-user-list',
  templateUrl: './github-user-list.component.html',
  styleUrls: ['./github-user-list.component.css']
})
export class GithubUserListComponent implements OnInit {
  public githubUsers: Observable<GithubUsers>;

  constructor(private route: ActivatedRoute) {
    this.githubUsers = of([]);
  }

  ngOnInit() {
    this.githubUsers = this.route.data.pipe(pluck('githubUsers', 'data'));
  }

}
