#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_NAME="context-hub"
PACKAGE_MANAGER="npm"
FORMAT_CMD=""
LINT_CMD=""
BUILD_CMD=""
TEST_CMD=""

GREEN='[0;32m'
RED='[0;31m'
YELLOW='[1;33m'
NC='[0m'
PASS=0
FAIL=0
SKIP=0

run_gate() {
  local label="$1"
  local cmd="$2"
  printf "  %-20s ... " "$label"
  if (cd "$PROJECT_ROOT" && eval "$cmd") >/dev/null 2>&1; then
    printf "${GREEN}PASS${NC}
"
    PASS=$((PASS + 1))
  else
    printf "${RED}FAIL${NC}
"
    FAIL=$((FAIL + 1))
  fi
}

skip_gate() {
  local label="$1"
  local reason="$2"
  printf "  %-20s ... %sSKIP%s (%s)
" "$label" "$YELLOW" "$NC" "$reason"
  SKIP=$((SKIP + 1))
}

echo ""
echo "=== $PROJECT_NAME QA Gates ==="
echo ""

if ! command -v "$PACKAGE_MANAGER" >/dev/null 2>&1; then
  skip_gate "toolchain" "$PACKAGE_MANAGER not installed"
  echo ""
  echo "=== Results ==="
  echo -e "  ${GREEN}PASS: $PASS${NC}  ${YELLOW}SKIP: $SKIP${NC}  ${RED}FAIL: $FAIL${NC}"
  echo ""
  exit 0
fi

if [[ ! -d "$PROJECT_ROOT/node_modules" ]]; then
  skip_gate "dependencies" "node_modules missing"
fi

if [[ -n "$FORMAT_CMD" ]]; then
  if [[ -d "$PROJECT_ROOT/node_modules" ]]; then run_gate "format" "$FORMAT_CMD"; else skip_gate "format" "node_modules missing"; fi
else
  skip_gate "format" "no format command"
fi
if [[ -n "$LINT_CMD" ]]; then
  if [[ -d "$PROJECT_ROOT/node_modules" ]]; then run_gate "lint" "$LINT_CMD"; else skip_gate "lint" "node_modules missing"; fi
else
  skip_gate "lint" "no lint command"
fi
if [[ -n "$BUILD_CMD" ]]; then
  if [[ -d "$PROJECT_ROOT/node_modules" ]]; then run_gate "build" "$BUILD_CMD"; else skip_gate "build" "node_modules missing"; fi
else
  skip_gate "build" "no build command"
fi
if [[ -n "$TEST_CMD" ]]; then
  if [[ -d "$PROJECT_ROOT/node_modules" ]]; then run_gate "test" "$TEST_CMD"; else skip_gate "test" "node_modules missing"; fi
else
  skip_gate "test" "no test command"
fi

echo ""
echo "=== Results ==="
echo -e "  ${GREEN}PASS: $PASS${NC}  ${YELLOW}SKIP: $SKIP${NC}  ${RED}FAIL: $FAIL${NC}"
echo ""

if [[ "$FAIL" -gt 0 ]]; then
  exit 1
fi
