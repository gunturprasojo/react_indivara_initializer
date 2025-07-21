#!/usr/bin/env ruby

def create_example_utils
  paths_name = "numberUtil.ts"
  example_utils_initializer = <<~TYPESCRIPT
    export const formatIntlNumber = (
      data: number,
      maximumDecimals = 6,
      minimumDecimals = 2
    ): string => {
      return new Intl.NumberFormat('en-US', {
        minimumFractionDigits: minimumDecimals,
        maximumFractionDigits: maximumDecimals,
      }).format(data);
    };


  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_utils_initializer.strip}" > utils/#{paths_name}
  CMD
end