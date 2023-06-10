const { ethers } = require("ethers")
import hre from 'hardhat'
import "@nomicfoundation/hardhat-ethers"

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unstorageTime = currentTimestampInSeconds + 60;
  
  const storageAmount = ethers.parseEther("0.001");
  console.log("parse")

  const Storage = await hre.ethers.getContractFactory("Storage");
  console.log("contract")
  const storage = await Storage.deploy();
  console.log("deployment")
  await storage.deployed();
  console.log("deployed")

  console.log(
    `storage with ${ethers.formatEther(
      storageAmount
    )}ETH and unstorage timestamp ${unstorageTime} deployed to ${storage.target},
      address contract: ${storage.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});