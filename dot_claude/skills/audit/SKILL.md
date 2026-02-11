---
description: Run a security and code quality audit on the specified files or directory.
argument-hint: "[path]"
---

# Audit

Run a security and code quality audit on the specified files or directory.

## Usage

`/audit [path]` — defaults to the current app if no path is given.

Do NOT run commands until user confirms scope.

## Steps

### 1. Security Review

For each API route and server-side file in scope:

- **Authentication**: Are endpoints protected? Can unauthenticated users reach sensitive operations?
- **Authorization**: Are admin/role checks enforced server-side (not just client-side)?
- **Input validation**: Is user input sanitized? Check for path traversal, injection, and unexpected types.
- **Secrets exposure**: Are server-only env vars accessed through `SERVER_ENV`? Are any secrets leaked to the client via `NEXT_PUBLIC_` or inline in responses?
- **OWASP top 10**: Check for command injection, XSS, SSRF, open redirects, and other common vulnerabilities.

Classify each finding as **Critical**, **High**, **Medium**, or **Low**.

### 2. Code Quality Review

For each file in scope:

- **Dead code**: Unused imports, unreachable branches, commented-out code.
- **Error handling**: Are errors caught and handled appropriately? Are catch blocks swallowing errors silently?
- **Type safety**: Use of `as any`, non-null assertions (`!`), and unvalidated type casts.
- **Consistency**: Does the code follow the patterns established in the rest of the codebase?
- **Complexity**: Overly nested logic, functions doing too many things, missing early returns.

### 3. Lint & Tests

After completing the manual reviews above:

- Run the project linter (e.g. `pnpm biome check .` from the app root).
- Run the project test suite (e.g. `pnpm --filter <app> test`).
- Report any failures, distinguishing pre-existing failures from ones related to files in scope.

## Output

Produce a summary table with columns: **Severity**, **File**, **Line(s)**, **Finding**, **Recommendation**.

Group by severity (Critical > High > Medium > Low), then by file.
