import { Injectable, signal } from '@angular/core';
import { User } from '../models/user.model';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private expectedOtp = '';
  private pendingPhoneNumber = '';

  readonly isAuthenticated = signal(false);
  readonly currentUser = signal<User | null>(null);

  /** Étape 1 : demande d'envoi du SMS. Retourne l'OTP simulé (comme dans les logs de dev). */
  requestOtp(phoneNumber: string): string {
    if (!/^\d{9}$/.test(phoneNumber)) {
      throw new Error('Numéro invalide, format attendu : 9 chiffres après +221');
    }
    this.pendingPhoneNumber = phoneNumber;
    this.expectedOtp = String(Math.floor(1000 + Math.random() * 9000));
    console.info(`[SMS simulé] Code envoyé au +221 ${phoneNumber} : ${this.expectedOtp}`);
    return this.expectedOtp;
  }

  /** Étape 2 : vérification du code reçu par SMS. */
  verifyOtp(code: string): boolean {
    return code === this.expectedOtp;
  }

  /** Étape 3 : vérification du code secret puis connexion. */
  verifyPin(pin: string): boolean {
    if (!/^\d{4}$/.test(pin)) {
      return false;
    }
    this.currentUser.set({
      phoneNumber: this.pendingPhoneNumber,
      fullName: 'Birane Baila Wane',
      balance: 50000,
    });
    this.isAuthenticated.set(true);
    return true;
  }

  logout(): void {
    this.isAuthenticated.set(false);
    this.currentUser.set(null);
  }
}
