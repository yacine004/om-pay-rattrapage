package com.ompay.operation;

import com.ompay.model.Transaction;
import com.ompay.model.User;

/** Transfert vers un autre numéro : applique des frais de 1%. */
public class TransfererStrategy implements OperationStrategy {

    private static final double FEE_RATE = 0.01;

    @Override
    public Transaction execute(User user, String targetNumber, double amount) {
        double fee = amount * FEE_RATE;
        double total = amount + fee;
        user.debit(total);
        System.out.printf("   Transfert de %.0f CFA vers %s (frais: %.0f CFA) effectué.%n",
                amount, targetNumber, fee);
        return new Transaction("Transfert d'argent", targetNumber, amount);
    }

    @Override
    public String getLabel() {
        return "Transférer";
    }
}
