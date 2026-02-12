# Publishing & Release
> Tags: publish, release, maven-central, versioning, pom
> Scope: How the library is built, versioned, and published
> Last updated: [TICKET-ID or date]

## Version Location
- **Maven**: `pom.xml` → `<version>X.Y.Z</version>` (or `<version>X.Y.Z-SNAPSHOT</version>`)
- **Gradle**: `build.gradle` → `version = 'X.Y.Z'`
- Format: Semantic versioning `MAJOR.MINOR.PATCH`

## Semantic Versioning Rules
| Change Type | Version Bump | Examples |
|------------|:------------:|---------|
| Breaking API change | MAJOR (X) | Remove public method, change return type, remove config option, change exception hierarchy |
| New feature (backward compatible) | MINOR (Y) | Add public method, add config option, add exception class |
| Bug fix (backward compatible) | PATCH (Z) | Fix behavior, improve error message, performance fix |

## Maven Central Requirements (pom.xml)
```xml
<groupId>com.example</groupId>
<artifactId>lib-name</artifactId>
<version>1.0.0</version>
<packaging>jar</packaging>

<name>Library Name</name>
<description>Brief description of the library</description>
<url>https://github.com/owner/lib-name</url>

<licenses>
    <license>
        <name>The Apache License, Version 2.0</name>
        <url>https://www.apache.org/licenses/LICENSE-2.0.txt</url>
    </license>
</licenses>

<developers>
    <developer>
        <name>Developer Name</name>
        <email>dev@example.com</email>
    </developer>
</developers>

<scm>
    <connection>scm:git:git://github.com/owner/lib-name.git</connection>
    <developerConnection>scm:git:ssh://github.com:owner/lib-name.git</developerConnection>
    <url>https://github.com/owner/lib-name</url>
</scm>
```

## GPG Signing
- Required for Maven Central
- Sign artifacts with GPG key
- Maven: `maven-gpg-plugin`
- Gradle: `signing` plugin

## Gradle Publishing (maven-publish plugin)
```groovy
plugins {
    id 'maven-publish'
    id 'signing'
}

publishing {
    publications {
        mavenJava(MavenPublication) {
            from components.java
            // pom configuration...
        }
    }
    repositories {
        maven {
            url = version.endsWith('SNAPSHOT')
                ? 'https://s01.oss.sonatype.org/content/repositories/snapshots/'
                : 'https://s01.oss.sonatype.org/service/local/staging/deploy/maven2/'
        }
    }
}
```

## Release Process
```bash
# 1. Update version (remove -SNAPSHOT)
# Edit pom.xml or build.gradle

# 2. Update CHANGELOG.md
# Add entry for new version

# 3. Run full verification
mvn clean verify                       # or ./gradlew clean build
mvn javadoc:javadoc                    # verify Javadoc generates cleanly
mvn checkstyle:check                   # verify lint passes
mvn spotbugs:check                     # verify static analysis passes

# 4. Build and sign
mvn clean deploy -P release            # Maven with release profile
# or
./gradlew publish                      # Gradle

# 5. Stage to Maven Central
# Artifacts go to Sonatype staging repository

# 6. Release (DANGER ZONE — requires human approval)
# Close and release staging repository via Sonatype OSSRH
# This is irreversible — published artifacts cannot be removed

# 7. Tag the release
git tag -a vX.Y.Z -m "Release vX.Y.Z"
git push origin vX.Y.Z

# 8. Bump to next SNAPSHOT version
# Edit pom.xml: X.Y.(Z+1)-SNAPSHOT
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
- Publishing to Maven Central (irreversible)
- Major version bumps
- Changing minimum Java version (`<maven.compiler.source>`)
- Modifying pom.xml/build.gradle metadata (groupId, artifactId, license)
- Adding/removing Maven Central required fields

## Changelog
<!-- [PROJ-123] Automated release via GitHub Actions -->
