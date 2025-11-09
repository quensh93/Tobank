# Flow Diagrams

## 🎯 Overview

This document contains comprehensive flow diagrams for understanding how Stac works internally.

## 📊 Complete System Flow

### 1. Application Initialization

```mermaid
sequenceDiagram
    participant App
    participant Stac as Stac.initialize()
    participant Registry as StacRegistry
    participant Parser as Widget Parsers
    participant ActionParser as Action Parsers
    
    App->>Stac: initialize(parsers, actionParsers)
    Stac->>Registry: Register parsers
    Registry->>Parser: store() for each parser
    Stac->>Registry: Register action parsers
    Registry->>ActionParser: store() for each action parser
    Stac->>App: Ready
```

### 2. Widget Rendering Flow

```mermaid
sequenceDiagram
    participant User
    participant Service as StacService
    participant Registry as StacRegistry
    participant Parser as Widget Parser
    participant Model as Widget Model
    participant Flutter as Flutter Widget
    
    User->>Service: fromJson(json, context)
    Service->>Service: Extract type from JSON
    Service->>Registry: getParser(type)
    Registry->>Service: Return parser
    Service->>Parser: getModel(json)
    Parser->>Model: fromJson(json)
    Model->>Parser: Return model
    Service->>Parser: parse(context, model)
    Parser->>Flutter: Build Flutter widget
    Flutter->>User: Render widget
```

### 3. Action Execution Flow

```mermaid
sequenceDiagram
    participant User
    participant Widget as Interactive Widget
    participant Service as StacService
    participant Registry as StacRegistry
    participant ActionParser as Action Parser
    participant ActionModel as Action Model
    participant Logic as Business Logic
    
    User->>Widget: Tap/Interaction
    Widget->>Service: onCallFromJson(actionJson, context)
    Service->>Service: Extract actionType
    Service->>Registry: getActionParser(actionType)
    Registry->>Service: Return action parser
    Service->>ActionParser: getModel(actionJson)
    ActionParser->>ActionModel: fromJson(actionJson)
    ActionModel->>ActionParser: Return model
    Service->>ActionParser: onCall(context, model)
    ActionParser->>Logic: Execute business logic
    Logic->>User: Show result (navigation, dialog, etc.)
```

## 🔄 State Management Flow

### 4. Setting State

```mermaid
sequenceDiagram
    participant JSON
    participant SetValue as SetValue Widget
    participant Registry as StacRegistry
    participant Variables as _variables Map
    
    JSON->>SetValue: Parse JSON
    SetValue->>SetValue: initState()
    SetValue->>Registry: setValue(key, value)
    Registry->>Variables: Store key-value
    Variables->>Registry: Confirmed
    Registry->>SetValue: Done
```

### 5. Resolving Variables

```mermaid
sequenceDiagram
    participant JSON
    participant Resolver as VariableResolver
    participant Registry as StacRegistry
    participant Variables as _variables Map
    
    JSON->>Resolver: resolveVariables(json, registry)
    Resolver->>Resolver: Find {{variable}} matches
    Resolver->>Registry: getValue(variableName)
    Registry->>Variables: Lookup key
    Variables->>Registry: Return value
    Registry->>Resolver: Return value
    Resolver->>Resolver: Replace {{variable}}
    Resolver->>JSON: Return resolved JSON
```

## 🌐 Data Flow

### 6. Dynamic View Data Flow

```mermaid
sequenceDiagram
    participant JSON
    participant DynamicView as StacDynamicView
    participant Network as Network Service
    participant API
    participant Template as Template Processing
    participant Widget as Flutter Widget
    
    JSON->>DynamicView: Parse JSON
    DynamicView->>Network: Request data
    Network->>API: HTTP Request
    API->>Network: Response
    Network->>DynamicView: Return data
    DynamicView->>DynamicView: Extract data (targetPath)
    DynamicView->>Template: Apply data to template
    Template->>Template: Process placeholders
    Template->>Widget: Build widget
    Widget->>JSON: Render
```

### 7. Template Processing Flow

```mermaid
flowchart TD
    A[Template JSON] --> B{Has itemTemplate?}
    B -->|Yes| C[Iterate data list]
    B -->|No| D[Process single item]
    C --> E[Apply template to each item]
    E --> F[Extract item data]
    F --> G[Replace placeholders]
    G --> H[Process recursively]
    D --> G
    H --> I[Resolved JSON]
    I --> J[Parse to Widget]
```

## 🎨 Widget Lifecycle

### 8. Widget Lifecycle (with SetValue)

```mermaid
stateDiagram-v2
    [*] --> Created: Parse JSON
    Created --> initState: StatefulWidget
    initState --> SetVariables: SetValue widget
    SetVariables --> Render: Build child
    Render --> Active: Display widget
    Active --> Active: User interaction
    Active --> dispose: Remove from tree
    dispose --> RemoveVariables: SetValue widget
    RemoveVariables --> [*]
```

## 🔗 Component Interactions

### 9. Complete Request-Response Cycle

```mermaid
graph TD
    A[User Action] --> B[Action Triggered]
    B --> C{Action Type}
    C -->|Network| D[API Call]
    C -->|Navigation| E[Route Change]
    C -->|Dialog| F[Show Dialog]
    C -->|SetValue| G[Update State]
    G --> H[Variable Resolution]
    H --> I[Widget Rebuild]
    D --> J[Response Received]
    J --> K[Dynamic View Update]
    K --> H
```

### 10. Parsing Flow

```mermaid
flowchart LR
    A[Raw JSON] --> B[Type Extraction]
    B --> C[Get Parser]
    C --> D[Parse to Model]
    D --> E{Need Resolution?}
    E -->|Yes| F[Variable Resolution]
    E -->|No| G[Build Widget]
    F --> G
    G --> H[Flutter Widget]
```

## 🏗️ Architecture Layers

### 11. Layer Interaction

```mermaid
graph TB
    subgraph "Application Layer"
        App[Flutter App]
    end
    
    subgraph "Stac Service Layer"
        Service[StacService]
        Registry[StacRegistry]
    end
    
    subgraph "Parser Layer"
        WParser[Widget Parsers]
        AParser[Action Parsers]
    end
    
    subgraph "Model Layer"
        WModel[Widget Models]
        AModel[Action Models]
    end
    
    subgraph "Foundation Layer"
        Core[Core Types]
    end
    
    App --> Service
    Service --> Registry
    Service --> WParser
    Service --> AParser
    WParser --> WModel
    AParser --> AModel
    WModel --> Core
    AModel --> Core
```

## 🔍 Error Handling Flow

### 12. Error Handling

```mermaid
flowchart TD
    A[Parse JSON] --> B{Parser Found?}
    B -->|No| C[Log Warning]
    B -->|Yes| D[getModel]
    D --> E{Valid Model?}
    E -->|No| C
    E -->|Yes| F[parse]
    F --> G{Parse Success?}
    G -->|No| H[Return Error Widget]
    G -->|Yes| I[Return Widget]
    C --> H
```

## 📦 Package Dependencies

### 13. Package Dependency Flow

```mermaid
graph LR
    stac_core --> stac_logger
    stac --> stac_core
    stac --> stac_framework
    stac --> stac_logger
    stac_framework --> stac_core
    stac_webview --> stac
    App --> stac
```

## 🎯 Summary

These diagrams cover:

1. **Initialization**: How Stac starts up
2. **Widget Rendering**: JSON to Flutter widget
3. **Action Execution**: User interactions
4. **State Management**: Setting and getting state
5. **Variable Resolution**: Template processing
6. **Data Flow**: Dynamic content
7. **Widget Lifecycle**: Creation to disposal
8. **Request-Response**: Complete cycles
9. **Parsing Flow**: JSON transformation
10. **Architecture**: Layer interactions
11. **Error Handling**: Error recovery
12. **Dependencies**: Package relationships

Use these diagrams to understand the complete flow and identify improvement opportunities.
