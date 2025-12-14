---
description: Create a Pull Request for the current changes
---

1. Create a new branch with a descriptive name.
   ```bash
   # Example: git checkout -b feature/my-feature-name
   ```
2. Add all changes.
   ```bash
   git add .
   ```
3. Commit the changes with a descriptive message.
   ```bash
   # Example: git commit -m "feat: description of changes"
   ```
4. Push the branch to origin.
   ```bash
   # Example: git push -u origin feature/my-feature-name
   ```
5. Create the PR using GitHub CLI.
   ```bash
   gh pr create --fill
   ```
