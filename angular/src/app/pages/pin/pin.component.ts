import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AuthService } from '../../core/auth.service';

@Component({
  selector: 'app-pin',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './pin.component.html',
})
export class PinComponent {
  digits = signal<string[]>(['', '', '', '']);
  keypad = ['2', '4', '8', '7', '3', '0', '6', '5', '1', '9'];
  error = signal<string | null>(null);

  constructor(private authService: AuthService, private router: Router) {}

  pressDigit(digit: string): void {
    const current = this.digits();
    const index = current.findIndex((d) => d === '');
    if (index === -1) return;

    const updated = [...current];
    updated[index] = digit;
    this.digits.set(updated);

    if (index === 3) {
      this.tryLogin(updated.join(''));
    }
  }

  backspace(): void {
    const current = this.digits();
    const lastFilled = [...current].reverse().findIndex((d) => d !== '');
    if (lastFilled === -1) return;
    const index = current.length - 1 - lastFilled;
    const updated = [...current];
    updated[index] = '';
    this.digits.set(updated);
  }

  private tryLogin(pin: string): void {
    if (this.authService.verifyPin(pin)) {
      this.router.navigate(['/home']);
    } else {
      this.error.set('Code secret invalide.');
      setTimeout(() => {
        this.digits.set(['', '', '', '']);
        this.error.set(null);
      }, 800);
    }
  }
}
