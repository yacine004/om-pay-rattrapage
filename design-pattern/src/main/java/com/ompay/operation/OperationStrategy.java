package com.ompay.operation;

import com.ompay.model.Transaction;
import com.ompay.model.User;

/**
 * Strategy Pattern.
 *
 * L'écran d'accueil propose deux opérations (bouton radio "Payer" / "Transférer").
 * Chacune a une logique métier différente (frais, validations) mais partage la
 * même interface : c'est l'algorithme qui varie, pas le contexte qui l'utilise.
 */
public interface OperationStrategy {

    /** Exécute l'opération et retourne la transaction générée pour l'historique. */
    Transaction execute(User user, String target, double amount);

    String getLabel();
}
