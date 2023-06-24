// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

// import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/**
 * @title NFTRetriever
 * @dev A contract that retrieves NFTs
 */
contract NFTRetriever {
    
    /**
     * @dev Retrieves the owner of an NFT
     * @param _nftAddress The address of the NFT contract
     * @param _tokenId The ID of the NFT
     * @return The address of the owner of the NFT
     */
    function getNFTOwner(address _nftAddress, uint256 _tokenId) external view returns (address) {
        IERC721 nft = IERC721(_nftAddress);
        return nft.ownerOf(_tokenId);
    }

}