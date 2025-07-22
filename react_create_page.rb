#!/usr/bin/env ruby

def create_page(component_name:)
  # Ensure component_name is valid
  raise ArgumentError, "component_name is required" if component_name.nil? || component_name.strip.empty?

  # Convert to PascalCase
  upper_first_name = component_name.split('_').map(&:capitalize).join

  file_name = "index.tsx"
  directory = component_name.downcase
  file_path = "pages/#{directory}/#{file_name}"
  import_path = "@/hooks/#{directory}/use#{upper_first_name}PageHooks"

  initializer = <<~TYPESCRIPT
    import { use#{upper_first_name}PageHooks } from '#{import_path}';

    export const #{upper_first_name} = () => {
      const { controller, data } = use#{upper_first_name}PageHooks();

      return (
        <div></div>
      );
    };

    export default #{upper_first_name};
  TYPESCRIPT

  <<~CMD
    mkdir -p pages/#{directory} &&
    echo "#{initializer.strip}" > #{file_path}
  CMD
end