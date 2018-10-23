import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { pluck } from 'rxjs/operators';
import { BackendUserListResponse } from '@mmoaig/mmoaig-core';

@Component({
  selector: 'mmo-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit {
  public users: Observable<BackendUserListResponse>;

  constructor(private route: ActivatedRoute) {
    this.users = of({data: []});
  }

  ngOnInit() {
    this.users = this.route.data.pipe(pluck('users', 'data'));
  }

}
