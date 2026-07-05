package com.ompay.auth;

import java.util.Random;

/** Correspond à l'écran "Bienvenue sur OM Pay ! Entrez votre numéro mobile". */
public class EnteringPhoneState implements AuthState {

    private static final Random RANDOM = new Random();

    @Override
    public void submitPhoneNumber(AuthContext context, String phoneNumber) {
        if (phoneNumber == null || !phoneNumber.matches("\\d{9}")) {
            System.out.println("   Numéro invalide, format attendu: 9 chiffres après +221");
            return;
        }
        context.setPhoneNumber(phoneNumber);
        String otp = String.format("%04d", RANDOM.nextInt(10000));
        context.setExpectedOtp(otp);
        System.out.println("   SMS envoyé au +221 " + phoneNumber + " -> code (simulé): " + otp);
        context.setState(new AwaitingOtpState());
    }

    @Override
    public void submitOtp(AuthContext context, String otpCode) {
        System.out.println("   Action impossible : veuillez d'abord saisir votre numéro.");
    }

    @Override
    public void submitPin(AuthContext context, String pin) {
        System.out.println("   Action impossible : veuillez d'abord saisir votre numéro.");
    }

    @Override
    public String getLabel() {
        return "Saisie du numéro";
    }
}
