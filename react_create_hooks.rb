#!/usr/bin/env ruby

def create_hooks(component_name: nil, function_names: nil)
  raise ArgumentError, "component_name is required" if component_name.nil? || component_name.strip.empty?

  # Format component and file names
  upper_first_name = component_name.split('_').map(&:capitalize).join
  directory = component_name.downcase
  file_name = "use#{upper_first_name}PageHooks.tsx"
  file_path = "hooks/#{directory}/#{file_name}"

  # Naming
  hook_name = "use#{upper_first_name}PageHooks"
  interface_prefix = "#{upper_first_name}PageHooks"

  # Function names
  function_names_list = function_names&.split(',')&.map(&:strip) || []

  # Interface definitions
  interface_functions_initializer = function_names_list.map { |name| " #{name}: () => void;" }.join("\n")

  # Hook function implementations
  implementation_functions_initializer = function_names_list.map do |name|
    <<~TS.strip
  const #{name} = () => {
    // TODO: implement #{name}
  };
    TS
  end.join("\n\n")

  # Exported function references
  export_functions_initializer = function_names_list.map { |name| "    #{name}," }.join("\n")

  # Full hook content
  hook_initializer = <<~TYPESCRIPT
export interface #{interface_prefix}ControllerProps {
  #{interface_functions_initializer}
}

export interface #{interface_prefix}DataProps {
  someData: string;
}

export interface #{interface_prefix}Props {
  controller: #{interface_prefix}ControllerProps;
  data: #{interface_prefix}DataProps;
}

export const #{hook_name} = (): #{interface_prefix}Props => {

  #{implementation_functions_initializer}

  return {
    controller: {
      #{export_functions_initializer}
    },
    data: {
      someData: 'someData',
    },
  };
};
  TYPESCRIPT

  # Return shell command string
  <<~CMD
    mkdir -p hooks/#{directory} &&
    echo "#{hook_initializer.strip}" > #{file_path}
  CMD
end