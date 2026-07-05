package com.ompay;

import com.ompay.auth.AuthContext;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AuthContextTest {

    @Test
    void fullFlowShouldAuthenticateUser() {
        AuthContext auth = new AuthContext();
        auth.submitPhoneNumber("770123456");
        assertEquals("Vérification OTP", auth.getCurrentStateLabel());

        auth.submitOtp(auth.getExpectedOtp());
        assertEquals("Saisie du code secret", auth.getCurrentStateLabel());

        auth.submitPin("1234");
        assertTrue(auth.isAuthenticated());
        assertEquals("Connecté", auth.getCurrentStateLabel());
    }

    @Test
    void invalidPhoneNumberShouldNotTransition() {
        AuthContext auth = new AuthContext();
        auth.submitPhoneNumber("abc");
        assertEquals("Saisie du numéro", auth.getCurrentStateLabel());
    }

    @Test
    void wrongOtpShouldNotTransition() {
        AuthContext auth = new AuthContext();
        auth.submitPhoneNumber("770123456");
        auth.submitOtp("0000000"); // volontairement erroné
        assertEquals("Vérification OTP", auth.getCurrentStateLabel());
    }

    @Test
    void cannotSubmitPinBeforeOtp() {
        AuthContext auth = new AuthContext();
        auth.submitPhoneNumber("770123456");
        auth.submitPin("1234");
        assertFalse(auth.isAuthenticated());
    }
}
