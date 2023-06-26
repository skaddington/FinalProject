import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Park } from '../models/park';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class ParkService {
  private url = environment.baseUrl + 'api/parks';

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<Park[]> {
    return this.http.get<Park[]>(this.url).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error('ParkService.index(): error retrieving Parks: ' + err)
          );
        })
      );
  }

  show(parkId: number): Observable<Park> {
    return this.http
      .get<Park>(this.url + '/' + parkId)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error('ParkService.index(): error retrieving Park: ' + err)
          );
        })
      );
  }

  update(park: Park): Observable<Park> {
    return this.http
      .put<Park>(this.url + '/' + park.id, park, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkService.update(): error updating Park: ' + err)
          );
        })
      );
  }

}
