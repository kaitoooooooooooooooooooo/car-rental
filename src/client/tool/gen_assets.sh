#!/usr/bin/env bash
# Regenere la section `assets:` du pubspec.yaml.
# Flutter n'inclut pas les sous-dossiers de maniere recursive : chaque dossier
# contenant des fichiers doit etre declare explicitement.
# Usage : bash tool/gen_assets.sh   (depuis src/client)
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
