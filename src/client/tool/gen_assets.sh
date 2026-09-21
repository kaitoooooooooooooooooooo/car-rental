#!/usr/bin/env bash

set -euo pipefail

BLOCK=$(find assets -type f -not -name '.*' \
  | sed 's|/[^/]*$|/|' \
  | sort -u \
  | sed 's|^|    - |')

python - "$BLOCK" <<'PY'
import re, sys
block = sys.argv[1]
src = open('pubspec.yaml', encoding='utf-8').read()
new = re.sub(
    r'(?m)^  assets:\n(?:^(?:    - .*|\s*)\n)*',
    '  assets:\n' + block + '\n\n',
    src, count=1)
open('pubspec.yaml', 'w', encoding='utf-8').write(new)
PY
echo "pubspec.yaml mis a jour."
