# Rebase on Develop

Sync the current branch with the latest develop:

1. Error if there are uncommitted changes (check `git status`)
2. Check out develop: `git checkout develop`
3. Pull and prune: `git pull -p`
4. Prune local branches that no longer have remotes: `gbp`
5. Check out the original branch again
6. Rebase onto develop: `git rebase develop`
7. Report result (clean rebase or conflicts to resolve)
