package com.ompay;

import com.ompay.auth.AuthContext;
import com.ompay.history.TransactionHistory;
import com.ompay.history.TransactionPublisher;
import com.ompay.model.User;
import com.ompay.operation.OperationContext;
import com.ompay.operation.PayerStrategy;
import com.ompay.operation.TransfererStrategy;

/**
 * Rejoue le scénario visible dans les captures d'écran de l'app OM Pay :
 * 1. Saisie du numéro -> 2. OTP -> 3. PIN -> 4. Payer -> 5. Transférer.
 */
public class Main {

    public static void main(String[] args) {
        System.out.println("=== 1. Écran de connexion (State Pattern) ===");
        AuthContext auth = new AuthContext();
        System.out.println("État courant: " + auth.getCurrentStateLabel());

        auth.submitPhoneNumber("770123456");
        // Pour la démo on récupère directement l'OTP généré (simulé)
        String otpGenere = auth.getExpectedOtp();
        auth.submitOtp(otpGenere);
        auth.submitPin("1234");

        System.out.println("État final: " + auth.getCurrentStateLabel()
                + " | Authentifié: " + auth.isAuthenticated());

        System.out.println("\n=== 2. Écran d'accueil : Payer / Transférer (Strategy + Observer) ===");
        User birane = new User("777669595", "Birane Baila Wane", 50000);
        birane.setAuthenticated(true);
        System.out.println(birane);

        TransactionHistory historique = new TransactionHistory();
        TransactionPublisher publisher = new TransactionPublisher();
        publisher.subscribe(historique);

        OperationContext operation = new OperationContext(publisher);

        operation.setStrategy(new PayerStrategy());
        operation.valider(birane, "MARCH-2201", 10000);

        operation.setStrategy(new TransfererStrategy());
        operation.valider(birane, "781534929", 26260);

        System.out.println("\n=== 3. Historique final ===");
        historique.getTransactions().forEach(t -> System.out.println("   " + t));

        System.out.printf("%nSolde restant: %.2f FCFA%n", birane.getBalance());
    }
}
