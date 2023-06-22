import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { RegisterComponent } from './components/register/register.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
//  { path: 'about', component: AboutComponent },
 // { path: 'contact', component: ContactComponent },
  { path: 'register', component: RegisterComponent },
//   { path: 'login', component: LoginComponent },   //Use when login NOT nested in the Navbar
//  { path: 'todo', component: TodoListComponent },
  //{ path: 'todo/:id', component: TodoListComponent },
 // { path: '**', component: NotFoundComponent } //page not found route
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
