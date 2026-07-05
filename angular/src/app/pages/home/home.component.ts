import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/auth.service';
import { TransactionService } from '../../core/transaction.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './home.component.html',
})
export class HomeComponent {
  mode: 'payer' | 'transferer' = 'payer';
  target = '';
  amount: number | null = null;
  error = signal<string | null>(null);
  hideBalance = signal(false);

  constructor(
    public authService: AuthService,
    public transactionService: TransactionService,
    private router: Router,
  ) {}

  toggleBalance(): void {
    this.hideBalance.update((v) => !v);
  }

  onValider(): void {
    this.error.set(null);
    if (!this.target || !this.amount || this.amount <= 0) {
      this.error.set('Veuillez saisir un numéro/code et un montant valides.');
      return;
    }
    try {
      if (this.mode === 'payer') {
        this.transactionService.payer(this.target, this.amount);
      } else {
        this.transactionService.transferer(this.target, this.amount);
      }
      this.target = '';
      this.amount = null;
    } catch (e) {
      this.error.set((e as Error).message);
    }
  }

  goToProfile(): void {
    this.router.navigate(['/profile']);
  }
}
