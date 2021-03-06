set -e

flutter doctor
dart --version

echo Installing dependencies
if test -d packages; then
  export PATH="$PATH":"$HOME/.pub-cache/bin"
  dart pub global activate melos
  melos bootstrap
else
  if grep -q "sdk: flutter" pubspec.yaml; then
    flutter pub get
  else
    dart pub get
  fi
fi

# Obtaining all the packages and their examples (if any)
PACKAGES=()
if test -d packages; then
  for PACKAGE in packages/*; do
    PACKAGES+=($PACKAGE)
    if test -f $PACKAGE/example/pubspec.yaml; then
      PACKAGES+=($PACKAGE/example)
    fi
  done
fi

if test -f pubspec.yaml; then
  PACKAGES+=(.)
  if test -f ./example/pubspec.yaml; then
    PACKAGES+=(./example)
  fi
fi

echo "\n${#PACKAGES[@]} package found: ${PACKAGES[@]}"

echo "\nRunning code-generators..."
for PACKAGE in ${PACKAGES[@]}; do
  cd $PACKAGE
  if grep -q "build_runner:" pubspec.yaml; then
    echo "\nCode generator detected in $PACKAGE, starting build_runner"
    if grep -q "sdk: flutter" pubspec.yaml; then
      flutter pub run build_runner build --delete-conflicting-outputs
    else
      dart pub run build_runner build --delete-conflicting-outputs
    fi
  fi
  cd - > /dev/null
done

echo "\nChecking format..."
for PACKAGE in ${PACKAGES[@]}; do
  echo "\nChecking format of $PACKAGE"
  cd $PACKAGE
  dart format --set-exit-if-changed .
  cd - > /dev/null
done

echo "\nAnalyzing..."
for PACKAGE in ${PACKAGES[@]}; do
  echo "\nAnalyzing $PACKAGE"
  cd $PACKAGE
  dart analyze .
  cd - > /dev/null
done

echo "\nTesting..."
for PACKAGE in ${PACKAGES[@]}; do
  cd $PACKAGE
  if test -d "test"; then
    echo "\nTesting $PACKAGE"
    if grep -q "sdk: flutter" pubspec.yaml; then
      if [ $1 = "nnbd" ]; then
        flutter test --no-sound-null-safety --no-pub --coverage
      else
        flutter test --no-pub --coverage
      fi
    else
      if [ $1 = "nnbd" ]; then
        dart --no-sound-null-safety test --coverage coverage
      else
        dart test --coverage coverage
      fi
      echo "test done"
      ls
      echo "ls coverage"
      ls coverage
      echo "ls coverage/test"
      ls coverage/test
      echo "obtaining coverage report"
      dart run coverage:format_coverage -l -i ./coverage/test/*.dart.vm.json -o ./coverage/lcov.info --packages ./.packages
    fi
  fi
  cd - > /dev/null
done

for PACKAGE in ${PACKAGES[@]}; do
  cd $PACKAGE
  if ! grep -q "publish_to:" pubspec.yaml; then
    echo "dry-run of 'dart pub publish' for $PACKAGE"
    dart pub lish --dry-run
  fi
  cd - > /dev/null
done

if [ "${CI}" ]; then
  echo "uploading code coverage to codecov"
  curl -s https://codecov.io/bash | bash
fi