package io.github.ru5iru.kafkalab.buildverification;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

import java.io.DataInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Objects;
import java.util.jar.JarFile;

final class ToolchainProbeIT {
    @Test
    void packagedArtifactContainsTheConfiguredBytecode() throws IOException {
        Path artifact = Path.of(Objects.requireNonNull(System.getProperty("probe.artifact")));
        assertTrue(Files.isRegularFile(artifact));
        try (JarFile jar = new JarFile(artifact.toFile())) {
            var entry =
                    jar.getJarEntry(
                            "io/github/ru5iru/kafkalab/buildverification/ToolchainProbe.class");
            assertNotNull(entry);
            try (DataInputStream input = new DataInputStream(jar.getInputStream(entry))) {
                assertEquals(0xCAFEBABE, input.readInt());
                input.readUnsignedShort();
                assertEquals(
                        Integer.getInteger("probe.expectedMajor", 69).intValue(),
                        input.readUnsignedShort());
            }
        }
    }
}
