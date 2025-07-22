#!/usr/bin/env ruby

def create_example_routes
  paths_name = "index.tsx"
  example_routes_initializer = <<~TYPESCRIPT
    import { createBrowserRouter, Navigate } from 'react-router';

    import Paths from '@/constants/enums/paths';
    import { ExamplePage } from '@/pages/example/';

    export const router = createBrowserRouter([
      {
        path: Paths.EXAMPLE,
        element: <ExamplePage />,
      },
    ]);

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_routes_initializer.strip}" > routes/#{paths_name}
  CMD
end