package com.ompay.auth;

/**
 * State Pattern.
 *
 * Chaque écran d'authentification de l'app (saisie du numéro, OTP, PIN, connecté)
 * est modélisé comme un état. Le contexte {@link AuthContext} délègue le
 * comportement à l'état courant, ce qui évite les if/else en cascade et permet
 * d'ajouter facilement un nouvel écran (ex: mot de passe oublié) sans toucher
 * au code existant (Open/Closed Principle).
 */
public interface AuthState {

    /** Étape 1 : l'utilisateur saisit son numéro (+221). */
    void submitPhoneNumber(AuthContext context, String phoneNumber);

    /** Étape 2 : l'utilisateur saisit le code reçu par SMS. */
    void submitOtp(AuthContext context, String otpCode);

    /** Étape 3 : l'utilisateur saisit son code secret à 4 chiffres. */
    void submitPin(AuthContext context, String pin);

    /** Nom lisible de l'état, utile pour l'affichage / les logs. */
    String getLabel();
}
