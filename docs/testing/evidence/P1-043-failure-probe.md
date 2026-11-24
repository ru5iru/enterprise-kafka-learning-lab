# P1-043 isolated hosted failure probe

This branch intentionally sets the tooling unit expectation to Java 99 while running the pinned Java 25 runtime. The expected result is a failed unit assertion/job, a successful failure-summary step, and a retained sanitized failure report plus summary. This is an experiment, not an implementation defect or a completed application test. Do not merge this probe branch. The normal ci/P1-043-failure-reporting branch has no injection; its final learning note records actual run links and restoration evidence. No secret, service or data is involved.

Command injected only here: `bash scripts/wsl/lab.sh mvn -Dprobe.expectedJava=99 clean verify`.
