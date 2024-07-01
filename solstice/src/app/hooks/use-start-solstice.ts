import { publicClient, walletClient, userAccount } from "../utils/account";
import { solsticeAbi, solsticeContractAddress } from "../utils/abi";
import { useState } from "react";

const useStartSolstice = () => {
  const [duration, setDuration] = useState(1);
  const [candidates, setCandidates] = useState([""]);

  const executeStartSolstice = async () => {
    try {
      const { request } = await publicClient.simulateContract({
        account: userAccount,
        address: solsticeContractAddress,
        abi: solsticeAbi,
        functionName: "startSolstice",
        args: [BigInt(duration), candidates],
      });

      const hash = await walletClient.writeContract(request);
      console.log("Transaction completed");
      console.log("Tx Hash : ", hash);
    } catch (err) {
      console.error("Error executing startSolstice:", err);
    }
  };

  return [
    duration,
    setDuration,
    candidates,
    setCandidates,
    executeStartSolstice,
  ];
};

export default useStartSolstice;
