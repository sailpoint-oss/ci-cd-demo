#!/usr/bin/env bats

setup() {
    if [ $environment == dev ]; then
        echo "Running tests for DEV environment"
        IDENTITY_PROFILE="8b9960eebbdd43029393edd9dcf25976"
        IDENTITY_ID="1d2d747380634a38a48f079422833ed6"
    fi
    if [ $environment == main ]; then
        echo "Running tests for PROD environment"
        IDENTITY_PROFILE="350f8bd2ceef428386c35b3230972fc9"
        IDENTITY_ID="5f7e663b7dee41a5b121bc1b164858d5"
    fi
}

@test "Verify DeriveFirstInitialLastNameInUpper Transform" {
    RESULT="$(sail transform preview --profile $IDENTITY_PROFILE --identity $IDENTITY_ID --file transform_files/DeriveFirstInitialLastNameInUpper.json -r)"
    [ "$RESULT" = "AKENNEDY" ]
}

@test "Verify DetermineLicense Transform" {
    RESULT="$(sail transform preview --profile $IDENTITY_PROFILE --identity $IDENTITY_ID --file transform_files/DetermineLicense.json -r)"
    [ "$RESULT" = "licensed" ]
}

@test "Verify DetermineLifecycleState Transform" {
    RESULT="$(sail transform preview --profile $IDENTITY_PROFILE --identity $IDENTITY_ID --file transform_files/DetermineLifecycleState.json -r)"
    [ "$RESULT" = "prehire" ]
}

@test "Verify FormatGCPEmail Transform" {
    RESULT="$(sail transform preview --profile $IDENTITY_PROFILE --identity $IDENTITY_ID --file transform_files/FormatGCPEmail.json -r)"
    [ "$RESULT" = "adam.kennedy@se-gcp.sailpointtechnologies.com" ]
}

@test "Verify FormatSailpointEmail Transform" {
    RESULT="$(sail transform preview --profile $IDENTITY_PROFILE --identity $IDENTITY_ID --file transform_files/FormatSailpointEmail.json -r)"
    [ "$RESULT" = "adam.kennedy@sailpoint.com" ]
}

@test "Verify DeriveFirstNameLastInitial Transform" {
    RESULT="$(sail transform preview --profile $IDENTITY_PROFILE --identity $IDENTITY_ID --file transform_files/DeriveFirstNameLastInitial.json -r)"
    [ "$RESULT" = "ADAMK" ]
}

@test "Verify MyNewTest Transform" {
    RESULT="$(sail transform preview --profile $IDENTITY_PROFILE --identity $IDENTITY_ID --file transform_files/MyNewTest.json -r)"
    [ "$RESULT" = "aKennedy01RstP*!7" ]
}
