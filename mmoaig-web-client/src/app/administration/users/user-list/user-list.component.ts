import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { Users } from '../../../model';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'mmo-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit {
  public users: Observable<Users>;

  constructor(private route: ActivatedRoute) {
    this.users = of([]);
  }

  ngOnInit() {
    this.users = this.route.data.pipe(pluck('users', 'data'));
  }

}
