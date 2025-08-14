#!/usr/bin/env ruby

def create_config_jest
    paths_name = "jest.config.cjs"
    jest_config_initializer = <<~JSON
    /** @type {import('jest').Config} */
    module.exports = {
    preset: 'ts-jest',
    testEnvironment: 'jsdom',
    setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
    };
  JSON

  paths_jest_setup_name = "jest.setup.ts"
  jest_setup_initializer = <<~JSON
  import '@testing-library/jest-dom';
  JSON

  # Use proper escaping via heredoc and file redirection
  <<~CMD
    mkdir -p . &&
    cat <<EOF > #{paths_name}
      #{jest_config_initializer.strip}
    EOF

    cat <<EOF > #{paths_jest_setup_name}
      #{jest_setup_initializer.strip}
    EOF
  CMD
end