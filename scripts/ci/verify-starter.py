#!/usr/bin/env python3
"""Check the packaged starter, test discovery and fail-fast startup without raw logs."""
import os
import subprocess
import xml.etree.ElementTree as ET
from pathlib import Path
from zipfile import ZipFile


def verify():
    target = Path("applications/lab-starter/target")
    reports = list((target / "surefire-reports").glob("TEST-*.xml"))
    if not reports:
        raise ValueError("Starter test reports missing")
    total = 0
    for report in reports:
        suite = ET.parse(report).getroot()
        if suite.tag != "testsuite":
            raise ValueError("Unexpected starter report root")
        total += int(suite.attrib["tests"])
        if any(int(suite.attrib[key]) != 0 for key in ("failures", "errors", "skipped")):
            raise ValueError("Starter tests failed, errored or skipped")
    if total < 1:
        raise ValueError("No starter tests executed")
    print(f"PASS: starter context smoke test: {total} tests, zero failures/errors/skips")

    artifact = target / "lab-starter-0.1.0-SNAPSHOT.jar"
    with ZipFile(artifact) as jar:
        manifest = jar.read("META-INF/MANIFEST.MF").decode("utf-8")
        if "Start-Class: io.github.ru5iru.kafkalab.starter.LabStarterApplication" not in manifest:
            raise ValueError("Wrong starter main class")
        if "Main-Class: org.springframework.boot.loader.launch.JarLauncher" not in manifest:
            raise ValueError("Missing Boot launcher")
        bytecode = jar.read("BOOT-INF/classes/io/github/ru5iru/kafkalab/starter/LabStarterApplication.class")
        if bytecode[:4] != b"\xca\xfe\xba\xbe" or int.from_bytes(bytecode[6:8], "big") != 69:
            raise ValueError("Starter must target Java 25")
        libraries = [name for name in jar.namelist() if name.startswith("BOOT-INF/lib/")]
        if "BOOT-INF/lib/spring-boot-4.2.0.jar" not in libraries:
            raise ValueError("Wrong Spring Boot runtime version")
        forbidden = ("junit", "surefire", "tomcat", "jetty", "spring-web", "spring-kafka", "kafka-clients", "postgresql")
        if any(part in name for part in forbidden for name in libraries):
            raise ValueError("Unexpected test/web/Kafka/database runtime dependency")
    print("PASS: executable Boot 4.2.0 JAR, Java 25 bytecode, scoped runtime dependencies")

    java = Path(os.environ["JAVA_HOME"]) / "bin/java"
    command = [str(java), "-jar", str(artifact)]
    # The child inherits the Linux launcher environment; no shell interpolation or background server.
    success = subprocess.run(command, capture_output=True, text=True, timeout=30)
    if success.returncode != 0 or "Started LabStarterApplication" not in success.stdout:
        raise ValueError("Packaged starter did not start and exit successfully")
    print("PASS: packaged java -jar startup marker and normal exit within 30 seconds")

    failure = subprocess.run(command + ["--spring.main.banner-mode=invalid"],
                             capture_output=True, text=True, timeout=30)
    output = failure.stdout + failure.stderr
    if failure.returncode == 0 or "APPLICATION FAILED TO START" not in output or "invalid" not in output:
        raise ValueError("Malformed Boot option did not fail visibly")
    print("PASS: malformed banner-mode rejected with nonzero exit and startup failure diagnostic")


if __name__ == "__main__":
    verify()
