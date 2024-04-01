import React, { useEffect, useState } from "react";

interface NFTImageViewerProps {
  metadataUrl: string; // Assuming metadataUrl is a string
}

const NFTImageViewer = ({ metadataUrl }: NFTImageViewerProps) => {
  const [nftName, setNFtName] = useState("");
  const [imageUrl, setImageUrl] = useState("");
  console.log(metadataUrl);

  useEffect(() => {
    // Fetch the NFT metadata
    const fetchMetadata = async () => {
      try {
        const response = await fetch(metadataUrl);
        const metadata = await response.json();
        console.log("image:", metadata?.name);
        setNFtName(metadata.name);
        setImageUrl(metadata.image); // Set the image URL from the metadata
      } catch (error) {
        console.error("Failed to fetch NFT metadata:", error);
      }
    };

    fetchMetadata();
  }, [metadataUrl]);

  return (
    <div>
      {imageUrl ? (
        <img src={imageUrl} alt="NFT Image" style={{ maxWidth: "100%", height: "auto" }} />
      ) : (
        <p>Loading NFT image: {nftName ? nftName : ""}</p>
      )}
    </div>
  );
};

export default NFTImageViewer;
