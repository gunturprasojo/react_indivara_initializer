#!/usr/bin/env ruby

def create_hooks_test(component_name: nil, function_names: nil, from: nil)
  raise ArgumentError, "component_name is required" if component_name.nil? || component_name.strip.empty?

  # Format component and file names
  upper_first_name = component_name.split('_').map(&:capitalize).join
  upper_from = from.split('_').map(&:capitalize).join
  downcase_from = from.downcase
  directory = component_name.downcase
  file_name = "use#{upper_first_name}#{upper_from}Hooks.test.tsx"
  file_path = "#{downcase_from}s/#{directory}/#{file_name}"

  # Naming
  hook_name = "use#{upper_first_name}#{upper_from}Hooks"

  # Function names
  function_names_list = function_names&.split(',')&.map(&:strip) || []

  # Hook function implementations
  implementation_functions_initializer = function_names_list.map do |name|
    <<~TS.strip
  it('should be able to call #{name} without errors', () => {
    const { result } = renderHook(() => #{hook_name}());
    act(() => {
      result.current.controller.#{name}();
    });
    expect(result.current.data.someData).toBeDefined(); // Just confirming no errors
  });
    TS
  end.join("\n\n")

  # Exported function references
  export_functions_initializer = function_names_list.map { |name| "    #{name}," }.join("\n")

  # Full hook content
  hook_initializer = <<~TYPESCRIPT
import { renderHook, act } from '@testing-library/react';
import { #{hook_name} } from './#{hook_name}';


describe('#{hook_name}', () => {

  #{implementation_functions_initializer}

});
  TYPESCRIPT

  # Return shell command string
  <<~CMD
    mkdir -p #{downcase_from}s/#{directory} &&
    echo "#{hook_initializer.strip}" > #{file_path}
  CMD
end