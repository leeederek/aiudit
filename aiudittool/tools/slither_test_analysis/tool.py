import json
from pathlib import Path
from typing import Dict, List, Optional, Type
from decouple import config

import solcx
from langchain.callbacks.manager import CallbackManagerForToolRun
from langchain.chat_models import ChatOpenAI
from langchain.tools import BaseTool

from pydantic import BaseModel, Field
from semantic_version import Version
from slither.slither import Slither

OPENAI_API_KEY = config("OPENAI_API_KEY")
llm = ChatOpenAI(temperature=0, openai_api_key=OPENAI_API_KEY)  # type: ignore


class SlitherTestToolInput(BaseModel):
    path_to_sol_file: str = Field(
        description="The path to the .sol file containing the smart contract code"
    )


class  SlitherTestTool(BaseTool):
    name = "SlitherTest"
    description = "Useful for performing static analysis on EVM-compatible smart contracts."
    args_schema: Type[BaseModel] = SlitherTestToolInput

    def _run(
        self,
        path_to_sol_file: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> None:
        # Read the Solidity source code
        home_path = Path.home()
        print("the home path is")
        print(home_path)

        sol_file_name = Path(path_to_sol_file).name
        print("Function name is")
        print(sol_file_name)

        solc_version = '0.8.9'  # Specify the desired Solidity version

        # library_paths = [
        #     '/Users/yuchenpeng/a-i-udit-private/aiudittool/node_modules/@openzeppelin',
        #     '/Users/yuchenpeng/a-i-udit-private/aiudittool/node_modules/@chainlink'
        # ] 

        # # solc_args = '--allow-paths ' + ' '.join(library_paths)
        # solc_args = "--solc_remaps " + " @openzeppelin/=$(pwd)/node_modules/@openzeppelin/"

        slither = Slither(path_to_sol_file)


        # for contract in slither.contracts:
        #     print('Contract: '+ contract.name)
  
        # for function in contract.functions:  
        #     print('Function: {}'.format(function.name))  
    
        #     print('\tRead: {}'.format([v.name for v in function.state_variables_read]))  
        #     print('\tWritten {}'.format([v.name for v in function.state_variables_written]))
    
    async def _arun(
        self,
        description: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        raise NotImplementedError("This tool does not support async mode.")
