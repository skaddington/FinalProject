import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Park } from '../models/park';
import { AuthService } from './auth.service';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private url = environment.baseUrl + 'api/users';
  private selectedUserSubject: BehaviorSubject<User | null> = new BehaviorSubject<User | null>(null);

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

  toggle(user: User): Observable<User> {
    return this.http
      .delete<User>(this.url + '/' + user.id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('UserService.update(): error updating User: ' + err)
          );
        })
      );
  }

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

  addFavoritePark(user: User, pid:number): Observable<User> {
    return this.http
      .put<User>(this.url + '/' + pid + "/parks", user, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('UserService.update(): error Adding Park to User: ' + err)
          );
        })
      );
  }

  removeFavoritePark(user: User, pid:number): Observable<User> {
    // console.log(pid);
    return this.http
      .put<User>(this.url + "/parks/" + pid, user, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('UserService.update(): error Remove Park from User: ' + err)
          );
        })
      );
  }

  setSelectedUser(user: User | null) {
    this.selectedUserSubject.next(user);
  }

  getSelectedUser(): Observable<User | null> {
    return this.selectedUserSubject.asObservable();
  }

}
