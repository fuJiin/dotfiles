---
description: Audit codebase for organization, extensibility, maintainability, test/CI gaps, performance, and observability.
argument-hint: "[path or scope]"
---

# Code Review

Perform a structured code review covering architecture, quality, and operational readiness.

## Usage

`review-code [path]` — defaults to the full repository if no path is given.

## Steps

### 1. Structural Review

Audit the codebase organization:

- **Module boundaries**: Are responsibilities clearly separated? Are there circular dependencies or god modules?
- **Extensibility**: Can new features be added without modifying existing code? Are extension points discoverable?
- **Maintainability**: Is the code readable by someone unfamiliar with it? Are naming conventions consistent?
- **Abstraction quality**: Are abstractions justified by usage, or premature? Are there missing abstractions that cause duplication?
- **Dependency health**: Are dependencies up to date? Are there abandoned, vendored, or unnecessarily heavy packages?

### 2. Test, Lint & CI Gaps

- **Test coverage**: Identify untested critical paths — semantic coverage, not just line coverage. Focus on code that handles money, auth, state transitions, and external integrations.
- **Test quality**: Are tests verifying behavior or implementation details? Flag brittle mocks, snapshot overuse, and tests that pass vacuously.
- **Lint configuration**: Is the linter configured and enforced? Are there unaddressed warnings or disabled rules?
- **CI pipeline**: Does CI run tests, lint, type checking, and security scanning? Identify gaps (e.g., no integration tests, no dependency audit, no build verification).
- **Missing infrastructure**: Pre-commit hooks, formatting enforcement, branch protection, release automation.

### 3. Performance

Focus on high-ROI improvements — cheap to fix, meaningfully impactful:

- **Hot paths**: Code that runs frequently or processes large data. Look for N+1 queries, unnecessary serialization, redundant computation, unbounded collection growth.
- **Resource management**: Connection pooling, large allocations in loops, missing caches, leaked file handles.
- **Startup time**: Synchronous initialization that could be lazy or parallel.
- **Bundle/binary size**: Large dependencies imported for small functionality. Tree-shaking opportunities.

### 4. Observability

- **Logging**: Is there structured logging? Are errors logged with context (request ID, user, operation)? Is there log level discipline?
- **Metrics**: Are key operations instrumented for latency, error rate, and throughput?
- **Tracing**: Is distributed tracing in place for cross-service paths?
- **Alerting readiness**: Could an oncall engineer diagnose a production failure from current instrumentation alone?
- **Health checks**: Readiness and liveness probes. Dependency health visibility.

### 5. Multi-Agent Review

After completing your own analysis, check for other installed AI agents and dispatch them for independent review of the same scope. This surfaces findings your model may miss.

1. Detect available agents (skip the one currently executing):

   ```bash
   which claude 2>/dev/null && echo "claude available"
   which codex 2>/dev/null && echo "codex available"
   which gemini 2>/dev/null && echo "gemini available"
   ```

2. For each available agent, dispatch a focused review of the same path/scope:

   | Agent | Command |
   |-------|---------|
   | Claude Code | `claude -p "Review this codebase for: (1) structural issues, (2) test/CI gaps, (3) performance wins, (4) observability gaps. Working directory: $(pwd). Scope: [path]. Be concise — findings table only."` |
   | Codex CLI | `codex exec "Review this codebase for: (1) structural issues, (2) test/CI gaps, (3) performance wins, (4) observability gaps. Working directory: $(pwd). Scope: [path]. Be concise — findings table only."` |
   | Gemini CLI | `gemini -p "Review this codebase for: (1) structural issues, (2) test/CI gaps, (3) performance wins, (4) observability gaps. Working directory: $(pwd). Scope: [path]. Be concise — findings table only."` |

3. Synthesize all findings:
   - **Consensus findings** (multiple agents agree) — high confidence, flag these prominently.
   - **Unique findings** — one agent found something others missed. Verify before including.
   - **Conflicts** — agents disagree. Investigate and resolve, noting the disagreement.

## Output

For each finding, report:

| Field | Description |
|-------|-------------|
| **Impact** | High / Medium / Low |
| **Effort** | Low / Medium / High |
| **Location** | File and line range |
| **Finding** | What's wrong or missing |
| **Recommendation** | Specific, actionable fix |
| **Source** | Which agent(s) identified this |

Group by section. Within each section, lead with quick wins (high impact, low effort). Mark consensus findings.

## Composability

If the project contains research artifacts (experiment scripts, results, papers, `.agents/research-principles.md`), also run `review-research` on the same scope for complementary methodology-focused analysis.
