# OM Pay — Angular (Web)

Reproduction du flow complet de l'app **OM Pay** en Angular 18 (standalone components,
signals, lazy-loaded routes), fidèle aux captures d'écran fournies.

## Écrans

| Route | Composant | Correspond à |
|---|---|---|
| `/login` | `LoginComponent` | Écran "Bienvenue sur OM Pay ! Entrez votre numéro mobile" |
| `/otp` | `OtpComponent` | Écran de vérification du SMS |
| `/pin` | `PinComponent` | Clavier numérique de saisie du code secret |
| `/home` | `HomeComponent` | Écran d'accueil : Payer/Transférer + Historique |
| `/profile` | `ProfileComponent` | Menu profil : thème, scanner, langue, déconnexion |

`/home` et `/profile` sont protégées par `authGuard`.

## Architecture

- `core/auth.service.ts` — gère le flow numéro → OTP → PIN (signals `isAuthenticated`, `currentUser`)
- `core/transaction.service.ts` — logique Payer (sans frais) / Transférer (1% de frais) + historique
- `core/auth.guard.ts` — protège les routes `/home` et `/profile`
- `models/` — interfaces `User`, `Transaction`

## Installation et lancement

```bash
npm install
npm start
```

L'app démarre sur `http://localhost:4200`.

## Build de production

```bash
npm run build
```
