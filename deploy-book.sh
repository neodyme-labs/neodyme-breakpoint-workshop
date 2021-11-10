#!/usr/bin/env bash

mkdir -p book-target
cargo install mdbook

mdbook build -d book-target

echo "workshop.neodyme.io" > book-target/CNAME

mkdir -p /tmp/book
git worktree add -B gh-pages /tmp/book
rm -rf /tmp/book/*
cp -rp book-target/* /tmp/book/
cd /tmp/book &&
    git add -A &&
    git commit -m "deploy" &&
    git push origin gh-pages --force
