import pytest


def get_gas_used(chain, trxid):
    return chain.wait.for_receipt(trxid)["gasUsed"]


def print_gas_used(chain, trxid, message):
    print(message, get_gas_used(chain, trxid))


def wait(transfer_filter):
    with Timeout(30) as timeout:
        while not transfer_filter.get(False):
            timeout.sleep(2)


@pytest.fixture
def deploy_contract(chain):
    def get(contract_type, arguments, transaction=None):
        deploy_txn_hash = contract_type.deploy(transaction=transaction, args=arguments)
        contract_address = chain.wait.for_contract_address(deploy_txn_hash)
        contract = contract_type(address=contract_address)
        return contract
    return get


@pytest.fixture()
def cryptbill_contract(chain, deploy_contract):
    def get(arguments, transaction=None):
        CryptBill = chain.provider.get_contract_factory('CryptBill')
        contract = deploy_contract(CryptBill, arguments, transaction)

        return token_contract
    return get


@pytest.fixture()
def betfactory_contract(chain, create_contracT):
    def get(arguments, transaction=None):
        BetFactory = chain.provider.get_contract_factory('BetFactory')
        contract = deploy_contract(BetFactory, arguments, transaction)

        return contract
    return get

