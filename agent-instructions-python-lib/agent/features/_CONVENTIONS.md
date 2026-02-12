# Feature Implementation Conventions
> Tags: conventions, testing, patterns, fixtures
> Scope: Patterns to follow when implementing any feature in the package
> Last updated: [TICKET-ID or date]

## Module Structure
```python
# src/package_name/feature_name.py (or _feature_name.py if private)
"""Feature module docstring describing purpose."""

from __future__ import annotations

from typing import Any

from package_name.exceptions import PackageNameError


def public_function(data: str) -> Result:
    """Public function with full docstring, type hints, and tests."""
    ...
```

## Configuration Pattern
```python
# If the feature adds config options:
from dataclasses import dataclass, field

@dataclass
class Config:
    """Package configuration."""
    feature_option: str = "default_value"
    timeout: int = 30
    retries: int = 3
```

## Docstring Convention (Google style)
```python
def process(input_data: str, *, timeout: int = 30) -> Result:
    """Process the input data and return a structured result.

    Args:
        input_data: The raw data to process.
        timeout: Maximum seconds to wait. Defaults to 30.

    Returns:
        A Result object containing the processed output.

    Raises:
        PackageNameError: If processing fails.
        ValidationError: If input_data is empty.

    Examples:
        >>> result = process("hello")
        >>> result.success
        True
    """
```

## Test Data and Fixtures
```python
# tests/conftest.py
import pytest
from package_name import Config, Client


@pytest.fixture
def config():
    """Provide a default test configuration."""
    return Config(api_key="test_key", timeout=5)


@pytest.fixture
def client(config):
    """Provide a configured client instance."""
    return Client(config=config)


@pytest.fixture
def sample_data():
    """Provide sample input data for tests."""
    return {"key": "value", "count": 42}
```

## Unit Test Pattern
```python
# tests/test_feature_name.py
"""Tests for feature_name module."""

import pytest
from package_name import process
from package_name.exceptions import ValidationError


class TestProcess:
    """Tests for the process function."""

    def test_valid_input(self):
        """Process returns successful result for valid input."""
        result = process("hello")
        assert result.success is True
        assert result.data is not None

    def test_empty_input_raises(self):
        """Process raises ValidationError for empty input."""
        with pytest.raises(ValidationError, match="must not be empty"):
            process("")

    def test_none_input_raises(self):
        """Process raises ValidationError for None input."""
        with pytest.raises(ValidationError):
            process(None)

    @pytest.mark.parametrize(
        "input_data,expected",
        [
            ("hello", "HELLO"),
            ("world", "WORLD"),
            ("test", "TEST"),
        ],
    )
    def test_parametrized(self, input_data, expected):
        """Process transforms input correctly."""
        result = process(input_data)
        assert result.data == expected
```

## Mocking External Dependencies
```python
# tests/test_client.py
from unittest.mock import patch, MagicMock

import pytest
from package_name import Client
from package_name.exceptions import ConnectionError


class TestClient:
    """Tests for Client with mocked external calls."""

    @patch("package_name._core.httpx.get")
    def test_successful_request(self, mock_get, client):
        """Client returns data on successful HTTP request."""
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.json.return_value = {"result": "ok"}
        mock_get.return_value = mock_response

        result = client.fetch("resource-id")
        assert result == {"result": "ok"}

    @patch("package_name._core.httpx.get")
    def test_connection_error(self, mock_get, client):
        """Client raises ConnectionError on network failure."""
        import httpx
        mock_get.side_effect = httpx.ConnectError("connection refused")

        with pytest.raises(ConnectionError, match="Failed to connect"):
            client.fetch("resource-id")
```

## Conftest Patterns
```python
# tests/conftest.py - shared fixtures across all tests

import pytest


@pytest.fixture(autouse=True)
def reset_config():
    """Reset package configuration before each test."""
    import package_name
    package_name._config.reset()
    yield
    package_name._config.reset()


@pytest.fixture
def tmp_config_file(tmp_path):
    """Create a temporary config file."""
    config_file = tmp_path / "config.toml"
    config_file.write_text('[settings]\ntimeout = 10\n')
    return config_file
```

## Markers
```python
# pyproject.toml
# [tool.pytest.ini_options]
# markers = [
#     "slow: marks tests as slow (deselect with '-m \"not slow\"')",
#     "integration: marks integration tests",
# ]

@pytest.mark.slow
def test_large_dataset():
    """Test with large dataset (slow)."""
    ...

@pytest.mark.integration
def test_end_to_end():
    """Full integration test."""
    ...
```

## Changelog
<!-- Update when conventions change -->
