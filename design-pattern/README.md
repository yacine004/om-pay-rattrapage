# OM Pay — Design Patterns (Java)

Implémentation Java (Maven, JDK 17+) illustrant l'application de design patterns
au domaine métier de l'app **OM Pay**, en s'appuyant directement sur le flow
visible dans les captures d'écran fournies.

## Patterns implémentés

### 1. State — `com.ompay.auth`
Modélise le flow d'authentification écran par écran :
`EnteringPhoneState` → `AwaitingOtpState` → `EnteringPinState` → `AuthenticatedState`.

**Pourquoi ce pattern ?** Chaque écran a un comportement différent pour les
mêmes actions (soumettre un numéro / un OTP / un PIN). Sans State, on se
retrouve avec un immense `switch` sur une variable "étape actuelle". Ici,
chaque état encapsule sa propre logique et décide de la transition suivante
via `AuthContext.setState(...)`. Ajouter un écran (ex: mot de passe oublié)
ne modifie aucun état existant (principe Ouvert/Fermé).

### 2. Strategy — `com.ompay.operation`
Modélise le choix "Payer" vs "Transférer" (boutons radio de l'écran d'accueil) :
`OperationStrategy` → `PayerStrategy` (sans frais) / `TransfererStrategy` (frais 1%).

**Pourquoi ce pattern ?** Les deux opérations partagent la même interface
(`execute(user, target, amount)`) mais des règles métier différentes.
`OperationContext` sélectionne dynamiquement l'algorithme selon le bouton
radio choisi par l'utilisateur, sans jamais connaître les détails d'implémentation.

### 3. Observer — `com.ompay.history`
Modélise la mise à jour de la liste "Historique" après chaque opération :
`TransactionPublisher` (sujet) notifie `TransactionHistory` (observateur).

**Pourquoi ce pattern ?** Découple la réalisation d'une transaction de sa
répercussion sur l'affichage. On pourrait ajouter un second observateur
(notification push, mise à jour du solde) sans toucher à `OperationContext`.

## Structure

```
src/main/java/com/ompay/
├── Main.java                    # rejoue le scénario complet des captures d'écran
├── model/
│   ├── User.java
│   └── Transaction.java
├── auth/                        # State Pattern
│   ├── AuthState.java
│   ├── AuthContext.java
│   ├── EnteringPhoneState.java
│   ├── AwaitingOtpState.java
│   ├── EnteringPinState.java
│   └── AuthenticatedState.java
├── operation/                   # Strategy Pattern
│   ├── OperationStrategy.java
│   ├── PayerStrategy.java
│   ├── TransfererStrategy.java
│   └── OperationContext.java
└── history/                     # Observer Pattern
    ├── HistoryObserver.java
    ├── TransactionPublisher.java
    └── TransactionHistory.java
```

## Lancer le projet

```bash
mvn compile exec:java -Dexec.mainClass=com.ompay.Main
# ou
mvn package
java -jar target/ompay-design-patterns.jar
```

## Lancer les tests

```bash
mvn test
```

Couvre : flow d'authentification complet, cas d'erreur (numéro/OTP invalide,
ordre des étapes non respecté), calcul des frais de transfert, solde
insuffisant, absence de stratégie sélectionnée.
