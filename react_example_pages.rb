#!/usr/bin/env ruby

def create_example_pages
  paths_name = "index.tsx"
  example_pages_initializer = <<~TYPESCRIPT
    import { ExamplePageHooksProps } from '@/hooks/example/useExamplePageHooks';

    const ExamplePage = (hooks: ExamplePageHooksProps) => {
      const controller = hooks.controller;
      const data = hooks.data;

      return (
        <div></div>
      );
    };

    export default ExamplePage;

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    mkdir -p pages/example &&
    echo "#{example_pages_initializer.strip}" > pages/example/#{paths_name}
  CMD
end