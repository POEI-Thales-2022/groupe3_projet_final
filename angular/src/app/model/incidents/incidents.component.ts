import {Component, OnInit} from '@angular/core';
import {Incident} from "../Incident";
import {HttpService} from "../../http.service";
import {Router} from "@angular/router";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
@Component({
  selector: 'app-incidents',
  templateUrl: './incidents.component.html',
  styleUrls: ['./incidents.component.scss']
})
export class IncidentsComponent implements OnInit {

  incidents: Incident[] = [];

  myForm!: FormGroup;

  constructor(private fb: FormBuilder,
              private httpService: HttpService,
              private router: Router){
  }

  ngOnInit(): void {
    this.httpService.findAll().subscribe(val => this.incidents = val);
    this.myForm = this.fb.group({
        id: ['', [Validators.required]],
      },
      {
        updateOn: "submit",
      }
    )
  }

  submitData(){
    if(this?.myForm?.valid) {
      if(confirm("Etes vous sur de vouloir supprimer cet incident ?")) {
        this.incidents = this.incidents.filter(i => i?.id !== this?.myForm?.value?.id);
        this.httpService.deleteIncident(this?.myForm?.value?.id).subscribe();
      }
    }
  }

}
