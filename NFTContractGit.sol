pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
	uint256 MAX_TOKENS=10000;

    constructor() ERC721("NFTS", "NFT") {
		
		
	}

    function safeMint(string memory tokenURI_) public payable {
		//require(isSaleActive, "Sale is currently not active");
		require(MAX_TOKENS > _tokenIdCounter.current() + 1, "Not enough tokens left to buy.");
		
		//require(msg.value >= price , "Amount of ether sent not correct.");

		
			_safeMint(msg.sender, _tokenIdCounter.current());
			_setTokenURI(_tokenIdCounter.current(), tokenURI_);
			_tokenIdCounter.increment();
			
		
	}
	
	function safeMintTo(address _to, string memory tokenURI_) public payable {
		//require(isSaleActive, "Sale is currently not active");
		require(MAX_TOKENS > _tokenIdCounter.current() + 1, "Not enough tokens left to buy.");
		
		//require(msg.value >= price , "Amount of ether sent not correct.");

		
			_safeMint(_to, _tokenIdCounter.current());
			_setTokenURI(_tokenIdCounter.current(), tokenURI_);
			_tokenIdCounter.increment();
			
		
	}

    // The following functions are overrides required by Solidity.

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
	
	//Return current counter value
	function getCounter()
        public
        view
        returns (uint256)
    {
        return _tokenIdCounter.current();
    }
}