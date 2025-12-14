---
description: Scan and resolve comments on the Pull Request associated with the current branch
---

1. **Identify PR**: Find the Pull Request associated with the current branch.
    ```bash
    gh pr view --web
    # OR to view in terminal
    gh pr view
    ```

2. **Read Comments**: List the comments and reviews to understand what needs to be fixed.
    ```bash
    gh pr view --comments
    ```

3. **Address Feedback**:
    - For each constructive comment, locate the relevant file and code.
    - Make the necessary code changes to address the reviewer's feedback.

4. **Verify Changes**: Run tests or manual verification to ensure the fixes work and don't break anything.

5. **Commit Fixes**: Commit the changes with a message indicating you addressed PR feedback.
    ```bash
    git add .
    git commit -m "fix: address PR review comments"
    ```

6. **Push Updates**: Push the changes to the branch. This will automatically update the Pull Request.
    ```bash
    git push
    ```

7. **Reply (Optional)**: Reply to the PR comments to let the reviewer know the issues are resolved.
    ```bash
    gh pr comment --body "Addressed feedback in latest commit."
    ```
