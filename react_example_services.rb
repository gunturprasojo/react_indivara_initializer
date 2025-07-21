#!/usr/bin/env ruby

def create_example_services
  paths_name = "exampleService.ts"
  example_service_initializer = <<~TYPESCRIPT
    import { API_PREFIX, baseApi } from '@/services/baseApi';
    import { ExampleParameter } from '@/types/parameters/exampleParameter';
    import { ExampleResponse } from '@/types/responses/exampleResponse';

    export const exampleService = baseApi.injectEndpoints({
      endpoints: (builder) => ({
        getSomething: builder.query<
          ExampleResponse,
          ExampleParameter
        >({
          query: (params) => ({
            url: '/path',
            method: 'GET',
            params,
          }),
        }),

      }),
    });

    export const {
        useGetSomethingQuery,
        useLazyGetSomethingQuery,
    } = exampleService;

  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_service_initializer.strip}" > services/#{paths_name}
  CMD
end