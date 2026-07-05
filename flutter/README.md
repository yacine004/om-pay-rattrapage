# OM Pay — Flutter (Mobile)

Reproduction du flow complet de l'app **OM Pay** en Flutter (Provider pour la
gestion d'état), fidèle aux captures d'écran fournies.

## Écrans

| Route | Fichier | Correspond à |
|---|---|---|
| `/login` | `screens/login_screen.dart` | Écran "Bienvenue sur OM Pay ! Entrez votre numéro mobile" |
| `/otp` | `screens/otp_screen.dart` | Écran de vérification du SMS |
| `/pin` | `screens/pin_screen.dart` | Clavier numérique de saisie du code secret |
| `/home` | `screens/home_screen.dart` | Écran d'accueil : Payer/Transférer + Historique |
| `/profile` | `screens/profile_screen.dart` | Menu profil : thème, scanner, langue, déconnexion |

## Architecture

- `services/auth_service.dart` (`ChangeNotifier`) — gère le flow numéro → OTP → PIN
- `services/transaction_service.dart` (`ChangeNotifier`) — Payer (sans frais) / Transférer (1% de frais) + historique
- `models/` — `OmUser`, `OmTransaction`
- `theme.dart` — thème sombre + orange partagé par tous les écrans
- Gestion d'état via **Provider** (`MultiProvider` dans `main.dart`)

## Installation et lancement

```bash
flutter pub get
flutter run
```

## Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
```
