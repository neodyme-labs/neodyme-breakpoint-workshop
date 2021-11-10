# Introduction

Welcome to the Solana Security Workshop!
Here, we'll look at Solana Smart Contracts from an attacker's perspective.
By learning how to find and exploit different types of issues, you'll be able to write more secure contracts as you'll know what to watch out for.

In the first part of the course, we'll introduce concepts relevant to the security of Solana Contracts and explore one vulnerability in detail.
After this part, we've prepared several smart contracts as challenges.
Each of these will illustrate a different Solana smart contract bug.
You're encouraged to work on exploiting these on your own. If you get stuck, please ask questions, we love to help. If you are attending remotely, this book will also provide some hints, which we recommend you read only if you don't progress yourself.

Much code you'll see during this workshop is intentionally vulnerable. Even if the bugs are fixed, the code does not follow good design guidelines. Please do all of us a favor and not use it outside of security demonstrations.

## Requirements

To follow along with this course, you need to be familiar with writing solana contracts and the [Rust](https://rust-lang.org/) programming language.

You'll also need an environment where you can compile the example contracts and run the attacks.
We have prepared remote environments if you need them, for details, see [Setup](setup.md).

## Who We Are

We started as a group of independent researchers, who love digging into complex concepts and projects. At the end of 2020 we have been introduced into the Solana ecosystem by looking at Solana-core code, in which we have found a number of vulnerabilities. We have since founded the security-research firm [Neodyme](https://neodyme.io), which has been helping the Solana Foundation with peer-reviews of smart contracts.

As such, we have found lots of interesting and critical bugs in smart contracts.
To help make the Ecosystem a more secure place, we want to share what we can in this short 3h workshop. We hope you enjoy breaking our prepared contracts as much as we do.
