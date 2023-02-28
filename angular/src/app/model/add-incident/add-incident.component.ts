import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {HttpService} from "../../http.service";
import {Router} from "@angular/router";
import {Incident} from "../Incident";
import {Level} from "../Level";
import {Type} from "../Type";

@Component({
  selector: 'app-add-incident',
  templateUrl: './add-incident.component.html',
  styleUrls: ['./add-incident.component.scss']
})
export class AddIncidentComponent implements OnInit {
  level = Level;
  type = Type;
  myForm!: FormGroup;

  constructor(private fb: FormBuilder,
              private httpService: HttpService,
              private router: Router) {
  }

  ngOnInit(): void {
    this.myForm = this.fb.group({
        titre: ['', [Validators.required]],
        description: ['', [Validators.required]],
        level: ['', [Validators.required]],
        type: ['', [Validators.required]],
        progress: ['', [Validators.min(0), Validators.max(100), Validators.required]],
        email: ['', [Validators.required]],
        dateCreation: ['', [Validators.required]],
        dateModification: ['', [Validators.required]],
        open: ['', [Validators.required]],
      },
      {
        updateOn: "submit",
      }
    )
  }

  submitData(){
    if(this?.myForm?.valid){
      this.httpService.add(this?.myForm?.value).subscribe(v => this.router.navigateByUrl('/list'));
    }
  }
}

