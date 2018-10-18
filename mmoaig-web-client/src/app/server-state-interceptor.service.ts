import { Injectable, Inject } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent, HttpResponse } from '@angular/common/http';
import { TransferState, makeStateKey, StateKey } from '@angular/platform-browser';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { environment } from '../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ServerStateInterceptorService implements HttpInterceptor {

  constructor(private transferState: TransferState) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(req).pipe(tap(event => {
      if (event instanceof HttpResponse) {
        this.transferState.set(this.stateKey(req.url), event.body);
      }
    }));
  }

  private stateKey(url: string): StateKey<any> {
    return makeStateKey(url.replace(environment.apiBase, ''));
  }
}
