echo Installing dependencies
dart pub global activate melos
export PATH="$PATH":"$HOME/.pub-cache/bin"
melos bootstrap

for PACKAGE in packages/*; do
  echo "Checking format of $PACKAGE"
  cd ./$PACKAGE
  dart format --set-exit-if-changed .
  cd -
done

for PACKAGE in packages/*; do
  echo "Analyzing $PACKAGE"
  cd ./$PACKAGE
  dart analyze .
  cd -
done

for PACKAGE in packages/*; do
  echo "Testing $PACKAGE"
  cd ./$PACKAGE
  if grep -q "sdk: flutter" pubspec.yaml; then
    flutter test --no-pub
  else
    dart test
  fi
  cd -
done
