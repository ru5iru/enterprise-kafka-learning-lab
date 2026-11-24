package io.github.ru5iru.kafkalab.buildverification;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

final class ToolchainProbeTest {
    @Test
    void executesOnTheConfiguredJdk() {
        int expected = Integer.getInteger("probe.expectedJava", 25);
        assertEquals(expected, ToolchainProbe.runtimeFeature());
    }
}
