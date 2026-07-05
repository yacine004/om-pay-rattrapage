package com.ompay.auth;

/** Correspond à l'écran d'accueil ("Bonjour Birane") une fois connecté. */
public class AuthenticatedState implements AuthState {

    @Override
    public void submitPhoneNumber(AuthContext context, String phoneNumber) {
        System.out.println("   Déjà connecté.");
    }

    @Override
    public void submitOtp(AuthContext context, String otpCode) {
        System.out.println("   Déjà connecté.");
    }

    @Override
    public void submitPin(AuthContext context, String pin) {
        System.out.println("   Déjà connecté.");
    }

    @Override
    public String getLabel() {
        return "Connecté";
    }
}
