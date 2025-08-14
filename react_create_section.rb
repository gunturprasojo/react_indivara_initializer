#!/usr/bin/env ruby

def create_section(component_name:)
  # Ensure component_name is valid
  raise ArgumentError, "component_name is required" if component_name.nil? || component_name.strip.empty?

  # Convert to PascalCase
  upper_first_name = component_name.split('_').map(&:capitalize).join

  file_name = "index.tsx"
  directory = component_name.downcase
  file_path = "sections/#{directory}/#{file_name}"
  import_path = "@/sections/#{directory}/use#{upper_first_name}SectionHooks"

  initializer = <<~TYPESCRIPT
    import { use#{upper_first_name}SectionHooks } from '#{import_path}';

    export const #{upper_first_name}Section = () => {
      const { controller, data } = use#{upper_first_name}SectionHooks();

      return (
        <div></div>
      );
    };

    export default #{upper_first_name}Section;
  TYPESCRIPT

  <<~CMD
    mkdir -p sections/#{directory} &&
    echo "#{initializer.strip}" > #{file_path}
  CMD
end