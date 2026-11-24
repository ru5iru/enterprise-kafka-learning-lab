#!/usr/bin/env python3
"""Publish test status without JVM properties, captured output or failure payloads."""
import xml.etree.ElementTree as ET
from pathlib import Path


def prepare(target):
    output = target / "ci-reports"
    output.mkdir(parents=True, exist_ok=True)
    count = 0
    for category in ("surefire-reports", "failsafe-reports"):
        for report in sorted((target / category).glob("TEST-*.xml")):
            source = ET.parse(report).getroot()
            if source.tag != "testsuite":
                raise ValueError("Unexpected test report root")
            clean = ET.Element("testsuite", {k: source.attrib[k] for k in
                ("name", "tests", "failures", "errors", "skipped", "time") if k in source.attrib})
            for case in source.findall("testcase"):
                child = ET.SubElement(clean, "testcase", {k: case.attrib[k] for k in
                    ("name", "classname", "time") if k in case.attrib})
                for state in ("failure", "error", "skipped"):
                    for outcome in case.findall(state):
                        ET.SubElement(child, state, {"type": outcome.attrib.get("type", state)})
            ET.ElementTree(clean).write(output / (category + "-" + report.name),
                encoding="utf-8", xml_declaration=True)
            count += 1
    print(f"Prepared {count} sanitized JUnit reports; no properties/output/failure text")
    return count


if __name__ == "__main__":
    prepare(Path("tools/build-verification/target"))
