package com.ompay.operation;

import com.ompay.model.Transaction;
import com.ompay.model.User;

/** Paiement chez un marchand : pas de frais, saisie d'un code marchand. */
public class PayerStrategy implements OperationStrategy {

    @Override
    public Transaction execute(User user, String merchantCode, double amount) {
        user.debit(amount);
        System.out.println("   Paiement de " + amount + " CFA au marchand " + merchantCode + " effectué.");
        return new Transaction("Paiement", merchantCode, amount);
    }

    @Override
    public String getLabel() {
        return "Payer";
    }
}
