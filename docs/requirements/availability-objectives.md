# P0-027 - Define availability objectives

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Definition and target

Target **99.9% useful-operation availability in a declared rolling 30-day window** for the advanced isolated lab. This is a learning objective, not an SLA, production claim, or promise that a developer workstation is continuously running.

Report two request-based indicators: (1) valid synthetic requests receiving the expected acceptance/publication result within 1 second, and (2) all-success scenario requests whose two branch outcomes are observed within 5 seconds at baseline. Divide qualifying successes by all attempted eligible operations in the declared window; include connectivity errors, timeouts and missing outcomes as failures. Expected business rejections belong to a separately defined scenario, not a way to remove technical failures from the baseline denominator.

Also report stage-specific availability/progress, especially when Payment is unavailable but Inventory continues. Health probes alone are insufficient. Peak performance remains separately defined in P0-026.

A time-based illustration for 30 days is 2,592,000 seconds x 0.001 = 2,592 seconds, or **43.2 minutes** unavailable. This time budget is not interchangeable with the request-based error fraction under nonuniform traffic. To report a time indicator, define the probe cadence, success deadline and interval classification and retain coverage evidence.

Declare maintenance/fault exclusions before a run and report gross plus adjusted indicators if any exclusions are used. Single-broker and intentionally stopped local experiments are expected to expose availability limits. Short-window results do not prove 30-day attainment. P12 validates failures/recovery and P10 supplies observations; no continuous monitoring or availability measurement occurred in P0.

## Evidence

See [task learning record](../learning-notes/P0/P0-027.md) and [document review](../testing/evidence/P0-027-review.md).
