package com.ompay.history;

import com.ompay.model.Transaction;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/** Observateur concret : correspond à la liste affichée dans "Historique". */
public class TransactionHistory implements HistoryObserver {

    private final List<Transaction> transactions = new ArrayList<>();

    @Override
    public void onNewTransaction(Transaction transaction) {
        transactions.add(0, transaction); // plus récent en premier, comme dans l'app
        System.out.println("   [Historique mis à jour] " + transaction);
    }

    public List<Transaction> getTransactions() {
        return Collections.unmodifiableList(transactions);
    }
}
