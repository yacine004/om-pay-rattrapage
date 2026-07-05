package com.ompay.auth;

/** Correspond au clavier numérique de saisie du code secret à 4 chiffres. */
public class EnteringPinState implements AuthState {

    @Override
    public void submitPhoneNumber(AuthContext context, String phoneNumber) {
        System.out.println("   Action impossible : veuillez saisir votre code secret.");
    }

    @Override
    public void submitOtp(AuthContext context, String otpCode) {
        System.out.println("   OTP déjà validé, veuillez saisir votre code secret.");
    }

    @Override
    public void submitPin(AuthContext context, String pin) {
        if (pin == null || !pin.matches("\\d{4}")) {
            System.out.println("   Code secret invalide (4 chiffres attendus).");
            return;
        }
        System.out.println("   Code secret accepté. Connexion réussie !");
        context.setAuthenticated(true);
        context.setState(new AuthenticatedState());
    }

    @Override
    public String getLabel() {
        return "Saisie du code secret";
    }
}
