changed_files=$(git diff --name-only origin/main...HEAD)
echo "changed_files: $changed_files"

feature_paths=()
for file in $changed_files; do
  if [[ $file == src/features/featureA/* ]]; then
    feature_paths+=("src/features/featureA")
  elif [[ $file == src/features/featureB/* ]]; then
    feature_paths+=("src/features/featureB")
  fi
done

echo "feature_paths: $feature_paths"

# remove duplicates
feature_paths=($(echo "${feature_paths[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

echo "feature_paths: $feature_paths"

# Run tests if there are affected features
if [ ${#feature_paths[@]} -eq 0 ]; then
  echo "No feature-specific tests to run. Skipping."
else
  echo "Running tests for features: ${feature_paths[@]}"
  npx vitest run ${feature_paths[@]}
fi