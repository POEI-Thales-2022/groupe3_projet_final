import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {IncidentComponent} from "./model/incident/incident.component";
import {AddIncidentComponent} from "./model/add-incident/add-incident.component";
import {IncidentsComponent} from "./model/incidents/incidents.component";
import {DetailsIncidentComponent} from "./model/details-incident/details-incident.component";

const routes: Routes = [
  { path: 'add', component: AddIncidentComponent },
  { path: 'list', component: IncidentsComponent },
  { path: 'incident/:id', component: DetailsIncidentComponent },
  { path: '', redirectTo: 'list', pathMatch: 'full' },
]
@NgModule({
  imports: [ RouterModule.forRoot(routes, { useHash: true }) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
