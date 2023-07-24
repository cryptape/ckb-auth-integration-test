set -e
echo "get capsule "
rustup update
cargo install cross --git https://github.com/cross-rs/cross
cargo install ckb-capsule --git https://github.com/nervosnetwork/capsule.git --tag v0.9.2

echo "download ckb-auth"
git clone https://github.com/contrun/ckb-auth.git
cd ckb-auth
git checkout solana

echo "build contract"
git submodule update --init
make all-via-docker

echo "compile auth-demo"
capsule build
make -f examples/auth-demo/Makefile all-via-docker

echo "build ckb-auth-cli"
cd tools/ckb-auth-cli && cargo build