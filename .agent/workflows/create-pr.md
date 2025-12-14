---
description: Create a Pull Request for the current changes
---

1. **Check Status**: Verify the current state of the repository and list changed files.
   ```bash
   git status
   ```

2. **Create Branch**: Create and switch to a new branch. Use a naming convention like `feature/name` or `fix/name`.
   > If the branch already exists, use `git checkout <branch-name>` instead.
   ```bash
   git checkout -b <branch-name>
   ```

3. **Stage Changes**: Add all modified and new files to the staging area.
   ```bash
   git add .
   ```

4. **Commit**: Commit the changes with a clear, conventional message (e.g., `feat: add new login screen`).
   ```bash
   git commit -m "<commit-message>"
   ```

5. **Push**: Push the branch to the remote repository and set the upstream tracking.
   ```bash
   git push -u origin <branch-name>
   ```

6. **Create PR**: Create the Pull Request using the GitHub CLI. Use `--fill` to populate the title and body from the commit message, or specify them manually.
   ```bash
   gh pr create --fill
   ```
