package com.ompay.auth;

/**
 * Contexte du State Pattern : détient l'état courant et les données
 * collectées au fil du flow (numéro, OTP attendu, tentatives PIN).
 */
public class AuthContext {

    private AuthState state;
    private String phoneNumber;
    private String expectedOtp;
    private boolean authenticated = false;

    public AuthContext() {
        this.state = new EnteringPhoneState();
    }

    public void setState(AuthState state) {
        System.out.println("   [Transition d'état] " + this.state.getLabel() + " -> " + state.getLabel());
        this.state = state;
    }

    public void submitPhoneNumber(String phoneNumber) {
        state.submitPhoneNumber(this, phoneNumber);
    }

    public void submitOtp(String otpCode) {
        state.submitOtp(this, otpCode);
    }

    public void submitPin(String pin) {
        state.submitPin(this, pin);
    }

    public String getCurrentStateLabel() {
        return state.getLabel();
    }

    public boolean isAuthenticated() {
        return authenticated;
    }

    void setAuthenticated(boolean authenticated) {
        this.authenticated = authenticated;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getExpectedOtp() {
        return expectedOtp;
    }

    void setExpectedOtp(String expectedOtp) {
        this.expectedOtp = expectedOtp;
    }
}
