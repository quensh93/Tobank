# 📚 Complete Guide to Writing Cursor IDE Rules for AI Agents

> **Last Updated:** October 2025 | **Cursor Version:** 1.7+  
> A comprehensive guide for creating effective, optimized rules that enhance AI agent performance in Cursor IDE.

---

## 📋 Table of Contents

1. [Introduction](#introduction)
2. [What Are Cursor Rules?](#what-are-cursor-rules)
3. [The 5 Levels of Cursor Rules](#the-5-levels-of-cursor-rules)
4. [File Structure and Syntax](#file-structure-and-syntax)
5. [Best Practices for AI Agents](#best-practices-for-ai-agents)
6. [Rule Types and When to Use Them](#rule-types-and-when-to-use-them)
7. [Generation Templates](#generation-templates)
8. [Practical Examples](#practical-examples)
9. [Advanced Features (2025)](#advanced-features-2025)
10. [Troubleshooting](#troubleshooting)
11. [Quick Reference](#quick-reference)

---

## 🎯 Introduction

Cursor IDE rules provide persistent context to AI models, ensuring code generation aligns with project standards, architecture, and best practices. As AI agents work within token-limited context windows, rules act as "memory anchors" to prevent context drift and maintain consistency throughout coding sessions.

### Why Rules Matter for AI Agents

- **Combat Context Forgetting:** Agents lose earlier instructions as conversations grow longer
- **Enforce Consistency:** Maintain standards across multi-file projects
- **Reduce Hallucinations:** Provide grounded, specific guidance
- **Improve Velocity:** Pre-configure preferences to avoid repetitive prompts
- **Enable Autonomy:** Allow agents to self-select relevant contexts

---

## 📖 What Are Cursor Rules?

Cursor rules are customizable instructions stored as:
- **Project Rules:** `.mdc` files in `.cursor/rules/` (recommended)
- **User Rules:** Global text in Cursor Settings
- **Team Rules:** Organization-wide dashboard configurations *(New in 1.7)*
- **Legacy Format:** `.cursorrules` file (deprecated, migrate to `.mdc`)

### Key Capabilities

✅ Define coding standards and architectural patterns  
✅ Reference files with `@path/to/file.ext` for context injection  
✅ Auto-attach based on file patterns (globs)  
✅ Support YAML frontmatter for metadata  
✅ Version control with your codebase  

---

## 🏗️ The 5 Levels of Cursor Rules

Cursor's layered rule system allows granular control from global to runtime:

| Level | Type | Scope | Storage | Agent Use Case | 2025 Updates |
|-------|------|-------|---------|----------------|--------------|
| **1** | Global Editor Settings | All sessions | `settings.json` | Baseline IDE behaviors | Stable |
| **2** | User Rules | Personal, always applied | Cursor Settings | Agent output formats (e.g., JSON) | Combine with Team Rules |
| **3** | Project Rules | Repo-specific | `.cursor/rules/*.mdc` | Core task guidance | Enhanced indexing |
| **4** | Team Rules | Organization-wide | Dashboard | Multi-agent consistency | **New in 1.7** |
| **5** | Hooks (Beta) | Runtime scripts | Project/Org config | Agent governance & security | **New in 1.7** |

### Rule Priority

**Higher levels override lower ones.** For conflicts, the most specific rule wins.

---

## 📝 File Structure and Syntax

### Basic `.mdc` File Structure

```markdown
---
description: "Brief explanation of rule purpose"
globs: ["*.py", "*.js"]  # File patterns to auto-apply
alwaysApply: false       # Set to true for universal rules
---

# Rule Title

## Section 1: Guidelines
- Guideline 1 with example
- Guideline 2 with example

## Section 2: Prohibitions
- Don't do X
- Avoid Y

## Agent Meta-Instructions
- Prompt: "When generating [feature], ensure [constraint]."
```

### YAML Frontmatter Options

| Field | Type | Purpose | Example |
|-------|------|---------|---------|
| `description` | String | Short summary for agent selection | `"React component standards"` |
| `globs` | Array | File patterns for auto-attachment | `["*.tsx", "*.jsx"]` |
| `alwaysApply` | Boolean | Apply to all files in project | `true` or `false` |

### Markdown Content Guidelines

- **Use Headings:** Structure with `##` for sections
- **Code Examples:** Always include snippets in triple backticks
- **Lists:** Use `-` for guidelines, numbered for sequences
- **References:** Embed with `@filename.ext` or `@folder/file.ext`
- **Emphasis:** Use **bold** for critical points, *italics* for nuance

---

## ✨ Best Practices for AI Agents

### 1. Clarity and Actionability

❌ **Vague:** "Handle errors properly"  
✅ **Clear:** "Use try-except blocks for all I/O operations. Log errors to `logger.error()`"

**Use imperative language:**
```markdown
- Implement error handling with try-except
- Use type hints for all function parameters
- Run linters before committing: `npm run lint`
```

### 2. Token Efficiency

- **Limit file size:** Keep under 300 lines per `.mdc` file
- **Compress verbose sections:** Use tables instead of paragraphs
- **Estimate tokens:** ~1 token per 4 characters; budget accordingly
- **Decompose:** Split into multiple `.mdc` files (e.g., `base.mdc`, `testing.mdc`)

### 3. Include Examples

Agents mimic patterns—provide code snippets:

```markdown
## Function Naming
Use descriptive verb-noun patterns:

✅ Good:
```python
def calculate_user_balance(user_id: int) -> float:
    return database.query(user_id).sum()
```

❌ Bad:
```python
def calc(id):
    return db.q(id).s()
```
```

### 4. Layered Structure

Organize rules into sections:

```markdown
## What NOT to Do (Prohibitions)
- Never use `eval()` or `exec()`
- Don't commit secrets or API keys
- Avoid global variables

## How to Do (Processes)
- Run tests before commits: `pytest tests/`
- Use environment variables for configs
- Follow semantic versioning for releases

## Mindset (Agent Attitude)
- Be a critical partner: Challenge assumptions
- Prioritize security and maintainability
- Ask clarifying questions before implementing
```

### 5. Reinforcement Techniques

Combat context loss:

```markdown
## Agent Reminders
- **Periodic Check:** Every 10 responses, state: "Applying rules: security.mdc, testing.mdc"
- **Pre-Action:** Before code generation, confirm: "Does this align with [rule-name]?"
- **Meta-Prompt:** "If deviating from standards, explain why and suggest alternatives."
```

### 6. Security Focus

```markdown
## Security Rules
- ❌ NEVER run destructive commands without confirmation
- ✅ ALWAYS validate user inputs
- ✅ Use parameterized queries for SQL
- ✅ Enable Allow List Mode for terminal commands
- ❌ NEVER commit `.env` files or credentials
```

### 7. Integration with 2025 Features

```markdown
## Cursor 1.7 Integration
- **Plan Mode:** For complex tasks, create detailed plans before coding
- **Agent Autocomplete:** Use suggestions for faster prompt refinement
- **Hooks:** Block unsafe commands via pre-commit scripts
- **Team Rules:** Align with org-wide linting standards
- **Image Support:** Read UI mockups directly for visual contexts
```

---

## 🎨 Rule Types and When to Use Them

### Always Applied Rules

**Use for:** Universal standards across all files

```markdown
---
description: "Global code quality standards"
alwaysApply: true
---

# Project-Wide Standards
- Use 2-space indentation
- Max line length: 100 characters
- Required: ESLint/Prettier compliance
```

### Auto-Attached Rules (Glob-Based)

**Use for:** Language/framework-specific guidance

```markdown
---
description: "Python-specific best practices"
globs: ["*.py"]
alwaysApply: false
---

# Python Guidelines
- Use type hints: `def func(x: int) -> str:`
- Follow PEP 8 conventions
- Use `black` for formatting
```

### Agent-Requested Rules (Description-Based)

**Use for:** Specialized contexts agents self-select

```markdown
---
description: "Debugging protocol for error analysis"
alwaysApply: false
---

# Debugging Steps
1. Reproduce the error
2. Check logs and stack traces
3. Isolate failing component
4. Propose fix with tests
```

*Agent selects when user says: "Debug this error"*

### Manual Rules (@invoke)

**Use for:** Explicit invocation scenarios

```markdown
---
description: "Deploy production checklist"
alwaysApply: false
---

# Production Deployment
Invoke with: `@deploy-rules`

- [ ] Run full test suite
- [ ] Update changelog
- [ ] Bump version number
- [ ] Tag release in Git
- [ ] Deploy to staging first
```

---

## 🛠️ Generation Templates

Use these prompts to create rules dynamically:

### Template 1: Basic Rule Scaffold

**Prompt:**
```
Generate a .mdc rule file for [framework/language] best practices, optimized for AI agents.
```

**Output Structure:**
```markdown
---
description: "[Brief purpose, e.g., 'TypeScript standards for agents']"
globs: ["[patterns, e.g., *.ts, *.tsx]"]
alwaysApply: [true/false]
---

# [Title, e.g., TypeScript Agent Guidelines]

## Rule Category 1
- [Rule 1: e.g., Use strict mode with `"strict": true` in tsconfig]
  
**Example:**
```typescript
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true
  }
}
```

## Rule Category 2
- [Rule 2: ...]
```

### Template 2: Advanced with Team Rules

**Prompt:**
```
Create agent-optimized rules for [topic, e.g., React components], including examples, meta-prompts, and Team Rules integration.
```

**Output:**
```markdown
---
description: React best practices for AI-driven UIs
globs: ["*.jsx", "*.tsx"]
alwaysApply: false
---

# React Agent Guidelines

## Component Structure
- Use functional components with Hooks
- Avoid class components unless legacy

**Example:**
```tsx
interface Props {
  name: string;
}

const Greeting: React.FC<Props> = ({ name }) => {
  return <h1>Hello, {name}!</h1>;
};
```

## Agent Meta-Instructions
- **Validation:** "Ensure Hooks are called at top level only"
- **Testing:** "Generate unit tests with React Testing Library"

## Team Integration
- Align with Team Rules: Enforce ESLint config from dashboard
- Use shared component library: `@company/ui-components`
```

### Template 3: Meta-Rule for Self-Improvement

**Prompt:**
```
Generate a self-improving rule set for [project] using Hooks for governance.
```

**Output:**
```markdown
---
description: Iterative improvement framework for agents
alwaysApply: true
---

# Agent Iteration Rules

## Self-Evaluation Loop
- After each output, ask: "Does this meet project goals?"
- If deviation detected, propose refinement

## Feedback Integration
- **User Correction:** Update relevant rules immediately
- **Generation Prompt:** "Based on feedback: [describe changes]"

## Hooks for Safety
- Block destructive git commands (e.g., `git push --force`)
- Redact secrets before committing
- Require approval for database migrations
```

---

## 💡 Practical Examples

### Example 1: Flutter/Dart Project Rules

```markdown
---
description: Flutter best practices for mobile development
globs: ["*.dart"]
alwaysApply: false
---

# Flutter Development Guidelines

## Code Style
- Use `dart format` before commits
- Follow official Dart style guide
- Max line length: 80 characters

## Widget Structure
- Prefer `const` constructors for performance
- Use `StatelessWidget` when state is unnecessary
- Extract complex widgets into separate files

**Example:**
```dart
class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.onPressed}) : super(key: key);
  
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Click Me'),
    );
  }
}
```

## State Management
- Use `Provider` for simple state
- Use `Riverpod` or `Bloc` for complex apps
- Avoid global state when possible

## Testing
- Write widget tests for all screens
- Use `flutter test` before pushing
- Mock external dependencies

## Agent Instructions
- **Before Generating:** Check existing widget patterns in `lib/widgets/`
- **After Changes:** Run `flutter analyze` and fix all warnings
- **Deployment:** NEVER run without user confirmation
```

### Example 2: Frontend Web Project (React + Tailwind)

```markdown
---
description: Modern frontend standards for React with Tailwind CSS
globs: ["*.tsx", "*.jsx"]
alwaysApply: false
---

# Frontend Development Rules

## Styling
- **Always** use project's Tailwind color palette
- No inline styles or `style={{}}` props
- Use `className` with utility classes

**Example:**
```tsx
// ✅ Good
<button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
  Click me
</button>

// ❌ Bad
<button style={{ backgroundColor: 'blue', padding: '8px' }}>
  Click me
</button>
```

## Component Patterns
- Use named exports with object params
- Destructure props inline

**Example:**
```tsx
// ✅ Preferred
export const UserCard = ({ name, email }: { name: string; email: string }) => (
  <div className="card">
    <h3>{name}</h3>
    <p>{email}</p>
  </div>
);

// ❌ Avoid
export default function UserCard(props) {
  return <div>...</div>;
}
```

## Package Management
- Use `pnpm` for all installs
- Never commit `node_modules/`
- Keep dependencies updated monthly

## Client/Server Components
- Add `"use client"` for interactive components
- Use Server Components by default in Next.js 13+

## Error Handling
- Use optional chaining: `user?.profile?.avatar`
- Provide fallback values: `count ?? 0`

## Date Handling
- Use `dayjs` for all date operations
- Never use native `Date()` constructor

## Agent Workflow
- Perform 3+ semantic searches before generating
- Reference existing components with `@components/...`
- Ask before installing new dependencies
```

### Example 3: Backend API (Node.js + Express)

```markdown
---
description: Node.js backend API standards
globs: ["*.js", "*.ts"]
alwaysApply: false
---

# Backend API Guidelines

## Project Structure
```
src/
├── controllers/   # Request handlers
├── models/        # Data models
├── routes/        # Express routes
├── middleware/    # Custom middleware
├── services/      # Business logic
└── utils/         # Helper functions
```

## Error Handling
- Use async/await with try-catch
- Create custom error classes
- Return consistent error responses

**Example:**
```typescript
// controllers/user.controller.ts
export const getUser = async (req: Request, res: Response) => {
  try {
    const user = await UserService.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json({ data: user });
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
```

## Database
- Use parameterized queries (prevent SQL injection)
- Close connections properly
- Use transactions for multi-step operations

## Environment Variables
- Store secrets in `.env` (never commit!)
- Validate env vars at startup
- Use `dotenv` package

## Testing
- Write unit tests for all services
- Integration tests for API endpoints
- Use `jest` and `supertest`

## Security
- ❌ NEVER log sensitive data
- ✅ Use `helmet` middleware
- ✅ Implement rate limiting
- ✅ Validate all inputs with `joi` or `zod`

## Agent Constraints
- Don't start dev server automatically
- Ask before database migrations
- Run `npm run typecheck` after changes
```

### Example 4: Smart Contract Development (Solidity)

```markdown
---
description: Solidity smart contract best practices
globs: ["*.sol"]
alwaysApply: false
---

# Blockchain Smart Contract Rules

## Development Workflow
- ❌ DON'T run dev server or deploy without asking
- ✅ DO run `npm run compile:check` after changes
- ✅ DO update ABI and frontend when contracts change
- ✅ DO check `BYTECODE_OPTIMIZATION.md` for gas optimization

## Security Standards
- Use OpenZeppelin libraries for standards (ERC20, ERC721)
- Implement access control (Ownable, AccessControl)
- Protect against reentrancy with checks-effects-interactions pattern
- Use SafeMath for Solidity < 0.8.0

**Example:**
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureVault is Ownable {
    mapping(address => uint256) private balances;
    
    // Checks-Effects-Interactions pattern
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // Effects
        balances[msg.sender] -= amount;
        
        // Interactions
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}
```

## Testing
- Write comprehensive unit tests with Hardhat
- Use Foundry for fuzzing tests
- Test edge cases and attack vectors

## Gas Optimization
- Use `uint256` instead of smaller uints (unless packing)
- Cache storage variables in memory
- Use `immutable` and `constant` when possible

## Agent Instructions
- Use Plan Mode for complex contract audits
- Reference security patterns before implementing
- At task completion: Ask to deploy with `npm run redeploy:all`
```

### Example 5: Python Data Science Project

```markdown
---
description: Python data science and ML best practices
globs: ["*.py", "*.ipynb"]
alwaysApply: false
---

# Python Data Science Guidelines

## Code Style
- Follow PEP 8 conventions
- Use type hints for function signatures
- Format with `black` (line length: 88)

**Example:**
```python
import pandas as pd
from typing import List, Tuple

def process_dataset(
    data: pd.DataFrame, 
    columns: List[str]
) -> Tuple[pd.DataFrame, dict]:
    """Process dataset by selecting columns and computing statistics."""
    processed = data[columns].dropna()
    stats = {
        'mean': processed.mean().to_dict(),
        'std': processed.std().to_dict()
    }
    return processed, stats
```

## Data Handling
- Use `pandas` for tabular data
- Use `numpy` for numerical operations
- Prefer vectorized operations over loops

## Machine Learning
- Split data: train/validation/test (70/15/15)
- Use `scikit-learn` pipelines
- Track experiments with MLflow or Weights & Biases

**Example:**
```python
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier

pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('classifier', RandomForestClassifier(n_estimators=100))
])

pipeline.fit(X_train, y_train)
```

## Notebooks
- Keep cells focused (one task per cell)
- Clear outputs before committing
- Convert to scripts for production

## Environment
- Use `poetry` or `conda` for dependencies
- Pin versions in `requirements.txt`
- Document setup in README

## Agent Workflow
- Search for existing data processing functions before creating new ones
- Validate data shapes and types
- Include visualization for key results
```

### Example 6: GitHub PR Integration Rules

```markdown
---
description: GitHub pull request workflow for agents
alwaysApply: false
---

# GitHub PR Agent Rules

## Getting PR Information
Use GitHub CLI commands:

```bash
# View PR details
gh pr view <number>

# Get PR metadata (author, labels, etc.)
gh api repos/OWNER/REPO/pulls/PR_NUMBER

# List changed files
gh api repos/OWNER/REPO/pulls/PR_NUMBER/files

# Read comments
gh pr view <number> --comments
```

## PR Template Extraction
- Extract requirements from `.github/pull_request_template.md`
- Ensure all checklist items are addressed
- Validate against project standards

## Review Process
1. Read PR description and linked issues
2. Review changed files systematically
3. Check for test coverage
4. Validate documentation updates
5. Ensure no secrets/credentials in diff

## Prohibited Actions
- ❌ DON'T generate documentation unless explicitly requested
- ❌ DON'T auto-merge without approval
- ❌ DON'T modify unrelated files

## Agent Checklist
- [ ] All tests passing?
- [ ] Breaking changes documented?
- [ ] Dependencies updated appropriately?
- [ ] Security implications considered?
```

### Example 7: Performance Optimization Rules

```markdown
---
description: Cross-language performance optimization guidelines
globs: ["*"]
alwaysApply: false
---

# Performance Optimization Rules

## Python Optimizations
- Use `numpy` arrays instead of lists for numerical operations
- Use generators for large datasets
- Profile with `cProfile` before optimizing

**Example:**
```python
# ❌ Slow
result = [x**2 for x in range(1000000)]

# ✅ Fast
import numpy as np
result = np.arange(1000000) ** 2
```

## JavaScript Optimizations
- Memoize expensive function calls
- Use `useMemo` and `useCallback` in React
- Debounce/throttle event handlers

**Example:**
```typescript
import { useMemo } from 'react';

const ExpensiveComponent = ({ data }) => {
  const processedData = useMemo(() => {
    return data.map(item => heavyComputation(item));
  }, [data]);
  
  return <div>{processedData}</div>;
};
```

## Database Optimizations
- Add indexes on frequently queried columns
- Use connection pooling
- Limit SELECT queries (avoid `SELECT *`)
- Use pagination for large result sets

## Agent Instructions
- Profile code before suggesting optimizations
- Suggest optimizations only if complexity > O(n²)
- Benchmark before and after changes
- Use Team Rules for performance standards
```

---

## 🚀 Advanced Features (2025)

### Team Rules (Cursor 1.7)

**Purpose:** Organization-wide standards applied across all repositories

**Setup:**
1. Navigate to Cursor Dashboard → Team Settings
2. Define rules in Team Rules section
3. Rules automatically apply to all team members

**Example Team Rule:**
```markdown
# Organization Testing Standards

## Required for All PRs
- Minimum 80% code coverage
- All tests must pass in CI/CD
- Use approved testing frameworks:
  - JavaScript: Jest, Vitest
  - Python: pytest
  - Go: built-in testing package

## Code Review Requirements
- At least 2 approvals for production code
- Security review for auth/payment features
- Performance benchmarks for critical paths
```

### Hooks (Beta) - Agent Governance

**Purpose:** Runtime scripts that observe/control agent behavior

**Capabilities:**
- Block unsafe terminal commands
- Redact secrets before commits
- Audit agent actions
- Enforce security policies

**Example Hook:**
```javascript
// .cursor/hooks/pre-commit.js
module.exports = {
  beforeCommand: (command) => {
    // Block force pushes to main
    if (command.includes('git push --force') && 
        command.includes('main')) {
      return {
        allowed: false,
        reason: 'Force push to main is prohibited'
      };
    }
    return { allowed: true };
  },
  
  beforeFileWrite: (filepath, content) => {
    // Prevent committing secrets
    const secretPatterns = [
      /API_KEY\s*=\s*["'][^"']+["']/,
      /password\s*=\s*["'][^"']+["']/i
    ];
    
    for (const pattern of secretPatterns) {
      if (pattern.test(content)) {
        return {
          allowed: false,
          reason: 'Possible secret detected in file'
        };
      }
    }
    return { allowed: true };
  }
};
```

### Plan Mode

**Purpose:** Agents create detailed execution plans for complex tasks

**When to Use:**
- Multi-step refactoring
- Complex feature implementation
- Architecture changes
- Code migrations

**Example Usage:**
```markdown
## Agent Task with Plan Mode

**User Request:** "Migrate authentication from sessions to JWT"

**Plan Mode Output:**
1. Analysis Phase
   - Review current session implementation
   - Identify all authentication points
   - List dependencies

2. Implementation Phase
   - Install JWT libraries
   - Create JWT utility functions
   - Update login endpoint
   - Modify authentication middleware
   - Update frontend token storage

3. Testing Phase
   - Write unit tests for JWT functions
   - Integration tests for auth flow
   - Manual testing checklist

4. Deployment Phase
   - Update environment variables
   - Database migration for token storage
   - Gradual rollout strategy
```

### Agent Autocomplete

**Purpose:** AI-powered suggestions while typing prompts

**Features:**
- File attachment suggestions
- Common command completions
- Image upload prompts
- Reference suggestions (@file, @folder)

**Optimization:**
```markdown
## Using Autocomplete Effectively

- Type `@` to see file/folder suggestions
- Use `@image` to attach visual context
- Type partial commands for completions
- Reference rules with `@rulename.mdc`
```

### Enhanced Image Support

**Purpose:** Agents read and understand images directly

**Use Cases:**
- UI mockups → component generation
- Diagrams → architecture implementation
- Screenshots → bug reproduction
- Design files → styling

**Example:**
```markdown
## Image-Based Development

**Prompt:** "Implement this UI: @mockup.png"

**Agent Response:**
1. Analyzes mockup.png
2. Identifies components: Header, Sidebar, Content Grid
3. Generates React components with Tailwind classes
4. Matches colors and spacing from image
5. Proposes responsive breakpoints
```

---

## 🔧 Troubleshooting

### Common Issues and Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| Rules not applying | File not in `.cursor/rules/` | Move `.cursorrules` to `.cursor/rules/base.mdc` |
| Context loss mid-session | Agent token limit reached | Add reminder prompts; use shorter rules |
| Rules cleared after update | Cursor bug (known issue) | Re-add rules; keep backup in repo |
| Glob patterns not matching | Incorrect pattern syntax | Use `**/*.ext` for recursive matching |
| Agent ignores specific rule | Too many competing rules | Use `alwaysApply: true` or increase specificity |
| Slow performance | Too many large rule files | Split into smaller, focused files |

### Debugging Rule Application

**Check if rules are loaded:**
1. Open Cursor Settings → Rules
2. Verify files appear in project rules list
3. Check YAML frontmatter for syntax errors

**Test rule matching:**
```markdown
## Test Rule Application

Create a test file matching glob pattern:
- Rule glob: `["*.test.ts"]`
- Test file: `example.test.ts`
- Prompt agent: "List active rules for this file"
```

**Enable verbose logging:**
```markdown
## Agent Debug Mode

Add to User Rules:
"Before each response, list all active rules being applied to current context."
```

### Performance Optimization

**Token Usage:**
```markdown
## Reducing Token Consumption

1. Limit "Always Apply" rules to essentials
2. Use globs for targeted application
3. Remove redundant examples
4. Reference external docs instead of embedding
5. Compress verbose sections into tables
```

**Context Window Management:**
```markdown
## Managing Large Codebases

- Use Agent-Requested rules for optional contexts
- Decompose into specialized rule files
- Leverage @file references instead of inline content
- Use Team Rules for shared standards (reduces per-project duplication)
```

---

## 📌 Quick Reference

### Rule File Checklist

- [ ] File in `.cursor/rules/` directory
- [ ] `.mdc` extension (not `.md`)
- [ ] Valid YAML frontmatter
- [ ] Clear description
- [ ] Appropriate globs or `alwaysApply` setting
- [ ] Actionable, imperative language
- [ ] Code examples for key concepts
- [ ] Security considerations included
- [ ] Agent meta-instructions provided
- [ ] Version controlled with project

### Essential Commands

```bash
# Create rules directory
mkdir -p .cursor/rules

# Generate rule file (Cursor command)
/Generate Cursor Rules

# Validate YAML frontmatter
# (use online YAML validator)

# Test rule application
# (open matching file, prompt agent to list active rules)
```

### Best Practice Summary

| Do ✅ | Don't ❌ |
|-------|---------|
| Use clear, imperative language | Write verbose explanations |
| Include code examples | Provide only theory |
| Keep files under 300 lines | Create monolithic rule files |
| Use globs for auto-attachment | Over-use `alwaysApply: true` |
| Version control rules | Store only locally |
| Test rules with real tasks | Assume rules work without validation |
| Update rules based on feedback | Set and forget |
| Use Plan Mode for complexity | Generate without planning |
| Enable security hooks | Allow unrestricted agent actions |
| Integrate Team Rules | Duplicate standards per-project |

### Template Quick Access

**Create New Rule:**
```markdown
---
description: "[Purpose]"
globs: ["[pattern]"]
alwaysApply: false
---

# [Rule Name]

## Guidelines
- [Rule 1]

**Example:**
```[language]
// code example
```

## Agent Instructions
- [Meta-prompt]
```

**Invoke Template:**
Prompt: `"Using this template, create rules for [framework/task]"`

---

## 🔗 Additional Resources

### Official Documentation
- [Cursor Changelog](https://cursor.com/changelog) - Latest features and updates
- [Cursor Security Best Practices](https://www.backslash.security/blog/cursor-ide-security-best-practices)

### Community Resources
- [Medium: Cursor Rules Best Practices](https://medium.com/elementor-engineers/cursor-rules-best-practices-for-developers-16a438a4935c)
- [DEV Community: Top Cursor Tips 2025](https://dev.to/heymarkkop/my-top-cursor-tips-oct-2025-3bi2)

### Framework-Specific Examples
- Search GitHub for `.cursor/rules` in popular repositories
- Check organization repositories for Team Rules examples
- Explore [awesome-cursor-rules](https://github.com/topics/cursor-rules) (if available)

---

## 📄 License and Contributions

This guide is open for contributions. To suggest improvements:
1. Test your optimization with real agent tasks
2. Document results (before/after)
3. Submit with clear rationale

**Last Updated:** October 2025  
**Compatible With:** Cursor 1.7+  
**Maintained By:** Community

---

## 🎓 Conclusion

Effective Cursor rules transform AI agents from general assistants into specialized coding partners aligned with your project's unique requirements. By following this guide, you can:

- ✅ Reduce hallucinations and context drift
- ✅ Enforce consistent coding standards
- ✅ Improve agent autonomy and accuracy
- ✅ Leverage 2025 features (Team Rules, Hooks, Plan Mode)
- ✅ Scale development across teams

**Next Steps:**
1. Audit existing project for rule opportunities
2. Create base rules using templates
3. Test with real agent tasks
4. Iterate based on results
5. Share successful patterns with team

**Remember:** Rules are living documents. Continuously refine based on agent performance and project evolution.

---

*Happy Coding with Cursor! 🚀*

