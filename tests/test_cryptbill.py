import pytest
from fixtures import (
    cryptbill_contract,
    deploy_contract
    )

def test_token_init(web3, cryptbill_contract):

    token = cryptbill_contract([])
    owner = web3.eth.accounts[0]
    
    assert token.call().balanceOf(owner) == (2000000000 * 10**18)
