import json
from typing import Optional
from pathlib import Path

import requests
from decouple import config
from langchain.callbacks.manager import CallbackManagerForToolRun
from langchain.tools import BaseTool

from aiudittool.utils import CMC_NETWORK_NAMES, NETWORKS, get_web3, save_to_text_file
from pydantic import BaseModel, Field
from typing import Type
import subprocess

class MythrilToolInput(BaseModel):
    path_to_sol_file: str = Field(
        description="The path to the .sol file containing the smart contract code"
    )

class MythrilTool(BaseTool):
    name = "MythrilTool"
    description = "Useful for running static analysis tool for smart contracts. Returns the path to the .txt file which will be stored in filecoin"
    args_schema: Type[BaseModel] = MythrilToolInput

    def _run(
        self,
        path_to_sol_file: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:

        process = subprocess.run(
                ['myth', 'analyze', path_to_sol_file, "--solc-json", "/Users/yuchenpeng/ethwaterloo/aiudit/solc.json"], 
                stdout=subprocess.PIPE,
                universal_newlines=True
            )

        output_path = Path("mythril_results")
        output_path.mkdir(exist_ok=True, parents=True)
        file_name = path_to_sol_file.split("/")[-1].split(".")[0]
        save_to_text_file(process.stdout, output_path, "{}.txt".format(file_name))
        return str((output_path / "{}.txt".format(file_name)).absolute())

    def _arun(
        self,
        network: NETWORKS,
        symbol: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        raise 