const ethers = require("hardhat")

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unstorageTime = currentTimestampInSeconds + 60;

  const storageAmount = ethers.parseEther("0.001");

  const storage = await ethers.deployContract("Storage", [unstorageTime], {
    value: storageAmount,
  });

  await storage.waitForDeployment();

  console.log(
    `storage with ${ethers.formatEther(
      storageAmount
    )}ETH and unstorage timestamp ${unstorageTime} deployed to ${storage.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});