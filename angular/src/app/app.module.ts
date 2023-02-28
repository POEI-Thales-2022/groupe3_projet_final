import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { IncidentsComponent } from './model/incidents/incidents.component';
import { IncidentComponent } from './model/incident/incident.component';
import { AppRoutingModule } from './app-routing.module';
import { HttpClientModule } from '@angular/common/http';
import { AddIncidentComponent } from './model/add-incident/add-incident.component';
import {ReactiveFormsModule} from "@angular/forms";
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { MenuComponent } from './model/menu/menu.component';
import { DetailsIncidentComponent } from './model/details-incident/details-incident.component';
import { NgbdModalConfirm, NgbdModalConfirmAutofocus, NgbdModalFocus } from "./modal-focus";
import { HashLocationStrategy, LocationStrategy } from '@angular/common';

@NgModule({
  declarations: [
    AppComponent,
    IncidentsComponent,
    IncidentComponent,
    AddIncidentComponent,
    MenuComponent,
    DetailsIncidentComponent,
    NgbdModalConfirmAutofocus,
    NgbdModalFocus,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    NgbModule,
    NgbdModalConfirm,
  ],
  providers: [{provide: LocationStrategy, useClass: HashLocationStrategy}],
  bootstrap: [AppComponent]
})
export class AppModule { }
