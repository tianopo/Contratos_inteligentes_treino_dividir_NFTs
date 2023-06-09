import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
const ethers = require("hardhat")

describe("Storage", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployOneYearStorageFixture() {
    const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
    const ONE_GWEI = 1_000_000_000;

    const StorageAmount = ONE_GWEI;
    const unStorageTime = (await time.latest()) + ONE_YEAR_IN_SECS;

    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const Storage = await ethers.getContractFactory("Storage");
    const storage = await Storage.deploy(unStorageTime, { value: StorageAmount });

    return { Storage, unStorageTime, StorageAmount, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should set the right unStorageTime", async function () {
      const { Storage, unStorageTime } = await loadFixture(deployOneYearStorageFixture);

      expect(await Storage.unStorageTime()).to.equal(unStorageTime);
    });

    it("Should set the right owner", async function () {
      const { Storage, owner } = await loadFixture(deployOneYearStorageFixture);

      expect(await Storage.owner()).to.equal(owner.address);
    });

    it("Should receive and store the funds to Storage", async function () {
      const { Storage, StorageAmount } = await loadFixture(
        deployOneYearStorageFixture
      );

      expect(await ethers.provider.getBalance(Storage.target)).to.equal(
        StorageAmount
      );
    });

    it("Should fail if the unStorageTime is not in the future", async function () {
      // We don't use the fixture here because we want a different deployment
      const latestTime = await time.latest();
      const Storage = await ethers.getContractFactory("Storage");
      await expect(Storage.deploy(latestTime, { value: 1 })).to.be.rejectedWith(
        "UnStorage time should be in the future"
      );
    });
  });

  describe("Withdrawals", function () {
    describe("Validations", function () {
      it("Should revert with the right error if called too soon", async function () {
        const { Storage } = await loadFixture(deployOneYearStorageFixture);

        await expect(Storage.withdraw()).to.be.rejectedWith(
          "You can't withdraw yet"
        );
      });

      it("Should revert with the right error if called from another account", async function () {
        const { Storage, unStorageTime, otherAccount } = await loadFixture(
          deployOneYearStorageFixture
        );

        // We can increase the time in Hardhat Network
        await time.increaseTo(unStorageTime);

        // We use Storage.connect() to send a transaction from another account
        await expect(Storage.connect(otherAccount).withdraw()).to.be.rejectedWith(
          "You aren't the owner"
        );
      });

      it("Shouldn't fail if the unStorageTime has arrived and the owner calls it", async function () {
        const { Storage, unStorageTime } = await loadFixture(
          deployOneYearStorageFixture
        );

        // Transactions are sent using the first signer by default
        await time.increaseTo(unStorageTime);

        await expect(Storage.withdraw()).not.to.be.rejected;
      });
    });

    describe("Events", function () {
      it("Should emit an event on withdrawals", async function () {
        const { Storage, unStorageTime, StorageAmount } = await loadFixture(
          deployOneYearStorageFixture
        );

        await time.increaseTo(unStorageTime);

        await expect(Storage.withdraw())
          .to.emit(Storage, "Withdrawal")
          .withArgs(StorageAmount, anyValue); // We accept any value as `when` arg
      });
    });

    describe("Transfers", function () {
      it("Should transfer the funds to the owner", async function () {
        const { Storage, unStorageTime, StorageAmount, owner } = await loadFixture(
          deployOneYearStorageFixture
        );

        await time.increaseTo(unStorageTime);

        await expect(Storage.withdraw()).to.changeEtherBalances(
          [owner, Storage],
          [StorageAmount, -StorageAmount]
        );
      });
    });
  });
});
