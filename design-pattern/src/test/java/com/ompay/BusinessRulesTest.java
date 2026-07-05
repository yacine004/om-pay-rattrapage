package com.ompay;

import com.ompay.model.User;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertThrows;

class BusinessRulesTest {

    @Test
    void debitShouldBeRejectedWhenUserIsNotAuthenticated() {
        User user = new User("770123456", "Birane", 50000);

        IllegalStateException exception = assertThrows(
                IllegalStateException.class,
                () -> user.debit(1000)
        );

        assert exception.getMessage().contains("connecté");
    }
}
