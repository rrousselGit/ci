dart pub global activate melos
export PATH="$PATH":"$HOME/.pub-cache/bin"

melos bootstrap

melos exec -- dart format --set-exit-if-changed .
melos exec -- dart analyze .
melos exec --  ../../scripts/auto_test.sh
