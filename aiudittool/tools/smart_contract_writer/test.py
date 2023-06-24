from decouple import config
from langchain.agents import AgentType, initialize_agent
from langchain.chat_models import ChatOpenAI

from aiudittool.tools.smart_contract_writer.tool import SmartContractWriterTool

OPENAI_API_KEY = config("OPENAI_API_KEY")

llm = ChatOpenAI(temperature=0, openai_api_key=OPENAI_API_KEY)  # type: ignore

if __name__ == "__main__":
    tools = [
        SmartContractWriterTool(),
    ]

    agent = initialize_agent(
        tools=tools,
        llm=llm,
        agent=AgentType.STRUCTURED_CHAT_ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
    )

    # Test 1 Run the tool without going through LLM agent
    tool = SmartContractWriterTool()

    # Test 2 Run the tool using the LLM agent
    title = "JavaCoin"
    description = " mint and burn functions. You decide on the variables"
    question = f"Please write a smart contract that has title {title} and can do {description}"

    # response_1 = tool._run(title=title, description=description)
    # print(response_1)

    response_2 = agent.run(question)


    print(response_2)
