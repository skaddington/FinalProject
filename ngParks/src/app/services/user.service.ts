import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Park } from '../models/park';
import { AuthService } from './auth.service';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private url = environment.baseUrl + 'api/users';

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

  index(): Observable<User[]> {
    return this.http.get<User[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.index(): error retrieving Users: ' + err)
        );
      })
    );
  }

  show(userId: number): Observable<User> {
    return this.http
      .get<User>(this.url + '/' + userId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error('UserService.index(): error retrieving User: ' + err)
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

  update(user: User): Observable<User> {
    return this.http
      .put<User>(this.url + '/' + user.id, user, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('UserService.update(): error updating User: ' + err)
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
