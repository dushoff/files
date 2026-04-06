
#!/bin/bash
# Usage: ./make_no_symbol.sh input.webp output.png
# Removes dark background from a golden object and composites it
# inside a red international "no" (prohibition) symbol.

INPUT="${1:-input.webp}"
OUTPUT="${2:-output.png}"
SIZE=800          # output canvas size (square)
FUZZ="30%"        # background-removal tolerance — increase if BG isn't fully removed
STROKE=80         # thickness of the red circle ring and slash bar

TMP=$(mktemp -d)

echo "Step 1: Remove dark background from golden object..."
convert "$INPUT" \
  -fuzz "$FUZZ" \
  -transparent black \
  -resize "${SIZE}x${SIZE}" \
  "$TMP/object_nobg.png"

echo "Step 2: Draw the red prohibition circle (ring only)..."
convert -size "${SIZE}x${SIZE}" xc:none \
  -fill none \
  -stroke red \
  -strokewidth "$STROKE" \
  -draw "circle $((SIZE/2)),$((SIZE/2)) $((SIZE/2 - STROKE/2)),0" \
  "$TMP/circle.png"

echo "Step 3: Draw the red diagonal slash bar..."
# The slash goes from top-right to bottom-left (standard prohibition symbol)
# Angled at ~45°: from (75%,10%) to (25%,90%)
convert -size "${SIZE}x${SIZE}" xc:none \
  -fill red \
  -stroke red \
  -strokewidth "$STROKE" \
  -draw "line $((SIZE*3/4)),$((SIZE/10)) $((SIZE/4)),$((SIZE*9/10))" \
  "$TMP/slash.png"

echo "Step 4: Combine — object sits BEHIND slash but inside circle..."
# Layer order (bottom to top): object → slash → circle ring
convert "$TMP/object_nobg.png" \
  "$TMP/slash.png" -composite \
  "$TMP/circle.png" -composite \
  "$OUTPUT"

echo "Done! Output saved to: $OUTPUT"
rm -rf "$TMP"
