#!/usr/bin/env ruby

def create_example_paths
  paths_name = "paths.ts"
  example_paths_initializer = <<~TYPESCRIPT
    enum Paths {
      LOGIN = '/login',
      DASHBOARD = '/dashboard',
      EXAMPLE = '/example',
    }

    export default Paths;
  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_paths_initializer.strip}" > constants/enums/#{paths_name} 
  CMD
end