import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Users } from '../../model';
import { Observable, of } from 'rxjs';
import { ApiService } from '../../core/api.service';

@Injectable({
  providedIn: 'root'
})
export class UserListResolverService implements Resolve<Users> {

  constructor(private api: ApiService) {}

  resolve(): Observable<Users> {
    return this
      .api
      .get<Users>('v1/users');
  }
}
