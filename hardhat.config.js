/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();
module.exports = {
  solidity: "0.8.17",
  networks: {
    bscTestnet: {
      url: process.env.BSC_TESTNET,          // URL của BSC testnet từ .env
      accounts: [process.env.OWNER_PRIV_KEY] // Khóa riêng tư từ .env

    },
  },
};
