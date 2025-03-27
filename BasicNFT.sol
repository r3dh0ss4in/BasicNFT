// SPDX-License-Identifier: MIT

//     Pragma statements

//     Import statements

//     Events

//     Errors

//     Interfaces

//     Libraries

//     Contracts

// Inside each contract, library or interface, use the following order:

//     Type declarations

//     State variables

//     Events

//     Errors

//     Modifiers

//     Functions


pragma solidity ^0.8.22;

/**
 * @title BasicNFT
 * @author Reduan Hossain
 */

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Counters} from "./counters.sol";

contract BasicNFT is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 10000;
    
    constructor()
        ERC721("BasicNFT", "BT")
    {}

    function safeMint(address to, uint256 _tokenId, string memory uri)
        public
    {
        uint256 tokenId = _tokenIdCounter.current();
        require(_tokenId <= MAX_SUPPLY, "I'm sorry all NFTs have been minted!");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
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
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
