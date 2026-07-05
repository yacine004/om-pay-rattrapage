package com.ompay.auth;

/** Correspond à l'écran "SMS d'authentification vérifié ! Saisissez votre code secret". */
public class AwaitingOtpState implements AuthState {

    @Override
    public void submitPhoneNumber(AuthContext context, String phoneNumber) {
        System.out.println("   Numéro déjà saisi, en attente du code OTP.");
    }

    @Override
    public void submitOtp(AuthContext context, String otpCode) {
        if (!otpCode.equals(context.getExpectedOtp())) {
            System.out.println("   Code OTP incorrect, réessayez.");
            return;
        }
        System.out.println("   OTP vérifié !");
        context.setState(new EnteringPinState());
    }

    @Override
    public void submitPin(AuthContext context, String pin) {
        System.out.println("   Action impossible : veuillez d'abord valider le code OTP.");
    }

    @Override
    public String getLabel() {
        return "Vérification OTP";
    }
}
