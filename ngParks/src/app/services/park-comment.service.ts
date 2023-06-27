import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { ParkComment } from '../models/park-comment';
import { environment } from 'src/environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Park } from '../models/park';

@Injectable({
  providedIn: 'root'
})
export class ParkCommentService {
  private url = environment.baseUrl + 'api/parks';
  constructor(
    private http: HttpClient,
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

  addComment(park: Park, comment:ParkComment): Observable<ParkComment> {
    return this.http
      .post<ParkComment>(this.url + '/' + park.id + "/comments" , comment, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkCommntService.update(): error adding ParkComment: ' + err)
          );
        })
      );
  }

  addReply(park: Park, cid:number, reply:ParkComment): Observable<ParkComment> {
    return this.http
      .post<ParkComment>(this.url + '/' + park.id + "/comments/"+ cid , reply, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkCommntService.update(): error adding ReplyParkComment: ' + err)
          );
        })
      );
  }



}
