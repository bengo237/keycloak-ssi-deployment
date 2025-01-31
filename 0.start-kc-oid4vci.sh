#!/bin/bash

# Source common env variables
. .env

# Shutdown keycloak if any
# Determine OS platform and shutdown Keycloak if running
OS=$(uname -s)
case "$OS" in
    Linux*|Darwin*)
        keycloak_pid=$(pgrep -f keycloak)
        if [ -n "$keycloak_pid" ]; then
            echo "Keycloak instance found (PID: $keycloak_pid) on $OS. Shutting it down..."
            kill $keycloak_pid
        fi
        ;;
    *)
        echo "This script supports only Linux or macOS."
        ;;
esac

# Source Build script
. build-kc-oid4vci.sh

# Strart keycloak with OID4VCI feature
####
# Use org.keycloak.quarkus._private.IDELauncher if you want to debug through keycloak sources
export KEYCLOAK_ADMIN=$KEYCLOAK_ADMIN && export KEYCLOAK_ADMIN_PASSWORD=$KEYCLOAK_ADMIN_PASSWORD && cd $KC_INSTALL_DIR && bin/kc.sh $KC_START --features=oid4vc-vci &