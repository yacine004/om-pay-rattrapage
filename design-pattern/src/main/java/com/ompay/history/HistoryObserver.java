package com.ompay.history;

import com.ompay.model.Transaction;

/**
 * Observer Pattern.
 *
 * Permet de découpler la réalisation d'une opération (Payer/Transférer) de sa
 * répercussion sur l'écran "Historique". D'autres observateurs pourraient être
 * ajoutés sans rien changer à la logique métier (ex: notification push,
 * mise à jour du solde affiché, export comptable).
 */
public interface HistoryObserver {
    void onNewTransaction(Transaction transaction);
}
