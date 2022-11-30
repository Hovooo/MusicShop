const hre = require("hardhat");
import { HardhatRuntimeEnvironement } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironement) {
  const { deployments, getNamedAccounts } = hre;

  const deploy = deployments;

  const deploer = await getNamedAccounts();

  await deploy("MusicShop", {
    from: deploer,
    //args: ["hello!"],
    log: true,
  });
};

export default func;
func.tags = ["MusicShop"];
