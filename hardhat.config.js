require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  
  networks: {
    rinkeby: {
       url: "https://eth-rinkeby.alchemyapi.io/v2/Dvmge58rt8F1pyob2cwHpJZ3xzdU4DFj",
       accounts: ["76f65b29f5c05059d58ad8bbda4c4ef65578a60be4fd68602407f43093ab8d3f"]
    },
  },

  etherscan: {
    apiKey: "RTAIHRSYN8SYHITXG9CXR74K4P1K3SD5M3",
  },

  setting: {
    optimizer: {
      enabled: true,
      runs: 1000,
    }
  }
};
