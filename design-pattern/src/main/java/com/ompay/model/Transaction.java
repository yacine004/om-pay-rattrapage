package com.ompay.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Une opération enregistrée dans l'historique (voir écran "Historique" de l'app).
 */
public class Transaction {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM HH:mm");

    private final String type;          // "Payer" ou "Transférer"
    private final String targetNumber;  // numéro / code marchand
    private final double amount;
    private final LocalDateTime date;

    public Transaction(String type, String targetNumber, double amount) {
        this.type = type;
        this.targetNumber = targetNumber;
        this.amount = amount;
        this.date = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return String.format("%s  %s   - %.0f CFA   %s",
                type, targetNumber, amount, date.format(FORMATTER));
    }
}
