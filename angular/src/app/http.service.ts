import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Incident} from "./model/Incident";
@Injectable({
  providedIn: 'root'
})
export class HttpService {

  url = "http://20.106.126.15:30007/learn/api/incidents";

  constructor(private http: HttpClient) { }

  findAll(): Observable<Incident[]>{
    return this.http.get<Incident[]>(this.url);
  }

  findOne(id: number): Observable<Incident>{
    return this.http.get<Incident>( `${this.url}/${id}`);
  }

  deleteIncident(id: number): Observable<Incident> {
    return this.http.delete<Incident>(`${this.url}/${id}`);
  }

  add(incident: Incident): Observable<Incident>{
    return this.http.post<Incident>(this.url, incident);
  }
}
