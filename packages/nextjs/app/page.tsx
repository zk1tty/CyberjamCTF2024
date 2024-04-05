import type { NextPage } from "next";

const Home: NextPage = () => {
  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <h1 className="text-center">
          <span className="block text-2xl mb-2">Welcome to Cyberjam @ CypherCon 2024: Capture The Flag</span>
          <span className="block text-3xl mb-3">Cat vs Dog</span>
          <h2>If you don&apos;t have a blockchain wallet? We will help you to create a wallet :D</h2>
          {/* conditionally render instructions based on the button click "What's a Metamask" / "I've got my MetaMask" */}
          <h1 className="p-1 bg-green-300 rounded-md">What&aposs a MetaMask Button</h1>
          <div className="flex justify-center items-center space-x-2">
            <img src="/catbg.png" alt="Cat" width={100} height={100} />
            <img src="./QR-cyberjam.png" width={100} height={100} />
            <img src="/doge-removebg-preview.png" alt="Dog" width={100} height={100} />
          </div>
        </h1>
      </div>
      <div className="flex items-center flex-col flex-grow">
        <div className="text-center">
          <h1 className="text-3xl">1. Do you have a Crypto wallet?</h1>
          <h2 className="text-2xl">Yes, go to step 2.</h2>
          <h2 className="text-2xl">No, install Metamask!</h2>
        </div>
        <div className="text-center items-center">
          <h1 className="text-center text-3xl">2. Access QR code from Metamask In-app browser.</h1>
          {/* <div className="flex justify-center items-center space-x-2>
            <img src="./QR-cyberjam.png" width={100} height={100} />
          </div> */}
        </div>
      </div>
    </>
  );
};

export default Home;
