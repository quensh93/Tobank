# Contributing to Stac

Thank you for your interest in contributing to **Stac**! We value your time and effort in helping us make Stac better for everyone. By contributing, you help create a framework that is more robust, feature-rich, and accessible for developers worldwide.

## Getting Started

### 1. **Understand Stac**
If you are new to Stac, we recommend you:
- Check out the [README](./README.md) for an overview of the framework
- Explore the [documentation](https://docs.stac.dev/)
- Familiarize yourself with the codebase by browsing the repository

### 2. **Code of Conduct**
All contributors are expected to adhere to our [Code of Conduct](./CODE_OF_CONDUCT.md). Please treat everyone with respect and kindness.

## Ways to Contribute

### 1. **Reporting Issues**
If you encounter a bug or have a feature request, you can:
- **Search existing issues** to avoid duplicates
- Open a [new issue](https://github.com/StacDev/stac/issues) with a detailed description

When reporting bugs, include:
- Steps to reproduce the issue
- Expected and actual behavior
- Relevant screenshots or code snippets, if applicable

### 2. **Suggesting Enhancements**
Have ideas to improve Stac? Submit a feature request via the [issues page](https://github.com/StacDev/stac/issues). Be as descriptive as possible about the problem your suggestion solves.

### 3. **Contributing Code**

#### Step 1: Fork the Repository
- Click the **Fork** button on the repository to create your own copy
- Clone your fork locally:
  ```bash
  git clone https://github.com/<your-username>/stac.git
  cd stac
  ```

#### Step 2: Create a Branch
- Create a feature or bugfix branch for your work:
  ```bash
  git checkout -b <branch-name>
  ```
  Use a descriptive name like `fix-auth-error` or `add-dark-mode`.

#### Step 3: Make Changes
- Follow the repository's coding standards and conventions
- Ensure your code is well-documented and includes relevant comments

#### Step 4: Test Your Changes
- Run the test suite to ensure your changes don't break existing functionality:
  ```bash
  flutter test
  ```
- Write additional tests if required

#### Step 5: Commit and Push
- Commit your changes:
  ```bash
  git commit -m "Brief description of changes"
  ```
- Push to your branch:
  ```bash
  git push origin <branch-name>
  ```

#### Step 6: Open a Pull Request
- Navigate to the original repository and click **New Pull Request**
- Select your branch and provide a clear title and description for your pull request

## Contribution Guidelines

### Code Style
- Use clean and readable code with appropriate comments
- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable, function, and class names

### Commit Messages
- Write clear and descriptive commit messages
- Use the following format for commit messages:
  ```
  <type>: <subject>

  <body>
  ```
  Example:
  ```
  fix: Resolve widget alignment issue

  Fixed alignment of the header widget on smaller devices.
  ```

### Testing
- Write tests for new features
- Ensure all tests pass
- Add tests for bug fixes
- Maintain or improve test coverage

### Documentation
- Update documentation for new features
- Add code comments for complex logic
- Update README files if necessary
- Include examples for new widgets or actions

## Development Setup

### Prerequisites
- Flutter SDK (3.1.0 or higher)
- Dart SDK (3.1.0 or higher)
- Git
- IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Local Development
1. Clone the repository:
   ```bash
   git clone https://github.com/StacDev/stac.git
   cd stac
   ```

2. Install dependencies:
   ```bash
  flutter pub get
   ```

3. Run tests:
   ```bash
  flutter test
   ```

4. Run examples:
   ```bash
  cd examples/stac_gallery
  flutter run
   ```

### Project Structure
```
stac/
├── packages/
│   ├── stac/                 # Core package
│   ├── stac_core/           # Core utilities
│   ├── stac_framework/      # Framework utilities
│   ├── stac_logger/         # Logging package
│   └── stac_webview/        # WebView package
├── examples/                # Example applications
├── website/                 # Documentation website
└── docs/                    # Documentation
```

## Types of Contributions

### 1. **Bug Fixes**
- Fix existing issues
- Improve error handling
- Optimize performance
- Fix accessibility issues

### 2. **New Features**
- Add new widgets
- Add new actions
- Add new parsers
- Add new utilities

### 3. **Documentation**
- Improve existing documentation
- Add new examples
- Create tutorials
- Translate documentation

### 4. **Testing**
- Add unit tests
- Add widget tests
- Add integration tests
- Improve test coverage

### 5. **Examples**
- Create new example applications
- Improve existing examples
- Add real-world use cases
- Create tutorials

## Reviewing Pull Requests

- Be respectful and constructive when reviewing other contributors' pull requests
- Provide actionable feedback and suggest improvements where necessary
- Maintain a positive and encouraging tone
- Focus on the code, not the person

## Community Support

If you have questions or need guidance:
- Join our [community discussions](https://github.com/StacDev/stac/discussions)
- Reach out to us on our [Discord channel](https://discord.com/invite/vTGsVRK86V)
- Check the [documentation](https://docs.stac.dev/)

## Recognition

Contributors are recognized in several ways:
- Listed in the [contributors section](https://github.com/StacDev/stac/graphs/contributors)
- Featured in release notes
- Invited to join the core team for significant contributions
- Receive contributor badges and recognition

## Release Process

### Versioning
Stac follows [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Schedule
- **Major releases**: Every 6 months
- **Minor releases**: Every 2 months
- **Patch releases**: As needed

### Release Notes
- Document all changes
- Highlight new features
- List breaking changes
- Thank contributors

## Legal

### License
By contributing to Stac, you agree that your contributions will be licensed under the [MIT License](https://opensource.org/licenses/MIT).

### Copyright
You retain copyright to your contributions, but grant Stac a perpetual, worldwide, non-exclusive license to use, modify, and distribute your contributions.

## Thank You!

Your contributions help make Stac a better framework for developers worldwide. Thank you for being a part of the community!

## Next Steps

- [Community](./14-community.md) - Join the community
- [GitHub Repository](https://github.com/StacDev/stac) - Contribute to the codebase
- [Discord Community](https://discord.com/invite/vTGsVRK86V) - Connect with other developers
