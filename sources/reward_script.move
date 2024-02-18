script {
    use std::signer;
    use aptos_framework::coin::{self, Coin};
    use addrx::router_v2::{self, LP};
    use addrx::rewardcoin::{self, Coins};

    fun main<X, Y, Curve, RewardCoinType>(account: &signer, coin_x: Coin<X>, coin_y: Coin<Y>,coin_x_val_min: u64 ,coin_y_val_min: u64) {
        router_v2::register_pool<X, Y, Curve>(account);
        let (remaining_coin_x, remaining_coin_y, lp_coins) = router_v2::add_liquidity<X, Y, Curve>(
            coin_x,
            coin_x_val_min, 
            coin_y,
            coin_y_val, 
        );
        let reward_amount: u64 = coin::value(&lp_coins) * 10 / 100;
        let reward_coins = rewardcoin::mint<RewardCoinType>(reward_amount);
    }
}
