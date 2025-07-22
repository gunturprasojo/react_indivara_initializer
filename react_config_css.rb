#!/usr/bin/env ruby

def create_config_css
  paths_name = "index.css"
  example_pages_initializer = <<~TYPESCRIPT
   /* import fonts @import url('https://fonts.googleapis.com/css2?family=Source+Sans+3:wght@300;400;500;600;700&display=swap'); */

  @import 'tailwindcss';

  :root {
    --font-serif: 'Source Sans 3', sans-serif;
    --default-font-family: var(--font-serif);
  }

  body {
    font-family: var(--default-font-family);
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_pages_initializer.strip}" > styles/#{paths_name}
  CMD
end