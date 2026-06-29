# j-code-ext-csharp

A JCode **language** extension for C#: coding suggestions (snippets), a basic
formatter, and helpers. Installed through the
[JCode Marketplace](https://github.com/blamspotdev/j-code-marketplace).

See [`extension.yaml`](extension.yaml) for the manifest.

## `language` manifest schema

```yaml
type: language
language:
  id: <language id>
  extensions: [".ext", ...]      # file extensions this pack applies to
  comment: { line, blockStart, blockEnd }
  formatter:
    command: "<shell> {{file}}"   # best-effort runtime formatter ({{file}} = guest path)
    indent: <spaces>
    trimTrailingWhitespace: true
    insertFinalNewline: true
  completions:                    # coding suggestions; $1/$0 are tab stops
    - { label, detail, insert }
  helpers:                        # named snippets
    - { title, snippet }
```
