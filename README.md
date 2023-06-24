<img src="./assets/aiudit-logo-full-nouns.png" width="1000">

# :lock: A(i)udit (TL;DR)
A(i)udit is an open-source tool that gracefully adds security best practices _earlier in the developer loop_ to help write safer, more secure smart contracts. A(i)udit uses LLMs and AI Agents to lower the barrier for utility and implementation of auditing tools to capture more vulnerabilities and bugs far earlier in the development process, reducing the time it takes to eventually audit and increasing the baseline code quality for a brighter, more secure web3 future.

Engineers can use natural language to author, audit, and deploy - all from a single platform.

# :runner: Motivation (Why?)
In 2022 alone, over $3.6 billion USD was lost due to exploits & hacks from 167 major security incidents - with a *whopping 48.5% of these being from unaudited protocols!* ([Global Web3 Security Report 2022 by BEOSIN & LegalDAO](https://beosin.com/resources/Global_Web3_Security_Report_2022_.pdf)). Still, the most common developer loop today is to write a smart contract & run a series of short unit tests against it before "tossing it over the wall" to auditing firms. 

__Its clear: building with security in mind has _never_ been more important - but how do we make it easier for developers to take incorporate a security-first mindset in their developer loop?__

Our answer is A(i)udit: a platform to help both developers & auditors to author, audit, and deploy smart contracts using natural language and AI agents. 
* For developers, A(i)udit "shifts-left" security best practices by enabling security-specific testing and rapid prototyping to take place much earlier in the development lifecycle. **Get ramped up & familiar with security and auditing tools in your dev loop _before_ commissioning a (costly) audit.**
* For junior auditors, A(i)udit lets you focus on finding vulnerabilities by removing the overhead of learning & managing multiple tools, programs, environments, audit report templates, and frameworks. **Hit the ground running faster & more effectively with A(i)udit.**

# :blue_book: Description (What?)
Specifically, A(i)udit is a tool that developers can use to execute complex security and auditing workflows using natural language. Below is a description of the workflow:
1. The user uploads their own smart contract to the platform. Alternatively, a developer can use A(i)udit to help them get started on a smart contract too. _We currently only support EVM compatible smart contracts._
2. The user can then simply ask A(i)udit to run Static Analysis tests on the target smart contract. The test results will be exported stored on IPFS using web3.storage and locally as well to be displayed in the UI. _Currently we support Static Analysis tests using Mythril & Slither._
3. The user can then ask A(i)udit to deploy the smart contract to a local Ethereum node. A(i)udit will bootstrap a local Ethereum node, deploy the contract locally using the Council CLI from DELV. _We currently only support Ethereum for a private testnet option._
4. THe user can then ask A(i)udit to execute Fuzz tests using Foundry on the deployed smart contract. This can be on a smart contract deployed to a local net or a live testnet.
5. A(i)udit will export the results of the Fuzz tests into a report that is stored on-chain (IPFS).
6. The frontend will then fetch, parse, and render the audit report for easy review, triaging, sharing, and actioning.
7. The user can then address any vulnerabilities & repeat steps (1) through (6) until they are happy with the state of their smart contract.
8. When prompted, A(i)udit will compile & deploy the smart contract to a live testnet (or mainnet). _We currently support Polygon zkEVM, Gnosis Chain, Ethereum, Metamask Linea, and Avalanche C-Chain)._

# :nut_and_bolt: How A(i)udit was born
A(i)udit was made using <TODO>

The following are some of the components for the application:
* Frontend: <TODO>
* AI Model: <TODO>
* AI Agent: <TODO>
* Agent Tools: <TODO>
* Environment: <TODO>
* Auditing Tools: <TODO>
* Chains deployed: <TODO>

Our roadmap is ambitious, we plan to invest in:
1.  <TODO>
2.  <TODO>
3.  <TODO>

[1] https://cyvers.ai/2023-web3-security-report

# Usage
## Installation
poetry install

npm i @openzeppelin/contracts@4.8.3

poetry run python -c "import solcx; solcx.install_solc('0.8.19')"

# When running the slither test, we needs to setup the following in the virtula env
$ solc-select install <version> 
$ solc-select versions
$ solc-select use 0.8.19
## Usage

# need to add slither-analyzer dependency
