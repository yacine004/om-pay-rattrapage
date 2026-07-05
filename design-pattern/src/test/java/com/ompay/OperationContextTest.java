package com.ompay;

import com.ompay.history.TransactionHistory;
import com.ompay.history.TransactionPublisher;
import com.ompay.model.User;
import com.ompay.operation.OperationContext;
import com.ompay.operation.PayerStrategy;
import com.ompay.operation.TransfererStrategy;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class OperationContextTest {

    @Test
    void payerShouldDebitExactAmountAndNotifyObserver() {
        User user = new User("770000000", "Test User", 10000);
        user.setAuthenticated(true);
        TransactionHistory history = new TransactionHistory();
        TransactionPublisher publisher = new TransactionPublisher();
        publisher.subscribe(history);

        OperationContext context = new OperationContext(publisher);
        context.setStrategy(new PayerStrategy());
        context.valider(user, "MARCH-01", 1000);

        assertEquals(9000, user.getBalance());
        assertEquals(1, history.getTransactions().size());
    }

    @Test
    void transfererShouldApplyOnePercentFee() {
        User user = new User("770000000", "Test User", 10000);
        user.setAuthenticated(true);
        TransactionHistory history = new TransactionHistory();
        TransactionPublisher publisher = new TransactionPublisher();
        publisher.subscribe(history);

        OperationContext context = new OperationContext(publisher);
        context.setStrategy(new TransfererStrategy());
        context.valider(user, "781534929", 1000);

        // 1000 + 1% de frais = 1010
        assertEquals(8990, user.getBalance());
    }

    @Test
    void shouldThrowWhenNoStrategySelected() {
        User user = new User("770000000", "Test User", 10000);
        user.setAuthenticated(true);
        TransactionPublisher publisher = new TransactionPublisher();
        OperationContext context = new OperationContext(publisher);

        assertThrows(IllegalStateException.class,
                () -> context.valider(user, "MARCH-01", 1000));
    }

    @Test
    void shouldThrowWhenInsufficientBalance() {
        User user = new User("770000000", "Test User", 100);
        user.setAuthenticated(true);
        TransactionPublisher publisher = new TransactionPublisher();
        OperationContext context = new OperationContext(publisher);
        context.setStrategy(new PayerStrategy());

        assertThrows(IllegalStateException.class,
                () -> context.valider(user, "MARCH-01", 1000));
    }
}
