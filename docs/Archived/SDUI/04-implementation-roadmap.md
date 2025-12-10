# SDUI Implementation Roadmap

## Overview

This document provides a phased implementation plan for migrating Tobank app to a hybrid SDUI architecture.

---

## Phase 1: Foundation (Weeks 1-4)

### 1.1 SDUI Engine Core

**Week 1-2: Parser & Renderer**

```
Tasks:
├── Create SDUIEngine class
│   ├── JSON schema validator
│   ├── Widget parser
│   └── Expression evaluator
├── Create WidgetRegistry
│   ├── Register base widgets
│   └── Widget factory pattern
└── Create ActionRegistry
    ├── Register base actions
    └── Action executor
```

**Deliverables:**
- [ ] `lib/sdui/engine/sdui_engine.dart`
- [ ] `lib/sdui/engine/json_parser.dart`
- [ ] `lib/sdui/engine/expression_evaluator.dart`
- [ ] `lib/sdui/registry/widget_registry.dart`
- [ ] `lib/sdui/registry/action_registry.dart`

**Week 3-4: Data Binding System**

```
Tasks:
├── Create DataBindingManager
│   ├── Local state bindings
│   ├── API data bindings
│   └── Computed bindings
├── Create CacheManager
│   ├── Memory cache
│   └── Persistent cache
└── Create StateManager
    ├── Page state
    └── Form state
```

**Deliverables:**
- [ ] `lib/sdui/bindings/data_binding_manager.dart`
- [ ] `lib/sdui/bindings/expression_parser.dart`
- [ ] `lib/sdui/cache/cache_manager.dart`
- [ ] `lib/sdui/state/state_manager.dart`

---

## Phase 2: Widget Library (Weeks 5-8)

### 2.1 Container Widgets

**Week 5:**
- [ ] Column, Row, Stack
- [ ] ScrollView, ListView, GridView
- [ ] Card, Container, Padding
- [ ] Expanded, SizedBox, Spacer

### 2.2 Display Widgets

**Week 6:**
- [ ] Text, RichText
- [ ] Image, SVG, Icon
- [ ] Avatar, Badge, Chip
- [ ] Divider, Progress indicators

### 2.3 Input Widgets

**Week 7:**
- [ ] TextField (with masks, formatters)
- [ ] Dropdown, DatePicker
- [ ] Checkbox, RadioGroup, Switch
- [ ] Slider, AmountInput, PinInput

### 2.4 Interactive Widgets

**Week 8:**
- [ ] Button variants
- [ ] InkWell, GestureDetector
- [ ] ExpansionTile, TabBar
- [ ] BottomSheet, Dialog triggers

---

## Phase 3: Action System (Weeks 9-10)

### 3.1 Navigation Actions

- [ ] `navigate` - Page navigation
- [ ] `pop` - Back navigation
- [ ] `replace` - Replace route

### 3.2 API Actions

- [ ] `api_call` - REST API calls
- [ ] `refresh_bindings` - Refresh data

### 3.3 UI Actions

- [ ] `show_dialog` - Display dialogs
- [ ] `show_bottom_sheet` - Display sheets
- [ ] `show_toast` - Toast messages

### 3.4 Static Actions (Bridge to Native)

- [ ] `biometric_verify`
- [ ] `sign_transaction`
- [ ] `capture_document`
- [ ] `scan_card`

---

## Phase 4: Form System (Weeks 11-12)

### 4.1 Form Engine

- [ ] Form state management
- [ ] Field validation engine
- [ ] Custom validators registry
- [ ] Form submission handler

### 4.2 Workflow Engine

- [ ] Step navigation
- [ ] Step state persistence
- [ ] Conditional step logic
- [ ] BPMS task resolver

---

## Phase 5: Migration (Weeks 13-20)

### 5.1 Menu System Migration (Week 13)

**Priority: HIGH** - Already partially SDUI

```
Current: menuWeb.json → MenuDataModel
Target: Full SDUI menu with navigation
```

- [ ] Enhance existing menu JSON
- [ ] Add navigation actions
- [ ] Add dynamic icons
- [ ] Add user segment rules

### 5.2 Banner System Migration (Week 14)

**Priority: HIGH** - Already partially SDUI

- [ ] Convert BannerData to SDUI
- [ ] Add carousel component
- [ ] Add click actions

### 5.3 List Views Migration (Weeks 15-16)

**Priority: HIGH**

| Screen | Complexity |
|--------|------------|
| Card List | Medium |
| Transaction List | High |
| Notification List | Low |
| Bill List | Medium |

### 5.4 BPMS Workflow Migration (Weeks 17-20)

**Priority: HIGHEST** - 150+ screens

```
Week 17: Marriage Loan (24 screens)
Week 18: Children Loan (23 screens)
Week 19: Military Guarantee (47 screens)
Week 20: Other workflows
```

---

## Phase 6: Backend Integration (Parallel)

### 6.1 SDUI API Endpoints

```
POST   /sdui/v1/app-config      → Entry point JSON
GET    /sdui/v1/pages/{id}      → Page JSON
GET    /sdui/v1/flows/{id}      → Workflow JSON
GET    /sdui/v1/components/{id} → Component JSON
GET    /sdui/v1/menu            → Menu JSON
GET    /sdui/v1/theme           → Theme JSON
POST   /sdui/v1/actions/execute → Server-side actions
```

### 6.2 Content Management

- [ ] SDUI Admin Panel
- [ ] Version management
- [ ] A/B testing support
- [ ] Analytics integration

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      Tobank SDUI App                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────┐    ┌──────────────────────────┐  │
│  │    STATIC CORE       │    │      SDUI ENGINE         │  │
│  │                      │    │                          │  │
│  │  ├── Auth Service    │    │  ├── JSON Parser         │  │
│  │  ├── Crypto Service  │◄──►│  ├── Widget Registry     │  │
│  │  ├── Biometric       │    │  ├── Action Registry     │  │
│  │  ├── Storage         │    │  ├── Data Bindings       │  │
│  │  └── API Client      │    │  └── State Manager       │  │
│  └──────────────────────┘    └──────────────────────────┘  │
│            │                            │                   │
│            ▼                            ▼                   │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                   WIDGET LAYER                        │  │
│  │                                                       │  │
│  │  ├── SDUIPageRenderer                                 │  │
│  │  ├── SDUIFormRenderer                                 │  │
│  │  ├── SDUIWorkflowRenderer                             │  │
│  │  └── SDUIComponentRenderer                            │  │
│  └──────────────────────────────────────────────────────┘  │
│                          │                                  │
└──────────────────────────┼──────────────────────────────────┘
                           │
                           ▼
              ┌────────────────────────┐
              │    SDUI Backend API    │
              │                        │
              │  ├── Page Service      │
              │  ├── Flow Service      │
              │  ├── Menu Service      │
              │  └── Theme Service     │
              └────────────────────────┘
```

---

## File Structure

```
lib/
├── core/                          # STATIC CORE
│   ├── auth/
│   ├── security/
│   ├── network/
│   └── storage/
│
├── sdui/                          # SDUI ENGINE
│   ├── engine/
│   │   ├── sdui_engine.dart
│   │   ├── json_parser.dart
│   │   └── expression_evaluator.dart
│   │
│   ├── registry/
│   │   ├── widget_registry.dart
│   │   ├── action_registry.dart
│   │   └── validator_registry.dart
│   │
│   ├── widgets/
│   │   ├── containers/
│   │   ├── displays/
│   │   ├── inputs/
│   │   └── interactive/
│   │
│   ├── actions/
│   │   ├── navigate_action.dart
│   │   ├── api_action.dart
│   │   ├── dialog_action.dart
│   │   └── static_action.dart
│   │
│   ├── bindings/
│   │   ├── data_binding_manager.dart
│   │   └── expression_parser.dart
│   │
│   ├── forms/
│   │   ├── form_engine.dart
│   │   ├── form_validator.dart
│   │   └── form_state.dart
│   │
│   ├── workflows/
│   │   ├── workflow_engine.dart
│   │   └── step_navigator.dart
│   │
│   ├── renderers/
│   │   ├── page_renderer.dart
│   │   ├── form_renderer.dart
│   │   └── workflow_renderer.dart
│   │
│   └── cache/
│       └── cache_manager.dart
│
└── main.dart
```

---

## Risk Mitigation

### Risk 1: Performance
**Mitigation:**
- Widget caching
- Lazy loading
- Background JSON prefetch
- Compiled widget trees

### Risk 2: Offline Support
**Mitigation:**
- Local JSON cache
- Fallback to cached version
- Graceful degradation

### Risk 3: Security
**Mitigation:**
- JSON signature validation
- Action whitelist
- No dynamic code execution
- Server-side validation

### Risk 4: Backward Compatibility
**Mitigation:**
- Version negotiation
- Feature flags
- Gradual rollout

---

## Success Metrics

| Metric | Target |
|--------|--------|
| JSON Parse Time | < 50ms |
| Page Render Time | < 100ms |
| Cache Hit Rate | > 90% |
| BPMS Coverage | 100% |
| Code Reduction | 40% |
| Release Frequency | 10x faster |

---

## Team Requirements

| Role | Count | Responsibility |
|------|-------|----------------|
| Flutter Lead | 1 | Architecture, Core Engine |
| Flutter Dev | 2 | Widgets, Actions, Forms |
| Backend Dev | 1 | SDUI APIs, CMS |
| QA Engineer | 1 | Testing, Validation |

---

## Timeline Summary

| Phase | Duration | Status |
|-------|----------|--------|
| Phase 1: Foundation | Weeks 1-4 | 🔴 Not Started |
| Phase 2: Widgets | Weeks 5-8 | 🔴 Not Started |
| Phase 3: Actions | Weeks 9-10 | 🔴 Not Started |
| Phase 4: Forms | Weeks 11-12 | 🔴 Not Started |
| Phase 5: Migration | Weeks 13-20 | 🔴 Not Started |
| Phase 6: Backend | Parallel | 🔴 Not Started |

**Total Estimated Duration: 20 weeks (5 months)**

---

## Next Steps

1. ✅ Complete documentation (this document)
2. 🔲 Review with team
3. 🔲 Set up project structure
4. 🔲 Begin Phase 1 development
5. 🔲 Create sample JSON files for testing

