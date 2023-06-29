import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { RegisterComponent } from './components/register/register.component';
import { ParkComponent } from './components/park/park.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { UserComponent } from './components/user/user.component';
import { TeamComponent } from './components/team/team.component';
import { GalleryComponent } from './components/gallery/gallery.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'parks', component: ParkComponent },
  { path: 'parks/:id', component: ParkComponent },
  { path: 'users', component: UserComponent },
  { path: 'users/:id', component: UserComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'team', component: TeamComponent },
  { path: 'gallery', component: GalleryComponent },
  //   { path: 'login', component: LoginComponent },   //Use when login NOT nested in the Navbar
  { path: '**', component: NotFoundComponent }, //page not found route
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule],
})
export class AppRoutingModule {}
