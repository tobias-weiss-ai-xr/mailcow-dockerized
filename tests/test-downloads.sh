#!/bin/bash
# Test script for mailcow download links

BASE_URL="${1:-https://mail.tobias-weiss.org}"
FAILED=0
PASSED=0

echo "Testing download links at $BASE_URL"
echo "======================================"
echo

# Array of expected files
declare -a FILES=(
  "CoCreate-Werkstattgespraech-Digitale-Souveraenitaet_75dpi.pdf"
  "Dissertation_Tobias_Weiss.pdf"
  "Einladung zum Experiment.pdf"
  "Gradient Boosting Trees and XGBoost.pdf"
  "Interference Timing of GenAI Sales Agents in Virtual Reality.pdf"
  "Introduction to VR.pdf"
  "Invocation_Timing_HMM.pdf"
  "Poster_KAST_TobiasWeiss.pdf"
  "Poster_LabLinking_TobiasWeiss.pdf"
)

for file in "${FILES[@]}"; do
  url="$BASE_URL/downloads/$file"
  http_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

  if [ "$http_code" = "200" ]; then
    echo "✓ $file - $http_code"
    PASSED=$((PASSED + 1))
  else
    echo "✗ $file - $http_code (FAILED)"
    FAILED=$((FAILED + 1))
  fi
done

echo
echo "======================================"
echo "Results: $PASSED passed, $FAILED failed"

if [ $FAILED -gt 0 ]; then
  exit 1
fi

exit 0
