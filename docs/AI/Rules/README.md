# Rules Index - Tobank STAC SDUI

## 🎯 Start Here!

**👉 [QUICK_RULES.md](./QUICK_RULES.md)** - **READ THIS FIRST!** One-page quick reference with all critical rules.

## 📚 Detailed Rules (Reference Only)

For detailed explanations, see these files (but start with QUICK_RULES.md):

1. **[01_GENERAL_RULES.md](./01_GENERAL_RULES.md)** - General project rules
2. **[02_STAC_PAGE_CREATION_RULES.md](./02_STAC_PAGE_CREATION_RULES.md)** - STAC page creation
3. **[03_CODE_STYLE_RULES.md](./03_CODE_STYLE_RULES.md)** - Code style and syntax
4. **[04_DATA_BINDING_RULES.md](./04_DATA_BINDING_RULES.md)** - Data binding
5. **[05_CUSTOM_COMPONENT_RULES.md](./05_CUSTOM_COMPONENT_RULES.md)** - Custom components
6. **[06_FILE_ORGANIZATION_RULES.md](./06_FILE_ORGANIZATION_RULES.md)** - File organization
7. **[07_TESTING_VALIDATION_RULES.md](./07_TESTING_VALIDATION_RULES.md)** - Testing

## 🚨 Critical Rules Summary

### Must Do
1. ✅ Check Issues log before starting
2. ✅ Match old tobank UI exactly
3. ✅ Follow Dart → JSON → API workflow
4. ✅ Use theme-aware colors (`{{appColors.current.*}}`)
5. ✅ Use style aliases (not inline styles)
6. ✅ Use string variables (not hardcoded text)
7. ✅ Preview and test before completing
8. ✅ Register custom components

### Must Not Do
1. ❌ Edit `.build/` files manually
2. ❌ Hardcode colors or strings
3. ❌ Use `{{appColors.light.*}}` directly
4. ❌ Define inline style objects
5. ❌ Skip checking Issues log
6. ❌ Skip preview/testing
7. ❌ Use strings instead of enums
8. ❌ Forget to register custom components

## 📋 Quick Reference

### Before Starting Any Task
- [ ] Read [01_GENERAL_RULES.md](./01_GENERAL_RULES.md)
- [ ] Check Issues log: `docs/AI/Issues/ISSUES_LOG.md`
- [ ] Read relevant documentation

### When Creating STAC Pages
- [ ] Read [02_STAC_PAGE_CREATION_RULES.md](./02_STAC_PAGE_CREATION_RULES.md)
- [ ] Read [03_CODE_STYLE_RULES.md](./03_CODE_STYLE_RULES.md)
- [ ] Read [04_DATA_BINDING_RULES.md](./04_DATA_BINDING_RULES.md)
- [ ] Read [06_FILE_ORGANIZATION_RULES.md](./06_FILE_ORGANIZATION_RULES.md)
- [ ] Read [07_TESTING_VALIDATION_RULES.md](./07_TESTING_VALIDATION_RULES.md)

### When Creating Custom Components
- [ ] Read [05_CUSTOM_COMPONENT_RULES.md](./05_CUSTOM_COMPONENT_RULES.md)
- [ ] Check existing examples
- [ ] Follow registration process

## 🔗 Related Documentation

- **Main Documentation**: `docs/AI/README.md`
- **Project Overview**: `docs/AI/PROJECT_OVERVIEW.md`
- **Development Workflow**: `docs/AI/DEVELOPMENT_WORKFLOW.md`
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`

---

**Remember**: These rules are mandatory. Following them ensures consistency, quality, and prevents common mistakes.

