# AI Agent Documentation - Tobank STAC SDUI

> **Purpose**: This folder contains comprehensive documentation for AI agents to understand the project structure, rules, workflows, and how to handle various aspects of the Tobank STAC SDUI project.

## 📚 Documentation Index

### Rules (MANDATORY - Read First!)

**🚀 [Rules/QUICK_RULES.md](./Rules/QUICK_RULES.md)** - **START HERE!** One-page quick reference with all critical rules.

**📋 [Rules/README.md](./Rules/README.md)** - Rules index (detailed rules available as reference)

### Core Documents

1. **[PROJECT_OVERVIEW.md](./PROJECT_OVERVIEW.md)** - Project structure, architecture, and key concepts
2. **[DEVELOPMENT_WORKFLOW.md](./DEVELOPMENT_WORKFLOW.md)** - How to create STAC pages, workflow rules, and best practices
3. **[CUSTOM_COMPONENTS.md](./CUSTOM_COMPONENTS.md)** - Creating custom actions and parsers
4. **[DATA_BINDING_SYSTEM.md](./DATA_BINDING_SYSTEM.md)** - Colors, styles, strings system and how to use them
5. **[CORE_STAC_STRUCTURE.md](./CORE_STAC_STRUCTURE.md)** - Deep dive into `lib/core/stac` structure
6. **[REFERENCE_LOCATIONS.md](./REFERENCE_LOCATIONS.md)** - Where to find documentation, old code, and resources
7. **[ISSUES_HANDLING.md](./ISSUES_HANDLING.md)** - How to handle issues and use the Issues log

## 🎯 Quick Start for AI Agents

### Before Starting Any Task

1. **Read [Rules/QUICK_RULES.md](./Rules/QUICK_RULES.md)** - **CRITICAL!** All essential rules in one page
2. **Check [Issues/ISSUES_LOG.md](./Issues/ISSUES_LOG.md)** - See if similar issues were solved before
3. **Read [PROJECT_OVERVIEW.md](./PROJECT_OVERVIEW.md)** - Understand the project structure (if needed)
4. **Read [DEVELOPMENT_WORKFLOW.md](./DEVELOPMENT_WORKFLOW.md)** - Understand how to create pages (if needed)

### When Creating a New STAC Page

1. **Read STAC docs** in `docs/App_Docs/stac_docs/` - Understand widget syntax
2. **Check old tobank reference** in `docs/Archived/.tobank_old/` - Match UI exactly
3. **Follow workflow** in [DEVELOPMENT_WORKFLOW.md](./DEVELOPMENT_WORKFLOW.md)
4. **Use assets** from `assets/` folder (copied from old tobank)

### When Facing an Issue

1. **Check [Issues/ISSUES_LOG.md](./Issues/ISSUES_LOG.md)** - See if issue exists
2. **If not found**, try to fix and document in Issues log
3. **Check [CORE_STAC_STRUCTURE.md](./CORE_STAC_STRUCTURE.md)** - Understand inner layers
4. **Check STAC repository** in `docs/Archived/.stac/` - For framework-level issues

## 🔑 Key Principles

1. **UI Must Match Old Tobank** - Pages should look exactly like the old tobank app
2. **🚨 CRITICAL: Dart → JSON Build MUST Work** - The whole point of Dart STAC syntax is to generate JSON from Dart. If `stac build` fails, FIX IT FIRST. Never manually edit JSON - always generate from Dart.
3. **Dart → JSON → API** - Always create Dart first, build to JSON, then create API JSON
4. **Use Style Aliases** - Reduce JSON size by using style aliases from `GET_styles.json`
5. **Theme-Aware Colors** - Always use `{{appColors.current.*}}` not `{{appColors.light.*}}`
6. **Check Issues First** - Always check Issues log before starting tasks

## 📖 Additional Resources

- **Complete Guide**: `docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md`
- **Project Overview**: `docs/overview.md`
- **STAC Framework Docs**: `docs/App_Docs/stac_docs/`
- **STAC Repository**: `docs/Archived/.stac/` (for inner layer issues)

---

**Last Updated**: 2025-01-XX  
**Status**: ✅ Complete - Ready for AI Agents

