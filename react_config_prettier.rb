#!/usr/bin/env ruby

def create_config_prettier
  paths_name = ".prettierrc"
  example_prettier_initializer = <<~JSON
    {
      "printWidth": 80,
      "tabWidth": 2,
      "useTabs": false,
      "semi": true,
      "singleQuote": true,
      "trailingComma": "es5",
      "bracketSpacing": true,
      "jsxBracketSameLine": false,
      "arrowParens": "always",
      "proseWrap": "preserve",
      "endOfLine": "lf",
      "plugins": ["prettier-plugin-tailwindcss"],
      "tailwindFunctions": ["clsx", "cva", "primary"],
      "tailwindPreserveWhitespace": true,
      "tailwindPreserveDuplicates": true
    }

  JSON

  # Build the shell command as a string
  # <<~CMD
  #   echo "#{example_prettier_initializer.strip}" > #{paths_name}
  # CMD
  File.write(paths_name, example_prettier_initializer.strip)
end