/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "mumbai",
  networks: {
    hardhat: {

    },
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/exHIHkjVQ4a4xeRHoQiJw7iTZHmys6rJ",
      accounts: ["b38def016f6e2163088932101c99ad6c60bff9daae5c4c20ab9bce30f2f343a0"],
    },
    // outras redes...
  },
  solidity: {
    version: "0.8.18",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths:{
    sources: "./contracts",
    tests: "./tests",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  mocha: {
    timeout: 40000
  }
}