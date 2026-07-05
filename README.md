# OM Pay — Examen de Rattrapage L3 S2

Reproduction de l'application **OM Pay** (Orange Money) — Nom Prénom - Classe

Ce dépôt contient **3 branches indépendantes**, une par livrable :

| Branche | Contenu |
|---|---|
| `design-pattern` | Implémentation Java illustrant les design patterns **State**, **Strategy** et **Observer** appliqués au domaine de l'app (authentification, opérations Payer/Transférer, historique) |
| `angular` | Reproduction du flow complet de l'app en Angular (Web) |
| `flutter` | Reproduction du flow complet de l'app en Flutter (Mobile) |

## Pour consulter une branche

```bash
git clone <url-du-repo>
cd omp-rattrapage
git checkout design-pattern   # ou angular, ou flutter
```

## Flow reproduit

1. Écran d'accueil / saisie du numéro (+221)
2. Vérification OTP par SMS
3. Saisie du code secret (PIN à 4 chiffres)
4. Écran principal : Payer / Transférer + historique des transactions
5. Écran profil : infos utilisateur, thème sombre, scanner QR, langue, déconnexion
