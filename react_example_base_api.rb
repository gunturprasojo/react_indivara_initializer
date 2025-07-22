#!/usr/bin/env ruby

def create_example_base_api
  paths_name = "baseApi.ts"
  example_paths_initializer = <<~TYPESCRIPT
    import {
      BaseQueryFn,
      createApi,
      FetchArgs,
      fetchBaseQuery,
      FetchBaseQueryError,
    } from '@reduxjs/toolkit/query/react';

    export const API_VERSION = '/v1';
    export const API_PREFIX = import.meta.env.VITE_API_BASE_URL;

    const baseQuery = fetchBaseQuery({
      baseUrl: API_PREFIX,
      prepareHeaders: (headers) => {
        headers.set('x-api-key', import.meta.env.VITE_API_TOKEN);
        return headers;
      },
    });

    export const baseQueryWithReauth: BaseQueryFn<
      string | FetchArgs,
      unknown,
      FetchBaseQueryError
    > = async (args, api, extraOptions) => {
      const result = await baseQuery(args, api, extraOptions);
      if (result.error?.status === 401) {
        // handle 401 Unauthorized error
      }

      return result;
    };

    export const baseApi = createApi({
      reducerPath: 'api',
      baseQuery: baseQueryWithReauth,
      refetchOnFocus: false,
      refetchOnReconnect: true,
      endpoints: () => ({}),
    });

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    &&
    echo "#{example_paths_initializer.strip}" > services/#{paths_name}
  CMD
end