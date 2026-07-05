import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AuthService } from '../../core/auth.service';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './profile.component.html',
})
export class ProfileComponent {
  darkMode = signal(true);
  scannerEnabled = signal(true);
  language = signal('Français');

  constructor(public authService: AuthService, private router: Router) {}

  toggleDarkMode(): void {
    this.darkMode.update((v) => !v);
  }

  toggleScanner(): void {
    this.scannerEnabled.update((v) => !v);
  }

  logout(): void {
    this.authService.logout();
    this.router.navigate(['/login']);
  }
}
