import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
})
export class LoginComponent {
  phoneNumber = '';
  error = signal<string | null>(null);

  constructor(private authService: AuthService, private router: Router) {}

  onSubmit(): void {
    this.error.set(null);
    try {
      this.authService.requestOtp(this.phoneNumber);
      this.router.navigate(['/otp']);
    } catch (e) {
      this.error.set((e as Error).message);
    }
  }
}
