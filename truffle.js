module.exports = {
    networks: {
        mainnet: {
            network_id: 1, // Ethereum public network
            host: 'localhost',
            port: 8545,
            from: '0x6f692c070f3263d1c3400367832faf5ccc6cd2f2', // 0 - deployer
            gas: 5000000,
            gasPrice: 4000000000,
        },
        mainnet2: {
            network_id: 1, // Ethereum public network
            host: '35.158.95.25',
            port: 8545,
            from: '0x6f692c070f3263d1c3400367832faf5ccc6cd2f2', // 0 - deployer
        },
        kovan: {
            network_id: 42, // custom private network
            host: 'localhost',
            port: 8545,
            from: '0x1885bf0a04c6948061007cb556935a903b1bed95', // 0 - deployer
            unlock: [
                '0x189a99226ad233df825cc1f9d48c8afba529b803', // 1 - new owner & FD.Owner
                '0x1d45c059e511241a5c1b3081e56302a59621c94c', // 2 - FD.Funder
                '0x5226d6ce4d0b84ec9f8214ee4f5883738dad130e', // 3 - FD.CustomersAdmin
                '0x6e5dc1285a441627c0046604586b081bbe41fbc8', // 4 - FD.Emeregency
                '0x79e3c795890175180c492b66b69f0d35ff031de4', // 5 - Customer
                '0xa3a645c963ca4c03328afbd9a79f45716b492231', // 6 - Test 1
                '0xc3878b8566f5626fb8d6ad43b647e3405668f20b', // 7 - Test 2
                '0xc95efc83de5832510dac2c29198279eb8662d77e', // 8 - Test 3
            ], // to unlock in parity
            addressResolver: '0x48fbda035c53d7d4e7a0ac8adc1fd88e541e7336',
            funder: '0x74c90c06e20113c9e628f9ce374611db28da1f93', // multisig
            gas: 4500036,
        },
        ropsten: {
            network_id: 3, // custom private network
            host: '0.0.0.0',
            port: 8545,
            from: '0xc73bA89c340a5839473b2486fbf3af479Aa8e620', // 0 - deployer
            unlock: [
                '0xc73bA89c340a5839473b2486fbf3af479Aa8e620',
                '0xfb3eb19cf16d4aF3B9e190e80A2f0C48ab4f1188', // 1 - new owner & FD.Owner
                '0x3DeEe88A871433a5709c93eF63Eb04F4eACE0ac5', // 2 - FD.Funder
                '0x448f8EC95B31A64436222c013C668E7634984C79', // 3 - FD.CustomersAdmin
                '0x33eC7255FD0acF37e48868FB75e3DBdd12Fcbdf4', // 4 - FD.Emeregency
                '0x37fBb918808d2c505Bc7274e9Df771D537A3989f', // 5 - Customer
                '0x165A5b95298B2F03bb2a2276Ea91e066D25f8573', // 6 - Test 1
                '0xC809d1AA78D55Fe99782A8Fa278425DAB8871c58', // 7 - Test 2
                '0x26b83c6c87c25721218289587abC0c032ba7A12e', // 8 - Test 3
            ], // to unlock in parity
            addressResolver: '0x79080604029FAF6f407665554C0Dc65eEA8F662f',
            gas: 4700000,
        },
        development: {
            // host: 'docker.for.mac.localhost',
            host: 'localhost',
            port: 9545,
            network_id: '*',
        },
    },
    solc: {
        optimizer: {
            enabled: true,
            runs: 200,
        },
    },
};
