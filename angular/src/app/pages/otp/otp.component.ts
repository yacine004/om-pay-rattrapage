import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/auth.service';

@Component({
  selector: 'app-otp',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './otp.component.html',
})
export class OtpComponent {
  code = '';
  error = signal<string | null>(null);

  constructor(private authService: AuthService, private router: Router) {}

  onSubmit(): void {
    if (this.authService.verifyOtp(this.code)) {
      this.router.navigate(['/pin']);
    } else {
      this.error.set('Code OTP incorrect, réessayez.');
    }
  }
}
