//SPDX-License-Identifier: MIT
pragma solidity 0.8.28;
import {DataStructure} from "./dataStructures/DataStructure.sol";

contract Entry is DataStructure {
    // using DataStructure for DataStructure.CreateGroup;
    //using DataStructure for DataStructure.UserProfile;
    uint256 nextGroupId;
    bool exists;

    mapping(address => UserProfile) public users;
    mapping(address => bool) public isMemberOf;
    mapping(address => mapping(address => bool)) private access;
    mapping(address => address[]) private requests;
    mapping(string => bool) private usernames;
    mapping(uint256 => CreateGroup) private group;

    modifier isNewUser(address) {
        require(
            users[msg.sender].owner == address(0),
            "Entry__Can_Not_Register_Same_account_Twice"
        );
        _;
    }

    constructor() {}

    function connect(
        string memory _userName,
        uint256 _tokenId,
        PRIVACY _privacy
    ) external isNewUser(msg.sender) {
        require(!usernames[_userName], "Entry__UserName_Taken");

        UserProfile memory profile = UserProfile({
            username: _userName,
            tokenId: _tokenId,
            owner: msg.sender,
            // exists: true,
            vaults: new address[](0),
            privacy: _privacy
        });
        users[msg.sender] = profile;
        usernames[_userName] = true;
        exists = true;
    }

    function addVault(
        address _user,
        address _vaultAddress
    ) internal /*onlyAuthorized*/ {
        users[_user].vaults.push(_vaultAddress);
    }

    function createGroup(
        string memory _name,
        address[] calldata members,
        uint256 _tokenId,
        PRIVACY _privacy
    ) external {
        CreateGroup memory _group = CreateGroup({
            name: _name,
            members: members,
            tokenId: _tokenId,
            vaults: new address[](0),
            privacy: _privacy
        });
        nextGroupId++;
        group[nextGroupId] = _group;
    }

    function updateUserProfile(
        string memory _username,
        uint256 _tokenId,
        PRIVACY _privacy
    ) external {
        users[msg.sender].username = _username;
        users[msg.sender].tokenId = _tokenId;
        users[msg.sender].privacy = _privacy;
    }

    function getProfile() external view returns (UserProfile memory) {
        return users[msg.sender];
    }

    function requestAccessToProfile(address _user) internal {
        // access[msg.sender][_user] = true;
        requests[_user].push(msg.sender);
    }

    function acceptRequest(address _user) external {
        address[] storage _requests = requests[msg.sender];
        for (uint256 i; i < _requests.length; i++) {
            if (_requests[i] == _user) {
                access[msg.sender][_user] = true;
            }
        }
    }

    function removeFromProfileAccess(address _user) external {
        access[msg.sender][_user] = false;
    }

    function updateProfilePicture(uint256 _tokenId) external {
        users[msg.sender].tokenId = _tokenId;
    }
}
