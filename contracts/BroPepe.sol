// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/access/Ownable.sol";
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';


contract BroPepe is ERC721, Ownable{

    uint256 public mintPrice;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint public maxPerWallet;
    bool public isMintEnabled;
    bool public isRevealed;
    string internal baseTokenURI;
    string internal notRevealedURI;
    address payable public wdAddress;
    mapping(address => uint256) public whiteWallets;

    constructor() payable ERC721("Candy-Vase By Nicky Barnes", "CV")
    {
        mintPrice = 0.02 ether;
        totalSupply = 0;
        maxSupply = 10;
        maxPerWallet = 1;
        isMintEnabled = false;
        isRevealed = false;
        //set withdraw wallet
        wdAddress = payable(0xDc46A951f3296339cafe6F69B7512dE936186c94);
    }

    function setWlAddress(address[] calldata whitelistAddresses) external onlyOwner
    {
        require(whitelistAddresses.length <= 13, "Already Sold Out");
        for(uint256 i=0; i < whitelistAddresses.length; i++)
        {
            whiteWallets[whitelistAddresses[i]] = 1;
        }

    }
    

    function getTotalSupply() public view returns(uint256)
    {
        return totalSupply;
    }

    function setIsPublicMintEnabled() external onlyOwner {
        isMintEnabled = true;
    }

    function pauseMint() external onlyOwner
    {
        isMintEnabled = false;
    }

    function setNotRevealedUri(string calldata _notRevealedURI) external onlyOwner
    {
        notRevealedURI = _notRevealedURI;
    }

    function reveal() external onlyOwner
    {
        isRevealed = true;
    }
    function setBaseTokenUri(string calldata _baseTokenURI) external onlyOwner
    {
        baseTokenURI = _baseTokenURI;
    }

    function tokenURI(uint256 _tokenID) public view override returns(string memory)
    {
        require(_exists(_tokenID),"Token doesnot exist");
        if(isRevealed == false)
        {
            return notRevealedURI;
        }
        return string(abi.encodePacked(baseTokenURI, Strings.toString(_tokenID),".json"));
    }

    function whitelistMint(uint256 _quantity) external payable{
        require(whiteWallets[msg.sender] == 1, "You are not whitelisted for Minting, Fuck off.");
        require(msg.value >= mintPrice*_quantity, "Not enough ethereum for transaction");
        require(totalSupply + _quantity <= maxSupply, "Sold out");
        require(isMintEnabled == true, "Minting not started yet");
       

        for(uint256 i ; i<_quantity; i++)
        {
            uint256 newTokenID = totalSupply + 1;
            totalSupply++; //doing this first to prevent the reentrancy attack
            whiteWallets[msg.sender]--;
            _safeMint(msg.sender, newTokenID);

        }

    }

    function devMint(uint256 _quantity) external  onlyOwner
    {
         require(totalSupply + _quantity < maxSupply, "Sold out");
                 require(isMintEnabled == true, "Minting not started yet");

             for(uint256 i ; i<_quantity; i++)
        {
            uint256 newTokenID = totalSupply + 1;
            totalSupply++; //doing this first to prevent the reentrancy attack
            _safeMint(msg.sender, newTokenID);

        }
        
    }

    //withdrawl function
    function withdraw() external onlyOwner 
    {
        (bool success, ) = wdAddress.call{value: address(this).balance }('');
        require(success,"Cant withdraw the funds");
    }
}

