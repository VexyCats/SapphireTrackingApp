pragma solidity ^0.4.18;


    contract ERC721 {
    // Function
    function totalSupply() public returns (uint256 _totalSupply);
    function balanceOf(address _owner) public view returns (uint256 _balance);
    function ownerOf(uint _tokenId) public view returns (address _owner);
    function approve(address _to, uint _tokenId) public;
    function getApproved(uint _tokenId) public view returns (address _approved);
    function transferFrom(address _from, address _to, uint _tokenId) public;
    function transfer(address _to, uint _tokenId) public;
    function implementsERC721() public view returns (bool _implementsERC721);

    // Events
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
}

/**
 * Interface for optional functionality in the ERC721 standard
 * for non-fungible tokens.
 *
 * Author: Nadav Hollander (nadav at dharma.io)
 */
contract DetailedERC721 is ERC721 {
    function name() public view returns (string _name);
    function symbol() public view returns (string _symbol);
    function tokenOfOwnerByIndex(address _owner, uint _index) public view returns (uint _tokenId);
}


/**
 * @title NonFungibleToken
 *
 * Generic implementation for both required and optional functionality in
 * the ERC721 standard for non-fungible tokens.
 *
 * Heavily inspired by Decentraland's generic implementation:
 * https://github.com/decentraland/land/blob/master/contracts/BasicNFT.sol
 *
 * Standard Author: dete
 * Implementation Author: Nadav Hollander <nadav at dharma.io>
 */
contract NonFungibleToken is DetailedERC721 {
    
   /* ================ initializing ========================*/
    string public name;
    string public symbol;
    address public owner;
    uint256 public numTokensTotal;
    
   

    mapping(uint => address) internal tokenIdToOwner;
    mapping(uint => address) internal tokenIdToApprovedAddress;
    
    mapping(address => uint[]) public ownerToTokensOwned;
    mapping(uint => uint) internal tokenIdToOwnerArrayIndex;

 /* ================ events ========================*/


    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId
    );

    event Approval( address indexed _owner, address indexed _approved, uint256 _tokenId
    );


 /* ================ modifiers ========================*/


    modifier onlyExtantToken(uint _tokenId) {
        require(ownerOf(_tokenId) != address(0));
        _;
    }
     modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
  
    
    

    
/* ================ public viewables ========================*/
    constructor()
        internal
        {
        owner = msg.sender;
    }

    function name()
        public
        view
        returns (string _name)
    {
        return name;
    }

    function symbol()
        public
        view
        returns (string _symbol)
    {
        return symbol;
    }

    function totalSupply()
        public
      
        returns (uint256 _totalSupply)
    {
        return numTokensTotal;
    }


 /* ================ getters ========================*/

    function balanceOf(address _owner)
        public
        view
        returns (uint _balance)
    {
        return ownerToTokensOwned[_owner].length;
    }
    

    function ownerOf(uint _tokenId)
        public
        view
        returns (address _owner)
    {
        return _ownerOf(_tokenId);
    }

  



 /* ================ functions ========================*/
    function approve(address _to, uint _tokenId)
        public
        onlyExtantToken(_tokenId)
    {
        require(msg.sender == ownerOf(_tokenId));
        require(msg.sender != _to);

        if (_getApproved(_tokenId) != address(0) ||
                _to != address(0)) {
            _approve(_to, _tokenId);
            emit Approval(msg.sender, _to, _tokenId);
        }
    }

    function transferFrom(address _from, address _to, uint _tokenId)
        public
        onlyExtantToken(_tokenId)
    {
        require(getApproved(_tokenId) == msg.sender);
        require(ownerOf(_tokenId) == _from);
        require(_to != address(0));

        _clearApprovalAndTransfer(_from, _to, _tokenId);

       emit Approval(_from, 0, _tokenId);
       emit Transfer(_from, _to, _tokenId);
    }

    function transfer(address _to, uint _tokenId)
        public
        onlyExtantToken(_tokenId)
    {
          require(ownerOf(_tokenId) == msg.sender);
        require(_to != address(0));

        _clearApprovalAndTransfer(msg.sender, _to, _tokenId);

       emit Approval(msg.sender, 0, _tokenId);
       emit Transfer(msg.sender, _to, _tokenId);
    }
   

    function tokenOfOwnerByIndex(address _owner, uint _index)
        public
        view
        returns (uint _tokenId)
    {
        return _getOwnerTokenByIndex(_owner, _index);
    }

    function getOwnerTokens(address _owner)
        public
        view
        returns (uint[] _tokenIds)
    {
        return _getOwnerTokens(_owner);
    }
    function getOwnerTokensLength(address _owner)
        public
        view
        returns (uint _length)
    {
        return _getOwnerTokensLength(_owner);
    }
    function implementsERC721()
        public
        view
        returns (bool _implementsERC721)
    {
        return true;
    }

    function getApproved(uint _tokenId)
        public
        view
        returns (address _approved)
    {
        return _getApproved(_tokenId);
    }

    function _clearApprovalAndTransfer(address _from, address _to, uint _tokenId)
        internal
    {
        _clearTokenApproval(_tokenId);
        _removeTokenFromOwnersList(_from, _tokenId);
        _setTokenOwner(_tokenId, _to);
        _addTokenToOwnersList(_to, _tokenId);
    }

    function _ownerOf(uint _tokenId)
        internal
        view
        returns (address _owner)
    {
        return tokenIdToOwner[_tokenId];
    }

    function _approve(address _to, uint _tokenId)
        internal
    {
        tokenIdToApprovedAddress[_tokenId] = _to;
    }

    function _getApproved(uint _tokenId)
        internal
        view
        returns (address _approved)
    {
        return tokenIdToApprovedAddress[_tokenId];
    }

    function _getOwnerTokens(address _owner)
        internal
        view
        returns (uint[] _tokens)
    {
        
        return ownerToTokensOwned[_owner];
    }
    function _getOwnerTokensLength(address _owner)
     internal
     view
     returns (uint _length){
        return ownerToTokensOwned[_owner].length;
    }

    function _getOwnerTokenByIndex(address _owner, uint _index)
        internal
        view
        returns (uint _tokens)
    {
        return ownerToTokensOwned[_owner][_index];
    }

    function _clearTokenApproval(uint _tokenId)
        internal
    {
        tokenIdToApprovedAddress[_tokenId] = address(0);
    }

    function _setTokenOwner(uint _tokenId, address _owner)
        internal
    {
        tokenIdToOwner[_tokenId] = _owner;
    }

    function _addTokenToOwnersList(address _owner, uint _tokenId)
        internal
    {
        ownerToTokensOwned[_owner].push(_tokenId);
        tokenIdToOwnerArrayIndex[_tokenId] =
            ownerToTokensOwned[_owner].length - 1;
    }

    function _removeTokenFromOwnersList(address _owner, uint _tokenId)
        internal
    {
        uint length = ownerToTokensOwned[_owner].length;
        uint index = tokenIdToOwnerArrayIndex[_tokenId];
        if(length >= 1){
        uint swapToken = ownerToTokensOwned[_owner][length - 1];
        }else{
           swapToken = ownerToTokensOwned[_owner][length];
        }
        ownerToTokensOwned[_owner][index] = swapToken;
        tokenIdToOwnerArrayIndex[swapToken] = index;

        delete ownerToTokensOwned[_owner][length - 1];
        ownerToTokensOwned[_owner].length--;
    }

    
}

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

/**
 * @title MintableNonFungibleToken
 *
 * Superset of the ERC721 standard that allows for the minting
 * of non-fungible tokens.
 */
contract SapphiresNonFungibleToken is NonFungibleToken {
        /* what needs to be done */
    
    /* a way to track sapphires by id number and store a few variables and transaction history.
    such as:
    id:
    owner:
    certificates:
    picture:
    previousTransactions:
    previousOwners:
    Price:
    ForSale:
    
    getters()
        id
        owner
        certs/pics 
        previousData
        Price
        ForSale
        
        
    payables()
    Buy(
        check forSale, then accept and Transfer
    )
    default => _revert;
    
    */
    
/* ================ initializing ========================*/
    using SafeMath for uint;
     using SafeMath for uint256;

  struct sapphire {
        uint256 weight;
        string title;
        uint256 lastPrice;
        string certificateUrl;
        string pictureUrl;
        
        
    }
    
    mapping(uint => sapphire) tokenIdtoMetaData;
    
    sapphire[] public sapphiresObj;

/* ================ events ========================*/

    event Mint(address indexed _to, uint256 indexed _tokenId);


 /* ================ modifiers ========================*/

    modifier onlyNonexistentToken(uint _tokenId) {
        require(tokenIdToOwner[_tokenId] == address(0));
        _;
    }
/* ================ sapphire tracking ========================*/
 
/* create sapphires*/
      function mint(address _owner, uint256 _tokenId, uint256 _weight, uint256 _lastPrice, string _title,string _cert,string _pic) onlyOwner
        public
        onlyNonexistentToken(_tokenId)
        
    {
        _setTokenOwner(_tokenId, _owner);
        _addTokenToOwnersList(_owner, _tokenId);
      
       // _insertTokenMetadata(_tokenId, _metadata);
       tokenIdtoMetaData[_tokenId].weight = _weight;
       tokenIdtoMetaData[_tokenId].lastPrice = _lastPrice;
       tokenIdtoMetaData[_tokenId].title = _title;
       tokenIdtoMetaData[_tokenId].certificateUrl = _cert;
        tokenIdtoMetaData[_tokenId].pictureUrl = _pic;
        numTokensTotal = numTokensTotal.add(1);
        sapphiresObj.push(tokenIdtoMetaData[_tokenId]);
        emit Mint(_owner, _tokenId);
    }
/* ================ public viewables ========================*/

function SapphireTitle(uint _tokenId)
        public
        view
        returns (string _title)
    {
        return tokenIdtoMetaData[_tokenId].title;
    }
function SapphireWeight(uint _tokenId)
        public
        view
        returns (uint256 _weight)
    {
        return tokenIdtoMetaData[_tokenId].weight;
    }
function SapphirePrice(uint _tokenId)
        public
        view
        returns (uint256 _price)
    {
        return tokenIdtoMetaData[_tokenId].lastPrice;
    }
function SapphireOwner(uint _tokenId)
        public
        view
        returns (address _owner)
    {
        return tokenIdToOwner[_tokenId];
    }
function SapphirePicture(uint _tokenId)
        public
        view
        returns (string _pictureUrl)
    {
        return tokenIdtoMetaData[_tokenId].pictureUrl;
    }
function SapphireCertificate(uint _tokenId)
        public
        view
        returns (string _certificateUrl)
    {
        return tokenIdtoMetaData[_tokenId].certificateUrl;
    }
  
    
 /* ================ functions ========================*/
 
  
}

