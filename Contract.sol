// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalRightsManagement {
    struct Content {
        address creator;
        string contentHash;
        uint256 price;
        bool isActive;
    }
    
    struct License {
        bool isValid;
        uint256 purchaseDate;
        uint256 expiryDate;
    }
    
    // Mapping of content ID to Content
    mapping(uint256 => Content) public contents;
    
    // Mapping of content ID to user address to License
    mapping(uint256 => mapping(address => License)) public licenses;
    
    // Counter for generating unique content IDs
    uint256 private contentCounter;
    
    // Events
    event ContentRegistered(uint256 indexed contentId, address indexed creator, string contentHash);
    event LicensePurchased(uint256 indexed contentId, address indexed user);
    event ContentDeactivated(uint256 indexed contentId);
    
    // Register new content
    function registerContent(string memory contentHash, uint256 price) public returns (uint256) {
        require(bytes(contentHash).length > 0, "Content hash cannot be empty");
        require(price > 0, "Price must be greater than 0");
        
        uint256 contentId = contentCounter++;
        
        contents[contentId] = Content({
            creator: msg.sender,
            contentHash: contentHash,
            price: price,
            isActive: true
        });
        
        emit ContentRegistered(contentId, msg.sender, contentHash);
        return contentId;
    }
    
    // Purchase a license for content
    function purchaseLicense(uint256 contentId, uint256 duration) public payable {
        Content memory content = contents[contentId];
        require(content.isActive, "Content is not active");
        require(msg.value >= content.price, "Insufficient payment");
        require(duration > 0, "Duration must be greater than 0");
        
        // Create new license
        licenses[contentId][msg.sender] = License({
            isValid: true,
            purchaseDate: block.timestamp,
            expiryDate: block.timestamp + duration
        });
        
        // Transfer payment to content creator
        payable(content.creator).transfer(msg.value);
        
        emit LicensePurchased(contentId, msg.sender);
    }
    
    // Check if user has valid license
    function hasValidLicense(uint256 contentId, address user) public view returns (bool) {
        License memory license = licenses[contentId][user];
        return license.isValid && block.timestamp <= license.expiryDate;
    }
    
    // Get content details (only if user has valid license)
    function getContent(uint256 contentId) public view returns (string memory) {
        require(contents[contentId].isActive, "Content is not active");
        require(
            msg.sender == contents[contentId].creator || 
            hasValidLicense(contentId, msg.sender),
            "No valid license"
        );
        
        return contents[contentId].contentHash;
    }
    
    // Deactivate content (only creator can do this)
    function deactivateContent(uint256 contentId) public {
        require(msg.sender == contents[contentId].creator, "Only creator can deactivate");
        contents[contentId].isActive = false;
        emit ContentDeactivated(contentId);
    }
    
    // Get license details
    function getLicenseDetails(uint256 contentId, address user) 
        public 
        view 
        returns (bool isValid, uint256 purchaseDate, uint256 expiryDate) 
    {
        License memory license = licenses[contentId][user];
        return (license.isValid, license.purchaseDate, license.expiryDate);
    }
}