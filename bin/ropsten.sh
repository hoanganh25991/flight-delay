#!/bin/bash

PASSWORD=/home/ubuntu/.eth-accounts/password

parity \
--author 0xc73bA89c340a5839473b2486fbf3af479Aa8e620 \
--unlock 0xc73bA89c340a5839473b2486fbf3af479Aa8e620,\
0xfb3eb19cf16d4aF3B9e190e80A2f0C48ab4f1188,\
0x3DeEe88A871433a5709c93eF63Eb04F4eACE0ac5,\
0x448f8EC95B31A64436222c013C668E7634984C79,\
0x33eC7255FD0acF37e48868FB75e3DBdd12Fcbdf4,\
0x37fBb918808d2c505Bc7274e9Df771D537A3989f,\
0x165A5b95298B2F03bb2a2276Ea91e066D25f8573,\
0xC809d1AA78D55Fe99782A8Fa278425DAB8871c58,\
0x26b83c6c87c25721218289587abC0c032ba7A12e \
--password=$PASSWORD \
--mode active \
--force-ui \
--geth \
--ui-interface 0.0.0.0 \
--jsonrpc-interface '0.0.0.0' --jsonrpc-hosts all \
--unsafe-expose \
--chain ropsten
