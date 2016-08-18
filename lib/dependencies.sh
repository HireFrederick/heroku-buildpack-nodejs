run_if_present() {
  local script_name=${1:-}
  local has_script=$(read_json "$BUILD_DIR/package.json" ".scripts[\"$script_name\"]")
  if [ -n "$has_script" ]; then
    echo "Running $script_name"
    npm run "$script_name" --if-present
  fi
}

install_node_modules() {
  local build_dir=${1:-}

  if [ -e $build_dir/package.json ]; then
    cd $build_dir/client

    if [ -e $build_dir/npm-shrinkwrap.json ]; then
      echo "Installing node modules (package.json + shrinkwrap)"
    else
      echo "Installing node modules (package.json)"
    fi
    echo "Daniel Rox $NPM_TOKEN"
    echo "Daniel Rox ${NPM_TOKEN}"
    npm config set //registry.npmjs.org/:_authToken=${NPM_TOKEN}

    npm install --unsafe-perm --userconfig $build_dir/.npmrc 2>&1
  else
    echo "Skipping (no package.json)"
  fi
}

rebuild_node_modules() {
  local build_dir=${1:-}

  if [ -e $build_dir/package.json ]; then
    cd $build_dir
    echo "Rebuilding any native modules"
    npm rebuild 2>&1
    if [ -e $build_dir/npm-shrinkwrap.json ]; then
      echo "Installing any new modules (package.json + shrinkwrap)"
    else
      echo "Installing any new modules (package.json)"
    fi
    echo "Daniel Rox 22222 $NPM_TOKEN"
    echo "Daniel Rox 22222 ${NPM_TOKEN}"
    npm config set //registry.npmjs.org/:_authToken=${NPM_TOKEN}

    npm install --unsafe-perm --userconfig $build_dir/.npmrc 2>&1
  else
    echo "Skipping (no package.json)"
  fi
}
