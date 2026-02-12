# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common tasks -- saves agents from re-discovering patterns
> Last updated: [TICKET-ID or date]

## Quick Reference
| Task | Prompt |
|------|--------|
| New Public Class/Method | `plan library for TICKET-ID` then use "New Public Class/Method" below |
| New Module / Package | Use "New Module / Package" prompt below |
| Bug Fix | `plan library for TICKET-ID` then use "Bug Fix" below |
| Configuration Change | Use "Configuration Change" prompt below |
| Dependency Change | Use "Dependency Change" prompt below |
| Error Handling | Use "Error Handling" prompt below |
| Refactor | Use "Refactor" prompt below |
| Version Bump / Release | Use "Version Bump / Release" prompt below |

---

## New Public Class/Method
```
Add a new public class/method:
- Package: [com.example.lib.api]
- Class: [ClassName]
- Method: [methodName]
- Params: [list with types]
- Returns: [return type]
- Throws: [exception classes]

Before implementing, read context-router.md → "New Public Class / Method" for full file list.

Create: class/method, Javadoc (@param, @return, @throws, @since), JUnit 5 tests.
Verify: mvn test -Dtest=ClassNameTest && mvn checkstyle:check && mvn javadoc:javadoc
```

## New Module / Package
```
Add a new module/package:
- Package: [com.example.lib.newpackage]
- Purpose: [what it does]
- Public classes: [list]
- Dependencies: [other packages it uses]

Before implementing, read context-router.md → "New Module / Package" for full file list.

Create: source files under src/main/java/, test files under src/test/java/.
Verify: mvn test && mvn checkstyle:check
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [class/package if known]

Before implementing, read context-router.md → "Bug Fix" for full file list.

Steps: reproduce → identify root cause → fix → add regression test.
Verify: mvn test -Dtest=[relevant tests] && mvn checkstyle:check
```

## Configuration Change
```
Add/modify configuration:
- Option: [config.optionName]
- Type: [String/boolean/int/Duration/etc.]
- Default: [default value]
- Purpose: [what it controls]

Before implementing, read context-router.md → "Configuration Change" for full file list.

Create: builder method, validation, Javadoc, tests.
Verify: mvn test -Dtest=ConfigTest && mvn checkstyle:check
```

## Dependency Change
```
Add/update/remove dependency:
- Artifact: [groupId:artifactId]
- Version: [version]
- Scope: [compile / test / provided]
- Justification: [why this dependency is needed]

Before implementing, read context-router.md → "Dependency Change" for full file list.
DANGER ZONE: runtime dependencies need justification.

Update: pom.xml/build.gradle, relevant source code.
Verify: mvn clean verify && mvn versions:display-dependency-updates
```

## Error Handling
```
Add/modify error handling:
- Exception class: [LibNameSpecificException]
- Extends: [LibNameException]
- Thrown when: [condition]
- Message: [default message template]

Before implementing, read context-router.md → "Error Handling Change" for full file list.

Create: exception class in exception/ package, tests, update documentation.
Verify: mvn test -Dtest=... && mvn checkstyle:check
```

## Refactor
```
Refactor:
- Target: [class/package/method]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md → "Refactor" for full file list.

Steps: ensure test coverage → refactor → verify tests still pass.
Verify: mvn clean verify
```

## Version Bump / Release
```
Prepare release:
- New version: [X.Y.Z]
- Bump type: [major/minor/patch]
- Changes: [summary of what changed]

Before implementing, read context-router.md → "Version Bump / Release" for full file list.
DANGER ZONE: publishing requires human approval.

Update: pom.xml/build.gradle version, CHANGELOG.md, verify build.
Verify: mvn clean verify && mvn javadoc:javadoc
```
