#!/bin/bash

# Base branch להשוואה
BASE_BRANCH="origin/main"

# 1️⃣ קבצים שהשתנו
changed_files=$(git diff --name-only $BASE_BRANCH...HEAD)

echo "changed_files: $changed_files"

# 2️⃣ איסוף feature paths להרצה
feature_paths=()

# 3️⃣ לכל קובץ שהשתנה
for file in $changed_files; do
  # א. שינוי בקובץ feature
  if [[ $file == src/features/* ]]; then
    dir=$(dirname $file)
    feature_paths+=("$dir")
  fi

  # ב. שינוי בקובץ קומפוננטה משותפת
  if [[ $file == stories/* ]]; then
    echo "Found changed storybook file: $file"
    # בונה גרף תלויות
    deps=$(npx madge --json src | jq -r --arg f "$file" '
      to_entries
      | map(select(.value | index($f)))
      | .[].key
    ')

    echo "Found dependencies: $deps"
    # מוסיף את כל הפיצ׳רים שתלויים בקובץ
    for dep in $deps; do
      if [[ $dep == src/features/* ]]; then
        feature_paths+=("$dep")
      fi
    done
  fi
done

# 4️⃣ הסרת כפילויות
feature_paths=($(echo "${feature_paths[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

# 5️⃣ הרצת Vitest אם יש פיצ׳רים שנפגעו
if [ ${#feature_paths[@]} -eq 0 ]; then
  echo "No affected feature tests to run. Skipping."
else
  echo "Running tests for affected features:"
  for f in "${feature_paths[@]}"; do
    echo " - $f"
  done
  npx vitest run ${feature_paths[@]}
fi