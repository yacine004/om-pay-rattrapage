package com.ompay.model;

/**
 * Représente un utilisateur OM Pay (correspond à l'écran profil : nom, numéro).
 */
public class User {

    private final String phoneNumber;
    private final String fullName;
    private double balance;

    public User(String phoneNumber, String fullName, double balance) {
        this.phoneNumber = phoneNumber;
        this.fullName = fullName;
        this.balance = balance;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public double getBalance() {
        return balance;
    }

    public void debit(double amount) {
        if (amount > balance) {
            throw new IllegalStateException("Solde insuffisant");
        }
        balance -= amount;
    }

    @Override
public String toString() {
    return fullName + " (" + phoneNumber + ") - Solde: " + String.format("%.2f", balance) + " FCFA";
}
}
