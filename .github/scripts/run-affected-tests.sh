changed_files=$(git diff --name-only origin/main...HEAD)
feature_paths=()
for file in $changed_files; do
  if [[ $file == src/features/featureA/* ]]; then
    feature_paths+=("src/features/featureA")
  elif [[ $file == src/features/featureB/* ]]; then
    feature_paths+=("src/features/featureB")
  fi
done

# remove duplicates
feature_paths=($(echo "${feature_paths[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

# run tests only on changed features
npx vitest run ${feature_paths[@]}