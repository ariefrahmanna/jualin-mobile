## Git Commit Message Template

### Full Message Format

A commit message consists of a **type** and **subject**:

```
<type>: <subject>
```

**Example**:

```
feat: add login screen page
```

### Type

Must be one of the following:

* __feat__: A new feature
* __chore__: Changes that do not relate to a fix or feature and don't modify src or test files (e.g. updating dependencies)
* __fix__: A bug fix
* __refactor__: A code change that neither fixes a bug nor adds a feature
* __perf__: A code change that improves performance
* __test__: Adding missing tests or correcting existing tests
* __docs__: Documentation only changes

### Subject

The subject contains a short description of the change:

* use the imperative, present tense: "add" not "added" nor "adds"
* don't capitalize the first letter
* no dot (.) at the end
