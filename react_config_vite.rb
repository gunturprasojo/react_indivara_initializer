#!/usr/bin/env ruby

def create_config_vite
  paths_name = "vite.config.ts"
  example_vite_initializer = <<~TYPESCRIPT
    import path from 'path';

    import tailwindcss from '@tailwindcss/vite';
    import react from '@vitejs/plugin-react-swc';
    import { defineConfig, loadEnv } from 'vite';

    export default defineConfig(({ mode }) => {
      process.env = { ...process.env, ...loadEnv(mode, process.cwd()) };

      return defineConfig({
        plugins: [react(), tailwindcss()],
        resolve: {
          alias: {
            '@': path.resolve(__dirname, './src'),
          },
        },
        server: {
          port: 3000,
        },
      });
    });


  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_vite_initializer.strip}" > #{paths_name}
  CMD
end