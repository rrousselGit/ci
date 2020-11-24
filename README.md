This repository is a shared CI destined to be used by [Riverpod](https://github.com/rrousselGit/river_pod), [flutter_hooks](https://github.com/rrousselGit/flutter_hooks) and more.

This scripts:

- can switch between `dart test` and `flutter test` based on whether the project depends on flutter or not
- supports mono-repositories
- detects if the project needs to run code-generators
- executes `dart pub publish --dry-run` on all the packages that needs publishing
- caclulate the test coverage (both dart and flutter) and uploads it to codecov

## Usage

To execute this script, run the following command:

```sh
curl -s https://raw.githubusercontent.com/rrousselGit/ci/master/scripts/ci.sh | bash
```

See the `.github/workflows/` folder for an example on how to use it with Gitub Actions.
