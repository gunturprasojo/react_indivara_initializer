#!/usr/bin/env ruby

def create_example_store
  paths_name = "index.tsx"
  example_store_initializer = <<~TYPESCRIPT
    import {
      configureStore,
      isRejectedWithValue,
      Middleware,
      MiddlewareAPI,
    } from '@reduxjs/toolkit';
    import { setupListeners } from '@reduxjs/toolkit/query';

    import { baseApi } from '@/services/baseApi';

    export const errorMiddleware: Middleware =
      (_api: MiddlewareAPI) => (next) => (action) => {
        if (isRejectedWithValue(action)) {
          /* empty */
        }
        return next(action);
      };

    export const store = configureStore({
      reducer: {
        // auth: authReducer,
        [baseApi.reducerPath]: baseApi.reducer,
      },
      middleware: (getDefaultMiddleware) =>
        getDefaultMiddleware().concat(baseApi.middleware, errorMiddleware),
    });

    setupListeners(store.dispatch);

    export type RootState = ReturnType<typeof store.getState>;
    export type AppDispatch = typeof store.dispatch;


  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_store_initializer.strip}" > routes/#{paths_name}
  CMD
end