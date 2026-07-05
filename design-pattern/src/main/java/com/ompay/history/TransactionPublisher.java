package com.ompay.history;

import com.ompay.model.Transaction;

import java.util.ArrayList;
import java.util.List;

/** Sujet observable : notifie tous les observateurs enregistrés. */
public class TransactionPublisher {

    private final List<HistoryObserver> observers = new ArrayList<>();

    public void subscribe(HistoryObserver observer) {
        observers.add(observer);
    }

    public void unsubscribe(HistoryObserver observer) {
        observers.remove(observer);
    }

    public void notifyObservers(Transaction transaction) {
        for (HistoryObserver observer : observers) {
            observer.onNewTransaction(transaction);
        }
    }
}
