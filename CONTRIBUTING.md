# Contributing Guide

Thank you for considering contributing to this project!

## Workflow

1. **Fork** the repository
2. Create a feature branch from `master`:
   ```bash
   git checkout -b feature/my-improvement
   ```
3. Make your changes
4. Validate:
   ```bash
   terraform fmt -recursive .
   terraform validate
   ```
5. Commit using [Conventional Commits](https://www.conventionalcommits.org/):
   ```
   feat: Add ElastiCache module
   fix: Correct RDS variable default
   docs: Update EKS README
   ```
6. Push and open a Pull Request against `master`

## Code Standards

- All variables must have a `description`
- All outputs must have a `description`
- Use `validation {}` blocks where inputs can be wrong
- Run `terraform fmt` before every commit
- Tag every resource using the standard tag map

## Branch Naming

| Type | Pattern |
|------|---------|
| New module | `feature/<module-name>` |
| Bug fix | `fix/<short-description>` |
| Docs | `docs/<short-description>` |

## Pull Request Checklist

- [ ] `terraform validate` passes
- [ ] `terraform fmt -check` passes
- [ ] Variables and outputs have descriptions
- [ ] `terraform.tfvars.example` updated if new variables added
- [ ] `IMPLEMENTATION_GUIDE.md` updated or created
- [ ] `CHANGELOG.md` entry added
