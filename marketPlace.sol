// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Item {
        address seller;
        uint256 price;
        bool exists;
        bool sold;
    }

    struct Offer {
        address buyer;
        uint256 amount;
        bool exists;
        bool accepted;
    }

    mapping(uint256 => Item) public items;
    mapping(uint256 => Offer) public offers;

    uint256 public itemCount;
    uint256 public offerCount;

    event ItemListed(uint256 indexed itemId, address indexed seller, uint256 price);
    event OfferPlaced(uint256 indexed itemId, address indexed buyer, uint256 amount);
    event OfferAccepted(uint256 indexed itemId, address indexed seller, address indexed buyer, uint256 amount);

    modifier itemExists(uint256 itemId) {
        require(items[itemId].exists, "Item does not exist.");
        _;
    }

    modifier itemNotSold(uint256 itemId) {
        require(!items[itemId].sold, "Item has already been sold.");
        _;
    }

    modifier offerExists(uint256 offerId) {
        require(offers[offerId].exists, "Offer does not exist.");
        _;
    }

    modifier offerNotAccepted(uint256 offerId) {
        require(!offers[offerId].accepted, "Offer has already been accepted.");
        _;
    }

    constructor() {
        itemCount = 0;
        offerCount = 0;
    }

    function listItem(uint256 price) public returns (uint256) {
        itemCount++;
        items[itemCount] = Item(msg.sender, price, true, false);
        emit ItemListed(itemCount, msg.sender, price);
        return itemCount;
    }

    function makeOffer(uint256 itemId) public payable itemExists(itemId) itemNotSold(itemId) returns (uint256) {
        offerCount++;
        offers[offerCount] = Offer(msg.sender, msg.value, true, false);
        emit OfferPlaced(itemId, msg.sender, msg.value);
        return offerCount;
    }

    function acceptOffer(uint256 itemId, uint256 offerId) public itemExists(itemId) itemNotSold(itemId) offerExists(offerId) offerNotAccepted(offerId) {
        require(items[itemId].seller == msg.sender, "Only the seller can accept the offer.");
        require(offers[offerId].amount >= items[itemId].price, "Offer amount is too low.");

        items[itemId].sold = true;
        items[itemId].exists = false;
        offers[offerId].accepted = true;

        // Transfer funds to seller
        payable(items[itemId].seller).transfer(items[itemId].price);

        // Refund excess amount to buyer
        if (offers[offerId].amount > items[itemId].price) {
            payable(offers[offerId].buyer).transfer(offers[offerId].amount - items[itemId].price);
        }

        emit OfferAccepted(itemId, items[itemId].seller, offers[offerId].buyer, items[itemId].price);
    }
}
