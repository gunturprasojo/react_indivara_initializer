#!/usr/bin/env ruby

def create_config_env
  paths_dev_name = ".env.development"
  paths_production_name = ".env.production"
  example_env_initializer = <<~TYPESCRIPT
    VITE_API_BASE_URL=
    VITE_API_TOKEN=
  TYPESCRIPT


  # Build the shell command as a string
  <<~CMD
    echo "#{example_env_initializer.strip}" > #{paths_dev_name}
    echo "#{example_env_initializer.strip}" > #{paths_production_name}
  CMD
end