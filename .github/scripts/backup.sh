#!/bin/bash
set -e

echo "🔍 Detecting affected features..."

# Get changed files compared to main
changed_files=$(git diff --name-only origin/main...HEAD)

feature_paths=()

for file in $changed_files; do
  # Normalize path (remove leading ./ or src/)
  normalized_file="${file#./}"
  normalized_file="${normalized_file#src/}"

  # 1️⃣ If file is in a feature folder → add it directly
  if [[ $file == src/features/* ]]; then
    feature_dir=$(echo "$file" | grep -oE "src/features/[^/]+")
    feature_paths+=("$feature_dir")
  fi

  # 2️⃣ If file is in components → find who depends on it
  if [[ $file == src/components/* ]]; then
    echo "📦 Shared component changed: $file"

    # Include its own test files
    component_dir=$(dirname "$file")
    feature_paths+=("$component_dir")

    # Find dependents via madge
    deps=$(npx madge --json src --extensions ts,tsx,js,jsx | jq -r --arg f "$normalized_file" '
      to_entries
      | map(select(.value | index($f)))
      | .[].key
    ')

    for dep in $deps; do
      if [[ $dep == features/* ]]; then
        feature_dir="src/$(echo "$dep" | grep -oE "features/[^/]+")"
        feature_paths+=("$feature_dir")
      fi
    done
  fi
done

# Remove duplicates
unique_features=($(printf "%s\n" "${feature_paths[@]}" | sort -u))

if [ ${#unique_features[@]} -eq 0 ]; then
  echo "✅ No affected features detected. Skipping tests."
  exit 0
fi

# Run tests for each affected feature or component
for feature in "${unique_features[@]}"; do
  echo "🧪 Running tests for $feature..."
  npx vitest run "$feature"
done

echo "✅ Done!"