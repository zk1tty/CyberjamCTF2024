import type { NextPage } from "next";

const Home: NextPage = () => {
  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <h1 className="text-center">
          <span className="block text-2xl mb-2">Welcome to Cyberjam @ CypherCon 2024: Capture The Flag</span>
          <span className="block text-3xl mb-3">Cat vs Dog</span>
          {/* <span className="p-1 bg-green-300 rounded-md">Try Connect Wallet </pan> */}
          <div className="flex justify-center items-center space-x-2">
            <img src="/catbg.png" alt="Cat" width={100} height={100} />
            <img src="./QR-cyberjam.png" width={100} height={100} />
            <img src="/doge-removebg-preview.png" alt="Dog" width={100} height={100} />
          </div>
        </h1>
      </div>

      <div className="flex items-center flex-col flex-grow pt-10">
        <h1 className="text-center text-3xl mb-2">📛The game rule📛</h1>
        <div className="text-center">
          <h3>Participants choose to join either Dog or Cat team.</h3>
          <h3>Your mission is to mint a Flag nft from each Flag contract.</h3>
          <h3>
            If you collect all 5 nfts, then your main animal NFT will be updated to be a cooler one. 😎 And get our cute
            badges.!
          </h3>
          <h3>We offered a free beer for winners at our unofficial after-party at a brewery🍻 in downtown.</h3>
          <a href="https://www.tikit.live/e/cypher-party/" target="_blank" rel="noreferrer" className="link">
            Sign up afterparty!
          </a>
        </div>
      </div>

      <div className="flex items-center flex-col flex-grow">
        <div className="text-center">
          <h1 className="text-3xl mb-2 ">🪴Preparation🪴</h1>
          <h2 className="text-xl">1. Do you have a crypto wallet to connect to web?</h2>
          <h3>If no, install Metamask!</h3>
          <h2 className="text-xl">2.Access from mobile?</h2>
          <h3>If yes, then please open this website from Metamask In-app Browser.</h3>
          <h2 className="text-xl">3. Register your codename and team</h2>
          <h3>go to Flag page, fill in registerAndMintNFT() function, and send tx.</h3>
          <div className="flex justify-center items-center">
            <img src="./registerFunction.png" width={400} />
          </div>
          <h2 className="text-xl">4.get Flag contract address</h2>
          <h3>At Flag page, getGameAddress returns an array of Flag contract addresses.</h3>
          <h3>Try to call the function with 0 at first.</h3>
          <div className="flex justify-center items-center">
            <img src="./getGameAddress.png" width={400} />
          </div>
        </div>
      </div>
    </>
  );
};

export default Home;
