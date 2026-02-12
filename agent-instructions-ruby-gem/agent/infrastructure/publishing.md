# Publishing & Release
> Tags: publish, release, rubygems, versioning, gemspec
> Scope: How the gem is built, versioned, and published
> Last updated: [TICKET-ID or date]

## Version File
- Location: `lib/gem_name/version.rb`
- Format: `VERSION = "X.Y.Z"` (semantic versioning)

## Semantic Versioning Rules
| Change Type | Version Bump | Examples |
|------------|:------------:|---------|
| Breaking API change | MAJOR (X) | Remove public method, change return type, remove config option |
| New feature (backward compatible) | MINOR (Y) | Add public method, add config option, add error class |
| Bug fix (backward compatible) | PATCH (Z) | Fix behavior, improve error message, performance fix |

## Gemspec
- File: `gem_name.gemspec`
- Key fields to maintain:
  - `spec.name` — gem name
  - `spec.version` — reads from `version.rb`
  - `spec.summary` / `spec.description`
  - `spec.authors` / `spec.email`
  - `spec.homepage` / `spec.metadata`
  - `spec.required_ruby_version`
  - `spec.add_dependency` — runtime deps
  - `spec.add_development_dependency` — dev deps

## Release Process
```bash
# 1. Update version
# Edit lib/gem_name/version.rb

# 2. Update CHANGELOG.md
# Add entry for new version

# 3. Run full verification
bundle exec rspec
bundle exec rubocop
yard stats --list-undoc

# 4. Build the gem
gem build gem_name.gemspec

# 5. Test the built gem
gem install gem_name-X.Y.Z.gem --local

# 6. Push to RubyGems (DANGER ZONE — requires human approval)
gem push gem_name-X.Y.Z.gem

# 7. Tag the release
git tag -a vX.Y.Z -m "Release vX.Y.Z"
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
- Publishing to RubyGems
- Major version bumps
- Changing `required_ruby_version`
- Modifying gemspec metadata (homepage, license, etc.)

## Changelog
<!-- [PROJ-123] Automated release via GitHub Actions -->
