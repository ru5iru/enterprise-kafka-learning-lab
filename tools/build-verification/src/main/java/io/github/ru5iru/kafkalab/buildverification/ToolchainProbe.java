package io.github.ru5iru.kafkalab.buildverification;

/** Small build fixture; no service or business behavior. */
public final class ToolchainProbe {
    private ToolchainProbe() {}

    public static int runtimeFeature() {
        return Runtime.version().feature();
    }
}
