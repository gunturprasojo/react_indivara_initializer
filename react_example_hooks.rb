#!/usr/bin/env ruby

def create_example_hooks
  paths_name = "useExamplePageHooks.tsx"
  example_pages_initializer = <<~TYPESCRIPT
    export interface ExamplePageHooksControllerProps {
      doSomething: () => void;
    }
    export interface ExamplePageHooksDataProps {
      someData:string;
    }

    export interface ExamplePageHooksProps {
      controller: ExamplePageHooksControllerProps;
      data: ExamplePageHooksDataProps;
    }

    export const useExamplePageHooks = (): ExamplePageHooksProps => {
      
        const doSomething = () => {

        }

      return {
        controller: {
          doSomething,
        },
        data: {
          someData:'someData'
        },
      };
    };

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    mkdir -p hooks/example &&
    echo "#{example_pages_initializer.strip}" > hooks/example/#{paths_name}
  CMD
end