#!/usr/bin/env python3
"""Reject empty, failed or skipped tooling test suites without printing payloads."""
import sys
import xml.etree.ElementTree as ET
from pathlib import Path


def verify(target):
    for directory in ("surefire-reports", "failsafe-reports"):
        reports = sorted((target / directory).glob("TEST-*.xml"))
        if not reports:
            raise ValueError(f"Missing JUnit XML: {directory}")
        totals = {key: 0 for key in ("tests", "failures", "errors", "skipped")}
        for report in reports:
            suite = ET.parse(report).getroot()
            if suite.tag != "testsuite":
                raise ValueError(f"Unexpected JUnit root: {directory}")
            for key in totals:
                value = int(suite.attrib[key])
                if value < 0:
                    raise ValueError(f"Negative JUnit count: {directory}")
                totals[key] += value
        if totals["tests"] < 1 or any(totals[k] for k in ("failures", "errors", "skipped")):
            raise ValueError(f"Empty, failing or skipped suite: {directory}")
        print(f"PASS: {directory}: {totals['tests']} tests, zero failures/errors/skips")


if __name__ == "__main__":
    verify(Path(sys.argv[1] if len(sys.argv) == 2 else "tools/build-verification/target"))
