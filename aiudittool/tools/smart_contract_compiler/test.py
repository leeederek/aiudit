from decouple import config
from langchain.agents import AgentType, initialize_agent
from langchain.chat_models import ChatOpenAI

from aiudittool.tools.smart_contract_compiler.tool import SmartContractCompilerTool

OPENAI_API_KEY = config("OPENAI_API_KEY")

llm = ChatOpenAI(temperature=0, openai_api_key=OPENAI_API_KEY)  # type: ignore

if __name__ == "__main__":
    tools = [
        SmartContractCompilerTool(),
    ]

    agent = initialize_agent(
        tools=tools,
        llm=llm,
        agent=AgentType.STRUCTURED_CHAT_ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
    )

    contract_path = "/Users/yuchenpeng/aiudit/smart_contracts/sample.sol"


    question = f"compile the contract that has path {contract_path}"
    #question = f"Send a transaction of {ether_amount} ethers to {recipientAddress} on Sepolia. Give me the resulting transaction hash"
    ### D:question = f"Use mint method to mint {token_amount} tokens to {recipientAddress}, using this erc20 contract: ${erc20_token_address} on Ethereum mainnet. Give me the resulting transaction hash"

    # response = agent.run(question)
    tool = SmartContractCompilerTool()
    response = tool._run(path_to_sol_file=contract_path)

    print(response)
