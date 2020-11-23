set -e

echo Installing dependencies
dart pub global activate melos
export PATH="$PATH":"$HOME/.pub-cache/bin"
melos bootstrap

# Obtaining all the packages and their examples (if any)
PACKAGES=()
for PACKAGE in packages/*; do
  PACKAGES+=($PACKAGE)
  if test -f $PACKAGE/example/pubspec.yaml; then
    PACKAGES+=($PACKAGE/example)
  fi
done

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
      dart run build_runner build --delete-conflicting-outputs
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
      flutter test --no-pub
    else
      dart test
    fi
  fi
  cd - > /dev/null
done

echo "\Dry run `dart pub publish`..."
for PACKAGE in ${PACKAGES[@]}; do
  cd $PACKAGE
  dart pub lish --dry-run
  cd - > /dev/null
done
