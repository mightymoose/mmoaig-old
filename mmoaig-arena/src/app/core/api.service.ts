import { Injectable, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { API_BASE } from './injection_tokens';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  constructor(private http: HttpClient, @Inject(API_BASE) private apiBase: string) { }

  get<T>(url: string, options = {}): Observable<T> {
    return this.http.get<T>(`${this.apiBase}${url}`, options);
  }
}
