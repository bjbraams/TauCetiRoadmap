#!/usr/bin/env bash
# Publish one roadmap directory from the `dlmf` working branch to its PR branch.
#
#   ./publish.sh <Directory> <pr-branch> ["commit message"] [--push]
#
# Example:  ./publish.sh AsymptoticExpansions asymptotic-expansions "AsymptoticExpansions: address review" --push
#
# - Copies TauCetiRoadmap/<Directory> exactly as committed on `dlmf` onto <pr-branch>
#   (additions, changes and deletions), and commits it there.
# - If <pr-branch> does not exist yet, it is created from upstream/main (run `git fetch upstream` first).
# - Works in a temporary side checkout: your own working tree, Lake files and .lake are untouched.
# - Refuses to commit if <pr-branch> would differ from upstream/main outside that one directory.
# - Pushes to origin (your fork) only with --push; otherwise prints the push command.
#
# This file lives only on `dlmf` and is never copied to a PR branch.
set -euo pipefail

push=0
args=()
for a in "$@"; do
  if [[ $a == --push ]]; then push=1; else args+=("$a"); fi
done
if (( ${#args[@]} < 2 || ${#args[@]} > 3 )); then
  sed -n '2,15p' "$0"; exit 2
fi
dir=${args[0]%/}
branch=${args[1]}
msg=${args[2]:-"$dir: update"}
path="TauCetiRoadmap/$dir"
src=dlmf
base=upstream/main

repo=$(git rev-parse --show-toplevel)
cd "$repo"

git rev-parse --verify -q "$src^{commit}" >/dev/null || { echo "no branch '$src'"; exit 1; }
git rev-parse --verify -q "$base^{commit}" >/dev/null || { echo "no '$base'; run: git fetch upstream"; exit 1; }
git cat-file -e "$src:$path" 2>/dev/null || { echo "'$path' does not exist on $src"; exit 1; }
[[ $branch == "$src" || $branch == main ]] && { echo "refusing to publish onto '$branch'"; exit 1; }

if [[ -n $(git status --porcelain -- "$path") ]]; then
  echo "warning: uncommitted changes in $path are NOT published (only what is committed on $src)"
fi

wt=$(mktemp -d "${TMPDIR:-/tmp}/publish-XXXXXX")
cleanup() { git -C "$repo" worktree remove --force "$wt" >/dev/null 2>&1 || rm -rf "$wt"; }
trap cleanup EXIT

if git show-ref --verify -q "refs/heads/$branch"; then
  git worktree add -q "$wt" "$branch"
  echo "updating existing branch $branch"
else
  git worktree add -q --no-track -b "$branch" "$wt" "$base"
  echo "created new branch $branch from $base"
fi

cd "$wt"
git rm -r -q --ignore-unmatch -- "$path"
git checkout "$src" -- "$path"

outside=$(git diff --name-only "$(git merge-base "$base" HEAD)" -- . ":(exclude)$path")
outside+=$'\n'$(git diff --cached --name-only -- . ":(exclude)$path")
outside=$(printf "%s" "$outside" | sed "/^$/d")
if [[ -n $outside ]]; then
  echo "error: $branch would change files outside $path:"; echo "$outside"; exit 1
fi

if git diff --cached --quiet; then
  echo "nothing to change: $branch already matches $src for $path"
else
  git diff --cached --stat
  git commit -q -m "$msg"
  echo "committed on $branch: $(git log --oneline -1)"
fi

if (( push )); then
  git push origin "$branch:$branch"
else
  echo "to update GitHub:  git push origin $branch"
fi
