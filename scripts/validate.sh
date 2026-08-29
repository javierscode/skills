#!/usr/bin/env bash
# Checks every skill against the repo constitution in AGENTS.md.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

failed=0
err()  { printf '  \033[31m✗\033[0m %s\n' "$1"; failed=1; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }

# Body of the YAML frontmatter, without the --- fences.
frontmatter() { awk 'NR==1 && $0=="---" {inside=1; next} inside && $0=="---" {exit} inside' "$1"; }
field() { frontmatter "$1" | sed -n "s/^$2:[[:space:]]*//p" | head -1; }
yaml_field() { sed -n "s/^[[:space:]]*$2:[[:space:]]*//p" "$1" | head -1; }

for dir in skills/*/; do
  name="$(basename "$dir")"
  printf '\n%s\n' "$name"

  if [ ! -f "$dir/SKILL.md" ]; then
    err "SKILL.md missing"
    continue
  fi

  declared="$(field "$dir/SKILL.md" name)"
  if [ "$declared" != "$name" ]; then
    err "frontmatter name '$declared' does not match directory '$name'"
  elif ! printf '%s' "$name" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$'; then
    err "name '$name' is not lowercase-with-single-hyphens"
  else
    ok "name"
  fi

  if [ -z "$(field "$dir/SKILL.md" description)" ]; then
    err "description is empty"
  else
    ok "description"
  fi

  yaml="$dir/agents/openai.yaml"
  if [ ! -f "$yaml" ]; then
    err "agents/openai.yaml missing"
  else
    ok "agents/openai.yaml"
    disabled="$(field "$dir/SKILL.md" disable-model-invocation)"
    implicit="$(yaml_field "$yaml" allow_implicit_invocation)"
    if [ "$disabled" = "true" ] && [ "$implicit" != "false" ]; then
      err "user-invoked in SKILL.md but agents/openai.yaml lacks allow_implicit_invocation: false"
    elif [ "$disabled" != "true" ] && [ "$implicit" = "false" ]; then
      err "allow_implicit_invocation: false but SKILL.md lacks disable-model-invocation: true"
    else
      ok "invocation declared consistently"
    fi
  fi

  if grep -q "skills/$name" README.md; then
    ok "listed in README.md"
  else
    err "not listed in README.md"
  fi
done

printf '\n'
if [ "$failed" -eq 0 ]; then
  printf '\033[32mAll skills pass.\033[0m\n'
else
  printf '\033[31mValidation failed.\033[0m\n'
fi
exit "$failed"
