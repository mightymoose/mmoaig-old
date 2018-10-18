import { Injectable, Inject } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent, HttpResponse } from '@angular/common/http';
import { TransferState, makeStateKey, StateKey } from '@angular/platform-browser';
import { Observable, of } from 'rxjs';
import { environment } from 'src/environments/environment.prod';

@Injectable({
  providedIn: 'root'
})
export class BrowserStateInterceptorService implements HttpInterceptor {

  constructor(private transferState: TransferState) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    if (req.method !== 'GET') {
      return next.handle(req);
    }

    const stateKey: StateKey<any> = makeStateKey(req.url.replace(environment.apiBase, ''));
    const storedResponse: string | null = this.transferState.get(stateKey, null);
    this.transferState.remove(stateKey);

    if (storedResponse) {
      const response = new HttpResponse({ body: storedResponse, status: 200 });
      return of(response);
    }

    return next.handle(req);
  }
}
