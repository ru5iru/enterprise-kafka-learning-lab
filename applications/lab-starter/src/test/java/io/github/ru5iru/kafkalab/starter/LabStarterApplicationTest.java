package io.github.ru5iru.kafkalab.starter;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;

class LabStarterApplicationTest {
    @Test
    void startsAnActiveNonWebApplicationContext() {
        var application = new SpringApplication(LabStarterApplication.class);
        assertEquals(WebApplicationType.NONE, application.getWebApplicationType());
        try (var context = application.run()) {
            assertTrue(context.isActive());
            assertNotNull(context.getBean(LabStarterApplication.class));
        }
    }
}
