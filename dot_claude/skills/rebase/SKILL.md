# Rebase on Branch

Sync the current branch with the latest upstream branch.

**Args:** Optional branch name to rebase onto (e.g., `/rebase main`).

If no branch is specified, auto-detect by using the first of these that exists as a local or remote branch: `develop`, `main`.

## Steps

1. Error if there are uncommitted changes (check `git status`)
2. Determine the target branch (from arg or auto-detect)
3. Check out the target branch: `git checkout <branch>`
4. Pull and prune: `git pull -p`
5. Prune local branches that no longer have remotes: `gbp`
6. Check out the original branch again
7. Rebase onto the target branch: `git rebase <branch>`
8. Report result (clean rebase or conflicts to resolve)
