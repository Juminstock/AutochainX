// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AutochainX is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    uint256 private tokenId;
    string[] private historial;
    uint256 private lastURIIndex;

    constructor() ERC721("Vehiculo", "BRM") {}

    function safeMint(address to, string memory uri) public onlyOwner {
        tokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        historial.push(uri);
        lastURIIndex = historial.length - 1;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function addURI(string memory uri, uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can add URIs");
        historial.push(uri);
        _setTokenURI(tokenId, uri);
        lastURIIndex = historial.length - 1;
    }

    function getLastURI() public view returns (string memory) {
        require(lastURIIndex < historial.length, "Indice invalido");
        return historial[lastURIIndex];
    }
}