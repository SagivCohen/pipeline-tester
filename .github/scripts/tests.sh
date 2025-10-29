file=./src/components/Button/Button.jsx

echo $file

npx madge --json src | jq -r --arg f "$file" '
  to_entries
  | map(select(.value | index($f)))
  | .[].key
'