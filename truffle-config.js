require("dotenv").config();
const HDWalletProvider = require("@truffle/hdwallet-provider");
const INFURA_API_KEY = "https://sepolia.infura.io/v3/50ac20f15ecd44c792c5d5a0d9c774a8";
const MNEMONIC = "solid fog skirt auction pizza left obscure swarm cool envelope basket spoon";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Localhost (default: none)
      port: 9545, // Standard Ethereum port (default: none)
      network_id: "*", // Any network (default: none)
    },
    sepolia: {
      provider: () => new HDWalletProvider({
        mnemonic: {
          phrase: MNEMONIC
        },
        providerOrUrl: INFURA_API_KEY
      }),
      network_id: "11155111",
      gas: 4465030,
    },
  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.0", // Fetch exact version from solc-bin (default: truffle's version)
    },
  },

  // db: {
  //   enabled: false,
  //   host: "127.0.0.1",
  //   adapter: {
  //     name: "indexeddb",
  //     settings: {
  //       directory: ".db"
  //     }
  //   }
  // }
};
