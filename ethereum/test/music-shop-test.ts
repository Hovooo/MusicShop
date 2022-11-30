import { expect } from "./chai-setup";
import { ethers, deployments, getNamedAccounts } from "hardhat";
import type { MusicShop } from "..typechain-types";

describe("MusicShop", function () {
  beforeEach(async function () {
      await deployments.fixture(["Greeter"]);
      
  });
});
