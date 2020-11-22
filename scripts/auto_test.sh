if grep -q "sdk: flutter" pubspec.yaml; then
  flutter test --no-pub
else
  dart test
fi