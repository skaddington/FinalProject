import { NgPipesModule } from 'ngx-pipes';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { NavbarComponent } from './components/navbar/navbar.component';
import { AuthService } from './services/auth.service';
import { HomeComponent } from './components/home/home.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { ParkComponent } from './components/park/park.component';
import { StatePipe } from './pipes/state.pipe';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { UserComponent } from './components/user/user.component';
import { AddToFavoritesComponent } from './components/add-to-favorites/add-to-favorites.component';
import { RemoveFromFavoritesComponent } from './components/remove-from-favorites/remove-from-favorites.component';
import { FooterComponent } from './components/footer/footer.component';
import { TeamComponent } from './components/team/team.component';
import { AttractionComponent } from './components/attraction/attraction.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ParkCommentComponent } from './components/park-comment/park-comment.component';
import { GalleryComponent } from './components/gallery/gallery.component';
import { ParkRatingComponent } from './components/park-rating/park-rating.component';
import { AverageParkRatingPipe } from './pipes/average-park-rating.pipe';
import { DatePipe } from '@angular/common';
import { AttractionCommentComponent } from './components/attraction-comment/attraction-comment.component';

@NgModule({
  declarations: [
    AppComponent,
    AttractionComponent,
    NavbarComponent,
    HomeComponent,
    RegisterComponent,
    LoginComponent,
    LogoutComponent,
    ParkComponent,
    StatePipe,
    NotFoundComponent,
    UserComponent,
    AddToFavoritesComponent,
    RemoveFromFavoritesComponent,
    FooterComponent,
    TeamComponent,
    ParkCommentComponent,
    GalleryComponent,
    ParkRatingComponent,
    AverageParkRatingPipe,
    AttractionCommentComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgbModule,
    NgPipesModule
  ],
  providers: [AuthService, StatePipe, DatePipe],
  bootstrap: [AppComponent]
})
export class AppModule { }
