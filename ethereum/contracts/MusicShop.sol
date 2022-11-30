//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MusicShop {
    struct Album {
        uint index;
        string uid;
        string title;
        uint price;
        uint quantity;
    }
    struct Order {
        string albumUid;
        address customer;
        uint orderedAt;
        OrderStatus status;
    }

    Album[] public albums;

    Order[] public orders;

    uint currentIndex;

    enum OrderStatus {Paid, Delivered} 

    address public owner;

    event AlbumBought(string indexed uid, address indexed customer, uint indexed timestamp);

    event OrderDelivered(string indexed uid, address indexed customer);


    constructor() {
        owner = msg.sender;
    } 

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        _;
    }

    function buy(uint _index) external payable {
        Album storage albumToBuy = albums[_index];
        require(msg.value >= albumToBuy.price, "Invalid price");
        require(albumToBuy.quantity > 0, "Out of stock!");
        albumToBuy.quantity--;

        orders.push(Order({
            albumUid: albumToBuy.uid,
            customer: msg.sender,
            orderedAt: block.timestamp,
            status: OrderStatus.Paid
        }));

        emit AlbumBought(albumToBuy.uid, msg.sender, block.timestamp);
    }

    function delivered(uint _index) external onlyOwner {
        Order storage cOrder = orders[_index];

        require(cOrder.status != OrderStatus.Delivered, "invalid status!");
        
        cOrder.status = OrderStatus.Delivered;

        emit OrderDelivered(cOrder.albumUid, cOrder.customer);
    }

    receive() external payable {
        revert("Please, use buy function");
    }

    function addAlbum(
        string calldata _uid, 
        string calldata _title, 
        uint _price, 
        uint _quantity) public onlyOwner {
            albums.push(Album({
                index: currentIndex,
                uid: _uid,
                title: _title,
                price: _price,
                quantity: _quantity
            }));

            currentIndex++;
        }

    function withdraw(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    } 
}