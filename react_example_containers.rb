#!/usr/bin/env ruby

def create_example_containers
  paths_name = "exampleContainer.ts"
  example_paths_initializer = <<~TYPESCRIPT
    import { useExamplePageHooks } from '@/hooks/example/useExamplePageHooks';
    import ExamplePage from '@/pages/example';

    export const ExampleContainer = () => {
      const hooks = useExamplePageHooks();
      return <ExamplePage controller={hooks.controller} data={hooks.data} />;
    };

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    mkdir -p containers/example &&
    echo "#{example_paths_initializer.strip}" > containers/example/#{paths_name}
  CMD
end