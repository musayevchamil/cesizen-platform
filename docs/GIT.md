# Git conventions

## Branches

`master` is always deployable. Coolify deploys on every push to it. Branch off `master` for everything.

| Prefix | Use |
|---|---|
| `feature/` | new functionality |
| `fix/` | bug fixes |
| `chore/` | dependencies, config, tooling |
| `docs/` | documentation only |

Lowercase, hyphens, short and descriptive.

```
feature/auth-login
fix/emotion-entry-delete
chore/update-dependencies
```

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org). Present tense, no capital, no period.

```
feat(auth): add login endpoint
fix(tracker): correct week filter boundary
chore(deps): update laravel to 11.x
docs(api): document emotion tracker endpoints
test(accounts): add registration validation tests
refactor(tracker): extract period filter to query scope
```

Scope is the module or layer touched: `auth`, `tracker`, `information`, `accounts`, `api`, `docker`.

One logical change per commit.

## Workflow

1. Branch off `master`
2. Open a pull request when ready
3. GitHub Actions must pass before merging
4. Squash and merge
5. Delete the branch

## What not to commit

`.env`, `public/build`, `vendor/`, `node_modules/`, IDE config.
