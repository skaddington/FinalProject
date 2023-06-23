import { StatePipe } from './../pipes/state.pipe';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { State } from '@popperjs/core';

@Injectable({
  providedIn: 'root'
})
export class StateService {

  private url = environment.baseUrl + 'api/state'

  constructor(
    private http: HttpClient,
    private statePipe: StatePipe,
    private auth: AuthService
  ) { }

    getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

index(): Observable<State[]> {
   return this.http.get<State[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching state list.');
        return throwError(
          () =>
          new Error(
            "StateService.index(): error " + err)
        );
      })
    );
  }

    public show(stateId: number): Observable<State> {

    return this.http.get<State>(this.url + '/' + stateId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching state.');
        return throwError(
          () =>
          new Error(
            "StateService.show(): error " + err)
        );
      })
    );
  }
}
