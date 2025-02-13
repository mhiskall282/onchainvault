//SPDX-License-Identifier: MIT
pragma solidity 0.8.28;
import{ CreateGroup, UserProfile} from "../src/dataStructures/DataStructure.sol";
import VaultFactory
contract Entry 
using DataStructure for DataStructure.CreateGroup;
using DataStructure for DataStructure.UserProfile;

 mapping(address => UserProfile) public users;
 mapping(address => (address => bool)) private access;d
 mapping(address => address[]) private requests;
 mapping(string => bool) private usernames;
 
 modifier isNewUser(address){
    require(!users[msg.sender], "Entry__Can_Not_Register_Same_account_Twice");
 }


constructor(){}
function connect(string memory _userName, uint256 _tokenId, PRIVACY _privacy) external isNewUser(msg.sender) {
   require(!usernames[_userName],"Entry__UserName_Taken");
 
    userProfile =  UserProfile({
        username : _userName,
        tokenId : _tokenId,
        owner: msg.sender,
        vaults:  ,
        privacy: _privacy
    });
    usernames[_username] = true;
}

function addVault(address _user, address _vaultAddress) internal onlyAuthorized {
   users[_user].vaults.push(_vaultAddress);
}


function  createGroup(string memory  _name, address[] members,uint256 _tokenId, PRIVACY _privacy) external {
    
    createGroup = CreateGroup({
        name: _name,
        members: _tokenId,
        tokenId : _tokenId,
        vaults: , 
        privacy: _privacy
    })
}

function updateUserProfile(string memory  _username, uint256 _tokenId, PRIVACY _privacy) external{
   user[msg.sender].username = _username;
   user[msg.sender].tokenId = _tokenId;
   user[msg.sender].privacy = _privacy;
}

function  getProfile() external{
   return users[msg.sender];
}


function requestAccessToProfile(address _user) internal {
   // access[msg.sender][_user] = true;
   requests[_user].push(msg.sender);

}


 function acceptRequest(address _user) external {
   address[] _requests = requests[msg.sender];
   for (uint256 i; i<_requests.length; i++) {
      if (_requests[i] == _user) {
         access[msg.sender][_user] = true;
      }
   }
 }
 

function removeFromProfileAccess(address _user) external{
   access[msg.sender][_user] = false;
}

function updateProfilePicture(uint256 _tokenId) external{
   user[msg.sender].tokenId = _tokenId;
}
