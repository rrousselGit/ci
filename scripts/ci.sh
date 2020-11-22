# importing auto_test.sh
mkdir scripts
curl -s https://raw.githubusercontent.com/rrousselGit/ci/ci/scripts/auto_test.sh > auto_test.sh
chmod +x scripts/auto_test.sh

# installing dependencies
dart pub global activate melos
export PATH="$PATH":"$HOME/.pub-cache/bin"
melos bootstrap

# analyzing and testing the codebase
melos exec -- dart format --set-exit-if-changed .
melos exec -- dart analyze .
melos exec --  ../../scripts/auto_test.sh
