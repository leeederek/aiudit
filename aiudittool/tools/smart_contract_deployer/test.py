from decouple import config
from langchain.agents import AgentType, initialize_agent
from langchain.chat_models import ChatOpenAI


from aiudittool.tools.smart_contract_deployer.tool import SmartContractDeployerTool

OPENAI_API_KEY = config("OPENAI_API_KEY")

llm = ChatOpenAI(temperature=0, openai_api_key=OPENAI_API_KEY)  # type: ignore

if __name__ == "__main__":
    tool = SmartContractDeployerTool()


    result = tool._run(
        path_to_bytecode="/Users/yuchenpeng/a-i-udit-private/smart_contracts/adventurer's_coin-bin",
        network="polygon_mumbai",
    )

    # result = tool._run(
    #     path_to_bytecode="/Users/yuchenpeng/aiudit/smart_contracts/javacoin-bin",
    #     network="gnosis_chiado",
    # )

    print(result)

