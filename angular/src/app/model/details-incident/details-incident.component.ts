import {Component, Input, Type} from '@angular/core';
import {Incident} from "../Incident";
import {Level} from "../Level";
import {ActivatedRoute, Router} from "@angular/router";
import {HttpService} from "../../http.service";
import {NgbdModalConfirm, NgbdModalConfirmAutofocus, NgbdModalFocus} from "../../modal-focus";
@Component({
  selector: 'app-details-incident',
  templateUrl: './details-incident.component.html',
  styleUrls: ['./details-incident.component.scss']
})
export class DetailsIncidentComponent {

  @Input()
  incident!: Incident;

  constructor(private activateRoute: ActivatedRoute,
              private httpService: HttpService,

              private router: Router) {
  }

  ngOnInit() {
    let id = Number(this.activateRoute.snapshot.paramMap.get('id'));
    this.httpService.findOne(id).subscribe(res => this.incident = res);
  }

  delete(incident: Incident): void {
    if(confirm("Etes vous sur de vouloir supprimer cet incident ?")) {
      this.httpService.deleteIncident(incident.id).subscribe(v => this.router.navigateByUrl('/list'));
    }
  }
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
}
