from pathlib import Path
from typing import Optional, Type

from decouple import config
from langchain.callbacks.manager import CallbackManagerForToolRun
from langchain.chains import LLMChain
from langchain.chat_models import ChatOpenAI
from langchain.prompts import (
    ChatPromptTemplate,
    HumanMessagePromptTemplate,
    SystemMessagePromptTemplate,
)
from langchain.tools import BaseTool
from pydantic import BaseModel, Field
from aiudittool.utils import (
    extract_first_code_block,
    preprocess_solidity_code,
    save_to_text_file,
)

SYSTEM_MESSAGE = "You are a world class smart contract developer that creates EVM-compatible Solidity code given a description of a desired Smart Contract."
HUMAN_MESSAGE_TEMPLATE = (
    "Please write fuzzy testing tests for a smart contract in Solidity 0.8.19 that conforms to the following description. "
    " "
    "Description:\n"
    "{description}\n\n"
    "Output a single code block within backticks containing the Solidity code."
)


smart_contract_tester_chain = LLMChain(
    llm=ChatOpenAI(openai_api_key=config("OPENAI_API_KEY"), temperature=0.0),  # type: ignore
    prompt=ChatPromptTemplate.from_messages(
        [
            SystemMessagePromptTemplate.from_template(SYSTEM_MESSAGE),
            HumanMessagePromptTemplate.from_template(HUMAN_MESSAGE_TEMPLATE),
        ]
    ),
)


class SmartContractFuzzyTesterToolInput(BaseModel):
    title: str = Field(description="A title for the smart contract, e.g. 'ERC20 Token'")
    description: str = Field(
        description="A detailed description of the type of tests and its function"
    )


class SmartContractFuzzyTesterTool(BaseTool):
    name = "SmartContractFuzzyTester"
    description = "Useful for writing EVM-compatible smart contracts fuzzy test cases. Returns the path to the .sol file."
    args_schema: Type[BaseModel] = SmartContractFuzzyTesterToolInput

    def _run(
        self,
        title: str,
        description: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        """Use the tool."""
        chain_result = smart_contract_tester_chain.run(f"{title}\n{description}")
        code_block = extract_first_code_block(chain_result)
        code_block = preprocess_solidity_code(code_block)

        output_path = Path("smart_contracts_test")
        output_path.mkdir(exist_ok=True, parents=True)
        snake_case_title = title.lower().replace(" ", "_")
        file_name = f"{snake_case_title}.sol"

        save_to_text_file(code_block, output_path, file_name)
        absolute_path_str = str((output_path / file_name).absolute())
        return absolute_path_str

    async def _arun(
        self,
        description: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        raise NotImplementedError("This tool does not support async mode.")
