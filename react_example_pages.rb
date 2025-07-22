#!/usr/bin/env ruby

def create_example_pages
  paths_name = "index.tsx"
  example_pages_initializer = <<~TYPESCRIPT
    import { useExamplePageHooks } from '@/hooks/example/useExamplePageHooks';

    export const ExamplePage = () => {
      const {controller, data} = useExamplePageHooks();

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