---
description: Audit research progress, review literature, apply research principles, and maintain bibliography.
argument-hint: "[path or scope]"
---

# Research Review

Perform a structured review of research progress, methodology, and literature coverage.

## Usage

`review-research [path]` — defaults to the full repository.

## Steps

### 1. Research Progress Audit

Examine code, experimental artifacts, and documentation for research status:

- **Experiment tracking**: Are experiments documented with hypotheses, methods, results, and interpretations? Are results machine-readable (JSON/CSV) with run metadata (git hash, timestamp, parameters, versions)?
- **Reproducibility**: Are seeds fixed? Can someone re-run from a clean checkout and get the same numbers?
- **Result validity**: Do measurements test the hypothesis or the infrastructure? Would the metric give a different answer if the hypothesis were false? (See Principle 5 below.)
- **Constraint migration**: Has the binding constraint shifted since the last checkpoint? Is current work targeting the actual bottleneck, or an old one?
- **Decision log**: Are pivots, abandonments, and their rationale documented? Can a new contributor understand *why* the current approach was chosen?

### 2. Literature Review

Research relevant literature, both referenced in the project and external:

- **Referenced works**: Read any bibliography, citations, `.bib` files, or paper references. Verify they're correctly attributed, relevant, and up to date.
- **Missing references**: Search for recent work (last 2 years) addressing similar problems, methods, or baselines. Check arXiv, Semantic Scholar, and Google Scholar. Prioritize work from top venues in the project's area.
- **Comparison class**: Identify the strongest competing approaches. Are the right baselines being compared against? Would a skeptical reviewer accept the comparison class?
- **Missed connections**: Are there adjacent fields or techniques the project could draw from? Look for work that solves a structurally similar problem in a different domain.

### 3. Research Principles Assessment

**If the project has `.agents/research-principles.md`, load and apply those principles directly.** Project-specific principles take precedence over the defaults below.

Otherwise, assess against these general research reasoning principles (adapted from the "de-risk before building" framework):

1. **Mechanism vs. Implementation** — Is each component necessary for the result, or incidental? Could the core mechanism transfer beyond this project? *Anti-pattern: implementing a paper's architecture verbatim without knowing which pieces carry the result.*

2. **Binding Constraint** — Is work targeting the single bottleneck that determines success or failure? Has the constraint migrated since the last check? *Anti-pattern: building infrastructure before testing whether the core idea has signal.*

3. **Comparison Class** — Would a skeptical reviewer accept the baselines and evaluation? Are evaluations designed on tasks where baselines are expected to do well? Where do baselines structurally fail? *Anti-pattern: designing evaluations where only your method can succeed.*

4. **Minimal Informative Experiment** — Is the next experiment the smallest test that would be informative? On a null result, are possible explanations enumerated before scaling up? *Anti-pattern: "I need to build X, Y, and Z before I can test anything."*

5. **Mind-Changers (Measurement Validity)** — Are pivot and abandon conditions pre-registered? Are null results honestly evaluated? Two validity checks: (a) does the metric test the hypothesis or the infrastructure? (b) does the data have the properties the test requires? *Anti-pattern: getting a bad result and rationalizing why it "doesn't really count."*

6. **Narrative Arc** — Does the work tell a story that shifts beliefs? Is a sub-narrative already publishable from current results? *Anti-pattern: building a technically impressive system without a clear "why anyone should care."*

7. **External Signal** — If stuck or surprised, has external input been sought? Reading groups, targeted emails, public write-ups? *Anti-pattern: working in isolation until a "complete" result is ready.*

For each principle, assess: **On track** / **At risk** / **Violated**, with specific evidence from the project.

### 4. Bibliography Maintenance

Update or create `docs/BIBLIOGRAPHY.md`:

1. Collect all references from code comments, docstrings, READMEs, experiment reports, and any existing bibliography files.
2. If a `.bib` file exists (e.g., `paper/references.bib`), treat it as the authoritative source. Sync `BIBLIOGRAPHY.md` from it — don't duplicate entries, reference the `.bib` file for full citation data.
3. For each entry, include: authors, title, venue/year, and a one-line note on its relevance to this project.
4. Add any new references discovered during the literature review (Step 2).
5. Organize by topic/relevance, not alphabetically.
6. If `docs/BIBLIOGRAPHY.md` doesn't exist, create it. If `docs/` doesn't exist, create it.

### 5. Multi-Agent Review

After completing your own analysis, check for other installed AI agents and dispatch them for independent assessment. Different models catch different things — especially valuable for literature search (broader coverage) and methodology critique (different reasoning biases).

1. Detect available agents (skip the one currently executing):

   ```bash
   which claude 2>/dev/null && echo "claude available"
   which codex 2>/dev/null && echo "codex available"
   which gemini 2>/dev/null && echo "gemini available"
   ```

2. For each available agent, dispatch focused sub-tasks:

   | Agent | Command |
   |-------|---------|
   | Claude Code | `claude -p "You are reviewing a research project at $(pwd). Do TWO things: (1) Search for recent papers (last 2 years) related to [project's key topics]. List author, title, venue, year, and one-line relevance. (2) Assess the experimental methodology for validity issues. Be concise."` |
   | Codex CLI | `codex exec "You are reviewing a research project at $(pwd). Do TWO things: (1) Search for recent papers (last 2 years) related to [project's key topics]. List author, title, venue, year, and one-line relevance. (2) Assess the experimental methodology for validity issues. Be concise."` |
   | Gemini CLI | `gemini -p "You are reviewing a research project at $(pwd). Do TWO things: (1) Search for recent papers (last 2 years) related to [project's key topics]. List author, title, venue, year, and one-line relevance. (2) Assess the experimental methodology for validity issues. Be concise."` |

3. Synthesize findings:
   - **Literature**: Deduplicate references across agents. Papers found by multiple agents are higher confidence.
   - **Methodology**: Note where agents agree on issues (strong signal) vs. disagree (investigate further).
   - Merge any new references into the bibliography (Step 4).

## Output

Structure the report as:

1. **Progress Summary** — Where the research stands, what's been validated, what's open.
2. **Principle Assessment** — Table: Principle | Status | Evidence | Recommendation.
3. **Literature Gaps** — Missing references and why they matter. Note which agent(s) found each.
4. **Bibliography Updates** — What was added or corrected in `docs/BIBLIOGRAPHY.md`.
5. **Recommendations** — Prioritized next steps, clearly distinguishing pivots (change approach) from incremental improvements (continue current approach).

## Composability

If the codebase would benefit from a structural quality review alongside research assessment, also run `review-code` on the same scope for analysis of code organization, test gaps, performance, and observability.
