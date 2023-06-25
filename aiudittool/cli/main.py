import enum

import click
import typer
from langchain.agents import AgentExecutor
from rich.console import Console
from rich.traceback import install
from typing_extensions import Annotated

from aiudittool.agents.structured_chat import get_structured_chat_agent_from_tools
from aiudittool.tools import (
    SmartContractCompilerTool,
    SmartContractDeployerTool,
    SmartContractWriterTool,
    SmartContractTesterTool,
    MythrilTool,
    ViewTestToolsResult,
    SmartContractFuzzyTesterTool,
)

install(suppress=[click])
app = typer.Typer()


class StructuredChatAgent(str, enum.Enum):
    full = "full"
    smart_contract = "smart-contract"
    information_retrieval = "information-retrieval"


FULL_TOOLSET = [
    SmartContractWriterTool(),
    SmartContractCompilerTool(),
    SmartContractDeployerTool(),
    SmartContractTesterTool(),
    MythrilTool(),
    SmartContractFuzzyTesterTool(),
]

SMART_CONTRACT_TOOLSET = [
    SmartContractWriterTool(),
    SmartContractCompilerTool(),
    SmartContractDeployerTool(),
    SmartContractTesterTool(),
    SmartContractFuzzyTesterTool(),
]

FULL_TOOLSET = [
    *SMART_CONTRACT_TOOLSET,
]

TOOLSET_MAP = {
    StructuredChatAgent.full: FULL_TOOLSET,
    StructuredChatAgent.smart_contract: SMART_CONTRACT_TOOLSET,
}


def get_agent(
    agent_type: StructuredChatAgent.smart_contract,
    verbose: bool,
    model_name: str,
    temperature: float,
) -> AgentExecutor:
    if agent_type not in StructuredChatAgent:
        raise ValueError(f"Invalid agent type: {agent_type}")
    toolset = TOOLSET_MAP[agent_type]
    agent = get_structured_chat_agent_from_tools(
        tools=toolset,
        verbose=verbose,
        model_name=model_name,
        temperature=temperature,
    )
    return agent

@app.command(name="chat")
def chat_command(
    agent: Annotated[
        StructuredChatAgent,
        typer.Option(
            help="Specify which agent to use (default or smart_contract)",
        ),
    ] = StructuredChatAgent.full,
    model_name: Annotated[
        str,
        typer.Option(
            help="Specify which model to use (gpt-3.5-turbo or gpt-4)",
        ),
    ] = "gpt-3.5-turbo",
    temperature: Annotated[
        float,
        typer.Option(
            help="Specify the temperature for the model (default 0.0)",
        ),
    ] = 0.0,
    verbose: Annotated[bool, typer.Option(help="Display verbose output")] = False,
) -> None:
    console = Console()
    typer.echo(
        "You are now chatting with the aiudittooltool agent. Type 'exit' to finish the chat."
    )
    agent_instance = get_agent(agent, 
                              verbose, 
                              model_name, 
                              temperature=temperature)
    try:
        while True:
            query = typer.prompt("You")
            if query == "exit":
                break
            response = agent_instance.run(query)
            typer.echo(f"aiudittooltool: {response}")
    except Exception as e:
        console.print_exception(max_frames=0)


if __name__ == "__main__":
    app()

    tools = [
        SmartContractCompilerTool(),
    ]

    agent = initialize_agent(
        tools=tools,
        llm=llm,
        agent=AgentType,
        verbose=True,
    )

