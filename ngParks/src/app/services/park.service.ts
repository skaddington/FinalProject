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
    // private datePipe: DatePipe,
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
      .get<Park>(this.url + '/' + parkId, this.getHttpOptions())
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

  // create(newTodo: Todo): Observable<Todo> {
  //   return this.http.post<Todo>(this.url, newTodo, this.getHttpOptions()).pipe(
  //     catchError((err: any) => {
  //       console.error(err);
  //       return throwError(
  //         () => new Error('TodoService.create(): error creating Todo: ' + err)
  //       );
  //     })
  //   );
  // }

  update(park: Park): Observable<Park> {
    // if (todo.completed) {
    //   todo.completeDate = this.datePipe.transform(Date.now(), 'shortDate');
    // } else {
    //   todo.completeDate = '';
    // }
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

  // destroy(todoId: number): Observable<void> {
  //   return this.http
  //     .delete<void>(this.url + '/' + todoId, this.getHttpOptions())
  //     .pipe(
  //       catchError((err: any) => {
  //         console.error(err);
  //         return throwError(
  //           () =>
  //             new Error('TodoService.destroy(): error deleting todo: ' + err)
  //         );
  //       })
  //     );
  // }
}
