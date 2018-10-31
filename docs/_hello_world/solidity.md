---
title: Hello World in Solidity
layout: default
featured-image:
tags: [solidity]
---

{% include featured_image.md name=page.title image=page.featured-image %}

## Hello World in Solidity

Without further ado, here’s an implementation of Hello World in Solidity:

```solidity
pragma solidity ^0.4.22;
contract helloWorld {   
    function renderHelloWorld () public pure returns (string) {       
        return 'Hello, World!';             
    }
}
```

While the format of Solidity looks a bit different from the more popular
programming languages today, what’s happening behind is fairly straightforward.

First we import the version of Solidity we’d like to use. Then we create a
function and specify we’d only like to return a string. And, voila!

## How to Run the Solution

If you want to run the solution, remix provides an [IDE][5] you can visit to write
and execute the smart contract. Every piece of code written in Solidity—or any
blockchain programming language—is considered a smart contract.

[1]: https://en.wikipedia.org/wiki/Smart_contract
[2]: https://en.wikipedia.org/wiki/Blockchain
[3]: https://blockgeeks.com/guides/what-is-blockchain-technology/
[4]: https://www.coindesk.com/understand-google-docs-can-understand-blockchain/
[5]: http://remix.ethereum.org/
