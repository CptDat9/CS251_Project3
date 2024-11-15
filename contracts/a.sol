function addLiquidity(uint min_rate, uint max_rate) 
    external payable
    {
        
        // I add max exchagne rate and min exchange rate as parameters to avoid 
        // Sandwich attack, Front-run and back-run
       /******* TODO: Implement this function *******/
        uint ETHamount = msg.value;
        // This function below check user's token.
        require(ETHamount > 0, "Error: ETH amount need to positive.");
        // Detect the token that need to add to stablize formula: x*y = k (token_reserves*eth_reserves=k constant)
        uint tokenreq = (ETHamount * token_reserves)/eth_reserves;
        // Dùng tỉ lệ giữa delta x, delta y so với x,y để tính x
        // Check balance of user
        require(tokenreq <= token.balanceOf(msg.sender),"Error: User doesn't have enough token." );
        require((ETHamount * multiplier)/tokenreq >= min_rate, "Error. Slippage!");
        require((ETHamount * multiplier)/tokenreq <= max_rate, "Error. Slippage!");
        //Avoid slippage.
        token.transferFrom(msg.sender, address(this), tokenreq);
        token_reserves = token.balanceOf(tokenreq);
        eth_reserves = address(this).balance;// Hàm Balance được hỗ trợ có sẵn trong ETH
        uint new_reserves = token_reserves - token_req;    
        bool [](lp_providers.length) providerExist;
        for (uint i=0; i < lp_providers.length; i++){
            if(lp_providers[i] == msg.sender)
            // Xem người gửi có trong danh sách Liquidity share chưa
            {
                providerExist = true;
                // Tính lại phần trăm cổ phần trong pool
                lps[lp_providers[msg.sender]] =(lp_providers[msg.sender] * new_reserves + tokenreq * multiplier )/token_reserves;
            }
            else
            {
                // Thêm người gửi vào danh sách
                lp_providers.push(msg.sender);
                providerExist[i]=true;
                //Tính lại phần trăm cổ phần trong pool
                lps[lp_providers[msg.sender]] =(lp_providers[msg.sender] * new_reserves + tokenreq * multiplier )/token_reserves;

            }
        }
        
    }
