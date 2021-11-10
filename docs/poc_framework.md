# PoC Framework

The so called `PoC-Framework` is a tool we developed to help us quickly testing bugs in smart-contracts.
Especially for more complicated bugs, it is often easier to verify an idea practically rather than statically by just reading code.

This is usually a multistep process. First, you obviously do not want to test on the live Solana chain.
That means you have to replicate the setup locally somehow. If you have ever tried to write integration-tests for smart-contracts before, you'll know that it is a bit annoying to get the correct setup.

For normal contract usage, you'd have a Rust cli or some web3js that generates instructions and send them via RPC to a validator. On the validator, the contract is already initialized, and your instructions can be executed by the network, returning you the result.

For testing, it is often times not necessary to have a full network. Just the solana smart-contract runtime is enough to see most behaviour.

This is where the `PoC-Framework` comes in. It is a collection of helper methods to interact with the core solana code in a way that is similar to what would happen when a contract is used on the normal network.

An exploit utilizing the framework consists of three parts: setup code (marked with the comment: "SETUP CODE BELOW"), the actual exploit (the `fn hack()` function you will write) and a check if the exploit succeeded (the `fn verify()` function). We have already provided the first and the last one in the poc files for you, just the exploit is missing.

To see how the Framework can help you, its best to check out the functions provided by the `Environment`: [poc_framework::Environment docs](https://docs.rs/poc-framework/0.1.2/poc_framework/trait.Environment.html)

## Exploit outline

- hacker is a key with 1 sol for paying fees n stuff.
- GOAL: give this hacker more money than he started with. Does not necessarily have to be all the money, just more.
- `fn verify()` will check this for you automatically, so you know when you have succeeded.
