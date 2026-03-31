# Personal environment rules

## Nix on this machine

This mac uses Nix.

When a required tool or binary is missing, do not stop and ask me to install it first.
Prefer using Nix directly so work can continue immediately.

Preferred order:
1. If a one-off command is enough, use `nix run`.
2. If multiple commands from a package are needed, use `nix shell`.
3. Only suggest permanent installation when it is clearly better than ephemeral use.

**Always single-quote flake references** containing `#` (e.g., `'nixpkgs#gh'`, `'github:nix-community/nix-index#nix-locate'`).

When trying to locate which package contains an executable or file, use:

`nix run github:nix-community/nix-index#nix-locate -- <path-or-file>`

Example:
`nix run github:nix-community/nix-index#nix-locate -- bin/hello`

This finds packages that provide the exact file, so you can then use `nix shell <package>` or `nix run <package>`.

## Working style

Assume I want the agent to be self-sufficient.
Prefer ephemeral Nix-based execution over asking me to prepare the environment manually.
Explain briefly what package or command you chose, then continue.
