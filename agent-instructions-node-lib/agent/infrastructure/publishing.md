# Publishing & Release
> Tags: publish, release, npm, versioning, package-json
> Scope: How the package is built, versioned, and published
> Last updated: [TICKET-ID or date]

## Version Location
- Location: `package.json` → `"version": "X.Y.Z"`
- Format: Semantic versioning (`MAJOR.MINOR.PATCH`)

## Semantic Versioning Rules
| Change Type | Version Bump | Examples |
|------------|:------------:|---------|
| Breaking API change | MAJOR (X) | Remove export, change return type, remove config option, change `exports` field |
| New feature (backward compatible) | MINOR (Y) | Add export, add config option, add error class |
| Bug fix (backward compatible) | PATCH (Z) | Fix behavior, improve error message, performance fix |

## package.json Key Fields
```json
{
  "name": "package-name",
  "version": "1.0.0",
  "description": "What this package does",
  "main": "./dist/index.cjs",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "import": "./dist/index.mjs",
      "require": "./dist/index.cjs",
      "types": "./dist/index.d.ts"
    }
  },
  "files": ["dist", "README.md", "LICENSE"],
  "engines": {
    "node": ">=18"
  },
  "sideEffects": false,
  "peerDependencies": {},
  "keywords": ["relevant", "keywords"]
}
```

### Critical Fields
- `name` — package name (scoped or unscoped)
- `version` — semver, source of truth
- `exports` — modern entry point resolution (ESM + CJS + types)
- `main` — CJS fallback for older bundlers
- `module` — ESM fallback for older bundlers
- `types` — TypeScript entry point
- `files` — whitelist of published files (keeps package small)
- `engines` — minimum Node.js version
- `sideEffects` — `false` enables tree-shaking in bundlers

## Release Process
```bash
# 1. Update version
npm version patch   # or minor / major
# This updates package.json and creates a git tag

# 2. Update CHANGELOG.md
# Add entry for new version with changes

# 3. Run full verification
npm test
npm run lint
npm run typecheck
npm run build

# 4. Test the package locally
npm pack
# Creates package-name-X.Y.Z.tgz
# Install in a test project:
npm install /path/to/package-name-X.Y.Z.tgz

# 5. Verify ESM and CJS imports
node -e "import('package-name').then(m => console.log(Object.keys(m)))"
node -e "console.log(Object.keys(require('package-name')))"

# 6. Publish to npm (DANGER ZONE — requires human approval)
npm publish
# For scoped packages: npm publish --access public

# 7. Push tag
git push origin vX.Y.Z
```

## CHANGELOG.md Format
```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New feature description

### Changed
- Changed behavior description

### Fixed
- Bug fix description

### Deprecated
- Deprecated feature (will be removed in vX+1.0.0)

### Removed
- Removed feature (was deprecated in vX-1.Y.Z)
```

## Danger Zones (hard stop, ask first)
- Publishing to npm (`npm publish`)
- Major version bumps
- Changing `engines.node` (minimum Node.js version)
- Modifying `exports` field (can break consumer imports)
- Changing package name or scope
- Adding/removing `peerDependencies`

## Changelog
<!-- [PROJ-123] Added dual ESM/CJS output via tsup -->
