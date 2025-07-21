#!/usr/bin/env ruby

def create_config_eslint
  paths_name = "eslint.config.mjs"
  example_eslint_initializer = <<~TYPESCRIPT
    /* eslint-disable import-x/namespace */
    /* eslint-disable import-x/no-named-as-default-member */
    import eslint from '@eslint/js';
    import * as tsParser from '@typescript-eslint/parser';
    import * as eslintConfigPrettier from 'eslint-config-prettier/flat';
    import { createTypeScriptImportResolver } from 'eslint-import-resolver-typescript';
    import eslintPluginImportX from 'eslint-plugin-import-x';
    import eslintPluginPrettierRecommended from 'eslint-plugin-prettier/recommended';
    import pluginReact from 'eslint-plugin-react';
    import * as reactHooks from 'eslint-plugin-react-hooks';
    import reactRefresh from 'eslint-plugin-react-refresh';
    import * as regexpPlugin from 'eslint-plugin-regexp';
    import globals from 'globals';
    import tseslint, { configs as tsConfigs } from 'typescript-eslint';

    export default tseslint.config(
      {
        ignores: ['**/dist//**', '**/node_modules//**'],
      },
      {
        extends: [
          eslint.configs.recommended,
          tsConfigs.strict,
          tsConfigs.stylistic,
          regexpPlugin.configs['flat/recommended'],
          eslintPluginImportX.flatConfigs.recommended,
          eslintPluginImportX.flatConfigs.typescript,
          pluginReact.configs.flat.recommended,
          reactRefresh.configs.recommended,
          reactHooks.configs['recommended-latest'],
          eslintPluginPrettierRecommended,
        ],
      },
      {
        settings: {
          react: {
            version: 'detect',
          },
          'import-x/resolver-next': [
            createTypeScriptImportResolver({
              alwaysTryTypes: true,
              resolvePackageJsonExports: true,
              project: ['tsconfig.app.json', 'tsconfig.json'],
            }),
          ],
        },
      },
      {
        languageOptions: {
          parser: tsParser,
          ecmaVersion: 'latest',
          sourceType: 'module',
          globals: globals.browser,
        },
      },
      {
        files: ['./src/**/*.{ts,tsx}'],
      },
      {
        rules: {
          'prefer-const': [
            'error',
            {
              destructuring: 'any',
              ignoreReadBeforeAssign: false,
            },
          ],
          'react/prop-types': 'off',
          'react/react-in-jsx-scope': 'off',
          'react/jsx-uses-vars': 'error',
          '@typescript-eslint/no-unused-vars': [
            'error',
            {
              args: 'all',
              argsIgnorePattern: '^_',
              caughtErrors: 'all',
              caughtErrorsIgnorePattern: '^_',
              destructuredArrayIgnorePattern: '^_',
              varsIgnorePattern: '^_',
              ignoreRestSiblings: true,
            },
          ],
          'no-unused-vars': 'off',
          quotes: ['error', 'double'],
          ...eslintConfigPrettier.rules,

          'import-x/order': [
            'error',
            {
              groups: [
                'builtin',
                'external',
                'internal',
                'parent',
                'sibling',
                'index',
              ],
              'newlines-between': 'always',
            },
          ],
          'func-style': ['error', 'expression'],
          'prefer-arrow-callback': 'error',
          'no-console': 'warn',
        },
      }
    );


  TYPESCRIPT

  # Build the shell command as a string
  <<~CMD
    echo "#{example_eslint_initializer.strip}" > #{paths_name}
  CMD
end