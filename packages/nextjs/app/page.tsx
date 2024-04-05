import type { NextPage } from "next";

const Home: NextPage = () => {
  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <h1 className="text-center">
          <span className="block text-2xl mb-2">Welcome to Cyberjam Capture The Flag</span>
          <h2>If you don&apos;t wave a blockchain wallet? We will help you to create a wallet :D</h2>
          <div className="flex justify-center items-center space-x-2">
            <img src="/catbg.png" alt="Cat" width={100} height={100} />
            <img src="./QR-cyberjam.png" width={100} height={100} />
            <img src="/doge-removebg-preview.png" alt="Dog" width={100} height={100} />
            {/* <p className="my-2 font-medium">Connected Address:</p>
              <Address address={connectedAddress} /> */}
          </div>
        </h1>
      </div>
    </>
  );
};

export default Home;
