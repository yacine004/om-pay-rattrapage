package com.ompay.operation;

import com.ompay.history.TransactionPublisher;
import com.ompay.model.Transaction;
import com.ompay.model.User;

/**
 * Contexte du Strategy Pattern. Choisi dynamiquement l'algorithme (Payer ou
 * Transférer) selon le bouton radio sélectionné par l'utilisateur, puis
 * publie le résultat aux observateurs (Observer Pattern) pour mise à jour
 * de l'historique.
 */
public class OperationContext {

    private OperationStrategy strategy;
    private final TransactionPublisher publisher;

    public OperationContext(TransactionPublisher publisher) {
        this.publisher = publisher;
    }

    public void setStrategy(OperationStrategy strategy) {
        System.out.println("   [Stratégie sélectionnée] " + strategy.getLabel());
        this.strategy = strategy;
    }

    public void valider(User user, String target, double amount) {
        if (strategy == null) {
            throw new IllegalStateException("Aucune opération sélectionnée (Payer/Transférer)");
        }
        Transaction transaction = strategy.execute(user, target, amount);
        publisher.notifyObservers(transaction);
    }
}
