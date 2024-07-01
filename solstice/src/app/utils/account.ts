import { createWalletClient, http, createPublicClient } from "viem";
import { polygonAmoy } from "viem/chains";
import { useAccount } from "wagmi";

export const { address: userAccount } = useAccount();

export const walletClient = createWalletClient({
  account: userAccount,
  chain: polygonAmoy,
  transport: http(),
});

export const publicClient = createPublicClient({
  chain: polygonAmoy,
  transport: http(),
});
