#!/usr/bin/env ruby

def create_config_main
  paths_name = "main.tsx"
  example_main_initializer = <<~TYPESCRIPT
    import { StrictMode } from 'react';
    import { createRoot } from 'react-dom/client';
    import { Provider } from 'react-redux';
    import { RouterProvider } from 'react-router';

    import '@/styles/index.css';

    import { store } from '@/stores';
    import { router } from '@/routes';

    const rootElement = document.getElementById('root');
    if (rootElement) {
      createRoot(rootElement).render(
        <StrictMode>
          <Provider store={store}>
            <RouterProvider router={router} />
          </Provider>
        </StrictMode>
      );
    }

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_main_initializer.strip}" > #{paths_name}
  CMD
end