import {Component, Input} from '@angular/core';
import {Incident} from "../Incident";
import {Level} from "../Level";
import {ActivatedRoute, Router} from "@angular/router";
import {HttpService} from "../../http.service";

@Component({
  selector: 'app-incident',
  templateUrl: './incident.component.html',
  styleUrls: ['./incident.component.scss']
})
export class IncidentComponent {

  constructor(private activateRoute: ActivatedRoute,
              private httpService: HttpService,
              private router: Router) {
  }

  @Input()
  incident!: Incident;

  changeColor(): String {
    let res = 'card text-bg-primary mb-3';
    if(this.incident.level==Level.ERROR){
      res = 'card text-bg-danger mb-3';
    }
    if(this.incident.level==Level.FATAL){
      res = 'card text-bg-warning mb-3';
    }
    if(this.incident.level==Level.MEDIUM){
      res = 'card text-bg-success mb-3';
    }
    return res;
  }

  goTo(id: number): void{
    this.router.navigateByUrl(`/incident/${id}`);
  }
}
