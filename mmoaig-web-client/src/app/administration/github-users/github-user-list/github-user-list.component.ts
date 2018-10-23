import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { pluck } from 'rxjs/operators';
import { JSONAPIListResponse, BackendGithubUserAttributes, BackendUserListResponse } from '@mmoaig/mmoaig-core';

@Component({
  selector: 'mmo-github-user-list',
  templateUrl: './github-user-list.component.html',
  styleUrls: ['./github-user-list.component.css']
})
export class GithubUserListComponent implements OnInit {
  public githubUsers: Observable<BackendUserListResponse>;

  constructor(private route: ActivatedRoute) {
    this.githubUsers = of({data: []});
  }

  ngOnInit() {
    this.githubUsers = this.route.data.pipe(pluck('githubUsers', 'data'));
  }

}
