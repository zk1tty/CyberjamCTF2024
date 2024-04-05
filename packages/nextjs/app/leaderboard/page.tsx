"use client";

import type { NextPage } from "next";
// import { useAccount } from "wagmi";
import { Address } from "~~/components/scaffold-eth";
import { useScaffoldContractRead } from "~~/hooks/scaffold-eth";

const LeaderBoard: NextPage = () => {
  // const { address: connectedAddress } = useAccount();
  const { data: numberOfPlayers } = useScaffoldContractRead({
    contractName: "CyberjamNFT",
    functionName: "getNumberOfPlayers",
  });

  const { data: allPlayers } = useScaffoldContractRead({
    contractName: "CyberjamNFT",
    functionName: "getAllPlayers",
  });

  // return uint256[]
  const { data: playersLevels } = useScaffoldContractRead({
    contractName: "CyberjamNFT",
    functionName: "getPlayersLevels",
  });

  // return uint256[]
  const { data: playersScores } = useScaffoldContractRead({
    contractName: "CyberjamNFT",
    functionName: "getPlayersScores",
  });

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <div className="flex justify-center items-center space-x-2">
              <img src="/catbg.png" alt="Cat" width={100} height={100} />
              <img src="./QR-cyberjam.png" width={100} height={100} />
              <img src="/doge-removebg-preview.png" alt="Dog" width={100} height={100} />
              {/* <p className="my-2 font-medium">Connected Address:</p>
              <Address address={connectedAddress} /> */}
            </div>
            <span className="block text-4xl font-bold">
              {numberOfPlayers ? numberOfPlayers.toString() : 0} players!
            </span>
          </h1>

          {playersLevels &&
            playersScores &&
            allPlayers?.map((player, index) => (
              <div key={index} className="flex justify-between items-center my-4 bg-base-100 rounded-md">
                <p className="bg-base-300 px-2 mx-2 rounded-md">{player.codename}:</p>
                <p className="text-xl font-bold mx-2">🕵🏽‍♀️{playersScores[index].toString()} Captured 🚩</p>
                <Address address={player.addr} />

                <img
                  src={`/nftimages/${player.team === 0 ? "Cat" : "Dog"}/${playersLevels[index].toString()}.jpg`}
                  alt="NFT Image"
                  className="rounded-3xl mx-2"
                  width={50}
                  height={50}
                />
              </div>
            ))}
        </div>
      </div>
    </>
  );
};

export default LeaderBoard;
