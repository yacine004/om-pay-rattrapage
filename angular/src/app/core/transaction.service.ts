import { Injectable, signal } from '@angular/core';
import { Transaction } from '../models/transaction.model';
import { AuthService } from './auth.service';

const TRANSFER_FEE_RATE = 0.01;

@Injectable({ providedIn: 'root' })
export class TransactionService {
  readonly history = signal<Transaction[]>([
    { type: "Transfert d'argent", target: '772775076', amount: 10, date: new Date('2026-11-24T13:47:00') },
    { type: "Transfert d'argent", target: '781534929', amount: 26260, date: new Date('2026-11-23T13:51:00') },
  ]);

  constructor(private authService: AuthService) {}

  payer(merchantCode: string, amount: number): void {
    this.debitUser(amount);
    this.history.update((list) => [
      { type: 'Paiement', target: merchantCode, amount, date: new Date() },
      ...list,
    ]);
  }

  transferer(targetNumber: string, amount: number): void {
    const fee = amount * TRANSFER_FEE_RATE;
    this.debitUser(amount + fee);
    this.history.update((list) => [
      { type: "Transfert d'argent", target: targetNumber, amount, date: new Date() },
      ...list,
    ]);
  }

  private debitUser(total: number): void {
    if (!this.authService.isAuthenticated()) {
      throw new Error('Vous devez être connecté pour effectuer cette opération');
    }

    const user = this.authService.currentUser();
    if (!user) {
      throw new Error('Vous devez être connecté pour effectuer cette opération');
    }

    if (total > user.balance) {
      throw new Error('Solde insuffisant');
    }
    this.authService.currentUser.set({ ...user, balance: user.balance - total });
  }
}
