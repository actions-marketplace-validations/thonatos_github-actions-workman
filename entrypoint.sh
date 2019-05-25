#!/bin/sh
set -e

# add ssh config
if [ -n "$RELEASE_SSH_ID_RSA" ] && [ -n "$RELEASE_SSH_ID_RSA" ]; then
  echo "# add ssh config";

  mkdir -p /root/.ssh;
  echo "$RELEASE_SSH_ID_RSA" > /root/.ssh/id_rsa;
  echo "$RELEASE_SSH_ID_RSA_PUB" > /root/.ssh/id_rsa.pub;
  chmod 400 /root/.ssh/id_rsa;
  chmod 400 /root/.ssh/id_rsa.pub;
  git config --global user.name "Release Bot";
  git config --global user.email "release_bot@eggjs.app";
fi

# add npm config
if [ -n "$NPM_AUTH_TOKEN" ]; then
  echo "# add npm config";

  # Respect NPM_CONFIG_USERCONFIG if it is provided, default to $HOME/.npmrc
  NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG-"$HOME/.npmrc"}";
  NPM_REGISTRY_URL="${NPM_REGISTRY_URL-registry.npmjs.org}";
  NPM_STRICT_SSL="${NPM_STRICT_SSL-true}";
  NPM_REGISTRY_SCHEME="https";
  if ! $NPM_STRICT_SSL
  then
    NPM_REGISTRY_SCHEME="http";
  fi

  # Allow registry.npmjs.org to be overridden with an environment variable
  printf "//%s/:_authToken=%s\\nregistry=%s\\nstrict-ssl=%s" "$NPM_REGISTRY_URL" "$NPM_AUTH_TOKEN" "${NPM_REGISTRY_SCHEME}://$NPM_REGISTRY_URL" "${NPM_STRICT_SSL}" > "$NPM_CONFIG_USERCONFIG";

  chmod 0600 "$NPM_CONFIG_USERCONFIG";
fi

node dist/index.js;