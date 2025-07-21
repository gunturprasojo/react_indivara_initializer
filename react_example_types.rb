#!/usr/bin/env ruby

def create_example_types
  parameter_name = "exampleParameter.ts"
  example_parameter_initializer = <<~TYPESCRIPT
    export interface ExampleParameter {
      param_field?: string;
    }

  TYPESCRIPT

  request_name = "exampleRequest.ts"
  example_request_initializer = <<~TYPESCRIPT
    export interface ExampleRequest {
      request_field?: string;
    }

  TYPESCRIPT

  response_name = "exampleResponse.ts"
  example_response_initializer = <<~TYPESCRIPT
    export interface ExampleResponse {
      response_field?: string;
    }

  TYPESCRIPT

  <<~CMD
    echo "#{example_parameter_initializer.strip}" > types/parameters/#{parameter_name}
    echo "#{example_request_initializer.strip}" > types/requests/#{request_name}
    echo "#{example_response_initializer.strip}" > types/responses/#{response_name}
  CMD
end