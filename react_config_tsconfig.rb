#!/usr/bin/env ruby

def create_config_tsconfig
  paths_name = "tsconfig.json"
  example_tsconfig_initializer = <<~JSON
  {
    "files": [],
    "compilerOptions": {
      "target": "ES6",
      "module": "ESNext",
      "lib": ["DOM", "ESNext"],
      "jsx": "react-jsx",
      "esModuleInterop": true,
      "moduleResolution": "Node",
      "allowSyntheticDefaultImports": true,
      "baseUrl": "./src",
      "paths": {
        "@/*": ["*"]
      },
      "types": ["jest", "node"]
    },
    "references": [
      { "path": "./tsconfig.app.json" },
      { "path": "./tsconfig.node.json" }
    ]
  }
  JSON

  paths_app_name = "tsconfig.app.json"
  example_tsconfig_app_initializer = <<~JSON
  {
    "compilerOptions": {
      "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.app.tsbuildinfo",
      "target": "ES2020",
      "useDefineForClassFields": true,
      "lib": ["ES2020", "DOM", "DOM.Iterable"],
      "module": "ESNext",
      "skipLibCheck": true,

      /* Bundler mode */
      "moduleResolution": "bundler",
      "allowImportingTsExtensions": true,
      "isolatedModules": true,
      "moduleDetection": "force",
      "noEmit": true,
      "jsx": "react-jsx",

      /* Linting */
      "strict": true,
      "noUnusedLocals": true,
      "noUnusedParameters": true,
      "noFallthroughCasesInSwitch": true,
      "noUncheckedSideEffectImports": true,
       
      "allowJs": true,
      "checkJs": false,

      /* Path mapping */
      "baseUrl": ".",
      "paths": {
        "@/*": ["src/*"]
      },
      "rootDir": "src"
    },
    "include": ["src"]
  }
  JSON

  # Use proper escaping via heredoc and file redirection
  <<~CMD
    mkdir -p . &&
    cat <<EOF > #{paths_name}
      #{example_tsconfig_initializer.strip}
    EOF

    cat <<EOF > #{paths_app_name}
      #{example_tsconfig_app_initializer.strip}
    EOF
  CMD
end