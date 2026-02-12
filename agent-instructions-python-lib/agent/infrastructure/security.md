# Security Rules
> Tags: security, validation, audit, safe-coding
> Scope: Security constraints agents must follow when developing the package
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never use `eval()` or `exec()` with user-provided input
- Never use `pickle.loads()` on untrusted data
- Never use `yaml.load()` on untrusted data (use `yaml.safe_load()`)
- Never use `subprocess` with `shell=True` and user-provided input
- Never hardcode secrets, API keys, or credentials in code
- Never log sensitive data (keys, tokens, passwords, PII)
- Never import untrusted modules dynamically (`importlib.import_module` with user input)
- Never use `os.system()` with user-controlled strings
- Never disable SSL verification (`verify=False`) in production code
- Never use `__import__()` with user input

## Always Do These
- Always validate and sanitize input at the package's public API boundary
- Always use `shlex.quote()` if shelling out is unavoidable
- Always use `pathlib.Path` for file operations (prevents path traversal)
- Always keep dependencies up to date (audit with `pip-audit`)
- Always use HTTPS for network calls
- Always set timeouts on network operations
- Always use `secrets` module for cryptographic randomness (not `random`)
- Always validate file paths against allowed directories

## Input Validation
```python
# CORRECT: validate at the public API boundary
def process(input_data: str, *, timeout: int = 30) -> Result:
    if not isinstance(input_data, str):
        raise ValidationError(
            f"input_data must be a str, got {type(input_data).__name__}"
        )
    if not input_data.strip():
        raise ValidationError("input_data must not be empty")
    if timeout <= 0:
        raise ValidationError(f"timeout must be positive, got {timeout}")
    return _do_process(input_data, timeout=timeout)

# WRONG: trust user input
def process(input_data):
    eval(input_data)  # NEVER
```

## Safe Subprocess Usage
```python
import subprocess
import shlex

# CORRECT: list args, no shell
result = subprocess.run(
    ["command", "--flag", shlex.quote(user_input)],
    capture_output=True,
    text=True,
    timeout=30,
)

# WRONG: shell=True with user input
result = subprocess.run(
    f"command --flag {user_input}",
    shell=True,  # DANGEROUS
)
```

## Safe File Operations
```python
from pathlib import Path

# CORRECT: use pathlib, validate against allowed base
def read_config(config_name: str) -> str:
    base = Path("/etc/package_name")
    path = (base / config_name).resolve()
    if not path.is_relative_to(base):
        raise ValidationError(f"Path traversal detected: {config_name}")
    return path.read_text()

# WRONG: string concatenation for paths
def read_config(config_name):
    with open("/etc/package_name/" + config_name) as f:
        return f.read()
```

## Safe Serialization
```python
import json
import yaml

# CORRECT: use json or yaml.safe_load
data = json.loads(raw_json)
data = yaml.safe_load(raw_yaml)

# WRONG: pickle or yaml.load on untrusted data
import pickle
data = pickle.loads(untrusted_bytes)  # NEVER
data = yaml.load(untrusted_yaml)      # NEVER (use safe_load)
```

## Dependency Auditing
```bash
# Check for known vulnerabilities in dependencies
pip-audit

# Keep packages up to date
pip list --outdated

# Verify package integrity
pip install --require-hashes -r requirements.txt
```

## HTTP/Network Security
- Always use HTTPS, not HTTP
- Always set timeouts on HTTP connections
- Always validate SSL certificates (do not set `verify=False`)
- Never interpolate user input into URLs without proper encoding
```python
import httpx
from urllib.parse import quote

# CORRECT
response = httpx.get(
    f"https://api.example.com/items/{quote(item_id)}",
    timeout=30,
)

# WRONG
response = httpx.get(
    f"http://api.example.com/items/{item_id}",  # HTTP, unencoded
    verify=False,  # NEVER
)
```

## Logging Security
```python
import logging

logger = logging.getLogger(__name__)

# CORRECT: log operation, not sensitive data
logger.info("Authenticated user successfully")
logger.debug("Processing request for resource %s", resource_id)

# WRONG: log sensitive data
logger.info("API key: %s", api_key)       # NEVER
logger.debug("Password: %s", password)     # NEVER
```

## Changelog
<!-- [PROJ-123] Added input validation for all public functions -->
