const { expect } = require("chai");

describe("Liquidity Pool", function () {

  let LiquidityPool, pool, owner, user, AaveToken, aave;

  beforeEach(async function () {

    [owner, user] = await ethers.getSigners();

    // Mock AAVE token contract
    AaveToken = await ethers.getContractFactory("MockERC20");
    aave = await AaveToken.deploy("Aave", "AAVE", 18);
    await aave.deployed();

    LiquidityPool = await ethers.getContractFactory("LiquidityPool");
    pool = await LiquidityPool.deploy(aave.address);
    await pool.deployed();
  });

  it("Should allow deposits and update balances", async function () {
    const amount = ethers.utils.parseUnits("100", 18);
    await aave.mint(user.address, amount);

    await aave.connect(user).approve(pool.address, amount);
    await pool.connect(user).deposit(amount);

    expect(await pool.balances(user.address)).to.equal(amount);
  });

  it("Should allow withdrawals and update balances", async function () {
    const amount = ethers.utils.parseUnits("100", 18);
    await aave.mint(user.address, amount);
    await aave.connect(user).approve(pool.address, amount);
    await pool.connect(user).deposit(amount);

    await pool.connect(user).withdraw(amount);

    expect(await pool.balances(user.address)).to.equal(0);
  });
});