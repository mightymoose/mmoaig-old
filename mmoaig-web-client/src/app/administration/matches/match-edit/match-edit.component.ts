import { Component, OnInit } from '@angular/core';
import { pluck, flatMap, tap } from 'rxjs/operators';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup } from '@angular/forms';
import { UpdateMatchService } from '../update-match.service';
import { Observable } from 'rxjs';

@Component({
  selector: 'mmo-match-edit',
  templateUrl: './match-edit.component.html',
  styleUrls: ['./match-edit.component.css']
})
export class MatchEditComponent implements OnInit {
  public form: FormGroup;

  constructor(private route: ActivatedRoute, formBuilder: FormBuilder, private router: Router, private update: UpdateMatchService) {
    this.form = formBuilder.group({
      status: null
    });
  }

  ngOnInit() {
    this.data.subscribe(attributes => this.form.setValue(attributes));
  }

  submit() {
    this.route.data.pipe(
      pluck('match', 'data', 'id'),
      flatMap((matchId: any) => this.update.update(matchId, this.form.value)),
      flatMap(result => this.updateRouteData(result))
    )
    .subscribe(() => this.router.navigate(['..'], { relativeTo: this.route }));
  }

  private updateRouteData(data: any): Observable<any> {
    return this.data.pipe(tap(attributes => Object.assign(attributes, data)));
  }

  private get data(): Observable<any> {
    return this.route.data.pipe(pluck('match', 'data', 'attributes'));
  }

}
