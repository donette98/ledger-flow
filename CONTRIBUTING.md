# Contributing to Ledger Flow

## Code of Conduct

This project is committed to providing a welcoming and inclusive environment for all contributors.

## Getting Started

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Commit: `git commit -am 'Add feature'`
5. Push: `git push origin feature/your-feature`
6. Open a Pull Request

## Coding Standards

### Dart/Flutter
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable names
- Comment complex logic
- Format code: `dart format`
- Lint: `dart analyze`

### Swift
- Use SwiftLint
- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use meaningful names
- Proper error handling

### Kotlin
- Follow [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html)
- Use meaningful names
- Proper null safety
- Use coroutines for async

### JavaScript/Node.js
- Use ESLint configuration
- Follow [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- Use async/await
- Proper error handling

## Commit Messages

Follow conventional commits:
```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Code style
- `refactor` - Code refactoring
- `test` - Adding tests
- `chore` - Build, dependencies

Example:
```
feat(auth): add multi-factor authentication

Implement MFA support for user accounts.
- Add MFA models
- Add MFA service
- Add MFA screen

Closes #123
```

## Pull Request Process

1. Update documentation if needed
2. Add tests for new features
3. Ensure all tests pass
4. Request review from maintainers
5. Address feedback
6. Squash commits if needed
7. Wait for approval and merge

## Testing

### Unit Tests
```bash
flutter test
npm test
```

### Integration Tests
```bash
flutter drive
```

### Coverage
```bash
flutter test --coverage
```

## Documentation

- Update README.md if adding features
- Document public APIs
- Add JSDoc/dartdoc comments
- Update docs/ folder

## Reporting Issues

Include:
- Clear description
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots/logs if applicable
- System information

## Feature Requests

- Clear description of the feature
- Use cases and benefits
- Possible implementation
- Any concerns

## Questions?

Open a discussion or contact maintainers.

Thank you for contributing! 🎉
