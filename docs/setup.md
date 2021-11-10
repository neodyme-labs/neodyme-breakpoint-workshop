# Setup

To be able to write exploits, you need an appropriate development-environment.
If you have developed Solana contracts on your device before, feel free to just use your existing setup. We also provide high-powered remote development environments, where everything is ready to go.

Depending on how comfortable you are with your current environment, there are three options:
- Fully remote development: We host a VS-Code instance, which you can access via the browser. This is the easiest to get going with, but some keybinds might be weird.
- Fully local development: You checkout out git-repo and go from there. Recommended for experienced devs with fast local environment, most difficult to setup.
- Mixed development: Still get the benefits of a local VS-Code (your settings, all shortcuts), while relying on remote compute. Also requires some local setup.

Should you have one of the new M1 Macs, we recommend you use remote or mixed development. This is because Solana's rBPF-JIT is not supported there, and we currently have no way of disabling it in our setup.

## Easy Option: Remote Setup
We have access credentials to our servers printed. On it, you'll find the domain you should connect to, as well as a password.

The server runs a headless instance of VS-Code, setup with rust-analyzer. To access it, go to `http://YOUR_ID.workshop.neodyme.io` and enter your password. Multiple users will be able to access the same instance with shared code, but the live collaboration features are limited.

If you are using Chrome, the usual VS-Code shortcuts will work. Firefox is a bit more restrictive, and you might have to use the menu instead of some shortcuts.

To get a terminal on the server, you can either use ssh, or simply use VS-Code's build-in terminal (Open with either `` Ctrl+Shift+` ``, or `Menu->View->Terminal`). The workspace is located at `/work`.

Go-to-definition can be done with `Ctrl+Left Mouse Button`, going back with `Ctrl+Alt+Minus`

On the server, you have full root access. Please don't abuse it for non-workshop-related purposes.


## Flexible Option: Local Setup

For the local setup, you'll need to fetch our prepared contracts and exploit-harnesses at [Github](https://github.com/neodyme-labs/neodyme-breakpoint-workshop). In addition, you'll need an up-to-date version of Rust. Should you wish to render these docs locally, you can do so with mdbook: 

```
cargo install mdbook
mdbook serve
```

If you encounter the error

```
error: failed to download `solana-frozen-abi v1.8.2`
```

or

```
thread 'main' panicked at 'called `Result::unwrap()` on an `Err` value: Os { code: 2, kind: NotFound, message: "No such file or directory" }', /home/user/.cargo/registry/src/github.com-1ecc6299db9ec823/poc-framework-0.1.2/src/lib.rs:522:81
```

then the contract failed to build. This is likely caused by a too old rust or solana-toolchain. Ensure you have the latest versions by running:

```sh
rustup default stable
rustup update
solana-install init 1.7.17
```



## Third Option: Combined Setup
It is possible to use remove-development with VS-Code via the [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension. Unfortunately, this extension is only available for the original microsoft binary builds, and not open-source builds of VSCode.

1. Open VS-Code
2. Install the Remote Development extension (`Remote - SSH`), if not installed already
3. Press `Ctrl+Shift+P` to open the command palette.
4. Enter `Remote-SSH: Connect to Host...`
5. Enter the user and address of your assigned instance, eg `user@1.workshop.neodyme.io`
6. Enter your password when prompted
7. Click `Open Folder` and open the workspace at `/work`
8. The workspace will open. You'll operate on the same files as you would via the fully-remote setup.
9. Install the Rust-Analyzer extension on the remote.

## Compiling the contracts and running the exploits

We provide five contracts and five exploit harnesses, all in the same cargo workspace. As they all use the same dependencies, we can save disk space and compile-time that way.
Each contract is in its own crate (`level0 - level4`). For the exploits, we have pre-setup harnesses using our PoC-Framework contained in the `pocs` folder, though more on that later.

To make compiling and running the exploits painless, especially on the remote instances, we have provided  pre-configured build targets in VS-Code. To compile and run an exploit, you can press `Ctrl+Shift+B` and then select the exploit you are working on.

In the VS-Code based workflow, all contracts are rebuild automatically whenever you run an exploit. You can also trigger this rebuilding manually by selecting the `build contracts` option in VS-Code's build menu.

If you don't want to use this workflow, you have to rebuild the contracts yourself whenever you change something (for example introducing logging).

Compiling and running the old-fashioned way via terminal is possible as well. Each exploit complies to its own binary, which you can select via the `--bin` argument for cargo:

```sh
# compile all contracts
cargo build-bpf --workspace

# run level3 exploit
RUST_BACKTRACE=1 cargo run --bin level3
```
