<img src="./assets/aiudit-logo-full.png" width="1000">

# :lock: A(i)udit
A(i)udit is an open-source tool that helps engineers incorporate security best practices and workflows earlier in their development lifecycle by using LLMs and AI Agents to lower the barrier for utility and implementation of auditing tools.

Use natural language to author, audit, and deploy - all from a single platform.

# :runner: Motivation & Description
In 2022 alone, over $3.6 billion USD was lost due to exploits & hacks from 167 major security incidents, with attacks on the Ethereum ecosystem accounting for 55.8% ($2.01 billion USD) of total losses ([Global Web3 Security Report 2022 by BEOSIN & LegalDAO](https://beosin.com/resources/Global_Web3_Security_Report_2022_.pdf)).

*Its clear: building with security in mind has _never_ been more important - but how do we make it easier for developers to do so to bridge this gap?*

Our answer is A(i)udit: a platform to help both developers & auditors to author, audit, and deploy smart contracts using natural language. 
* For developers, A(i)udit "shifts-left" security best practices by enabling rapid testing and prototyping to take place much earlier in the development lifecycle. Get ramped up & familiar with security and auditing tools in your dev loop _before_ commissioning a (costly) audit.
* For junior auditors, A(i)udit lets you focus on finding vulnerabilities by removing the overhead of learning & managing multiple tools, programs, environments, audit report templates, and frameworks. Hit the ground running faster & more effectively with A(i)udit.

A(i)udit help engineers perform complex development and auditing workflows using natural language promps. Below is a description of the workflow:
1. A user uploads their own smart contract to the platform, or describes their ideal smart contract & A(i)udit will produce one. _We currently only support EVM compatible smart contracts._
2. A(i)udit will then ask the user if they'd like Static Analysis tests to be run and will execute those tests on the target smart contract when instructed to. The results from these tests will be exported locally and rendered in the UI. _Currently we support Static Analysis tests using Mythril & Slither._
3. A(i)udit will then prompt the user if they would like to deploy the smart contract to a local Ethereum node for running fuzz tests. A(i)udit will bootstrap a local Ethereum node, deploy the contract, and execute Fuzz tests when instructed to. _We currently only support Ethereum for a private testnet option._
4. A(i)udit will export the results of the Fuzz tests into a report that is stored on-chain (IPFS).
5. The frontend will then fetch, parse, and render the audit report for easy review, triaging, sharing, and actioning.
6. The user can then address any vulnerabilities & repeat steps (1) through (6) until they are happy with the state of their smart contract.
7. When prompted, A(i)udit will compile & deploy the smart contract to a live testnet (or mainnet). _We currently support Polygon zkEVM, Gnosis Chain, Ethereum, Metamask Linea, and Avalanche C-Chain)._

# :nut_and_bolt: How its made
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
