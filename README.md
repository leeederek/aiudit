<img src="./assets/aiudittool-logo-full.png" width="1000">

# :lock: A(i)udit
A(i)udit is the first open-source, security-first development platform that empowers both auditors & developers to more effectively secure the future of web3 by combining auditing tools with LLMs and AI Agents. 

Use natural language to author, audit, and deploy - all from a single platform.

# Description & Motivation
In 2022 alone, over $3.6 billion USD was lost due to exploits & hacks from 167 major security incidents, with attacks on the Ethereum ecosystem accounting for 55.8% ($2.01 billion USD) of total losses ([Global Web3 Security Report 2022 by BEOSIN & LegalDAO](https://beosin.com/resources/Global_Web3_Security_Report_2022_.pdf)). The data speaks for itself: building with security in mind has *never* been more important - but how do we make it easier for developers to do so? How do we expand the effectiveness of audits while streamlining how developers write and ship safe, secure code?

To tackle this, we introduce A(i)udit: a platform to help both developers & auditors to author, audit, and deploy smart contracts using natural language. 
* For auditors, A(i)udit lets you focus on finding vulnerabilities by removing the overhead of managing multiple tools, programs, environments, audit report templates, and frameworks. Get things done faster & more effectively with A(i)udit.
* For developers, A(i)udit "shifts-left" security best practices by enabling rapid testing and prototyping to take place much earlier in the development lifecycle. Get ramped up & familiar with security and auditing tools before you pay for an expensive audit.

A(i)udit  help engineers perform complex development and auditing workflows using natural language promps. Below is a description of the workflow:
1. A user uploads their own smart contract to the platform, or describes their ideal smart contract & A(i)udit will produce one. _We currently only support EVM compatible smart contracts._
2. A(i)udit will then ask the user what types of pre-deployment tests should be run, and will execute those tests on the target smart contract when instructed to. _Currently we support Static Analysis tests using Mythril._
3. A(i)udit will then prompt the user if they would like to deploy the smart contract to a local Ethereum node for running execution-level tests. _A(i)udit will bootstrap a local Ethereum node, deploy the contract, and execute post-deployment tests when instructed to._
4. A(i)udit will export the results of the tests into a report that is stored on-chain (IPFS). You can have the option of this data being stored locally as well.
5. The frontend will then fetch, parse, and render the audit report for easy review, sharing, and actioning.
6. The developer will then be able to fix those vulnerabilities & repeat steps (1) through (5) until they are happy with the state of their smart contract.
7. When prompted, A(i)udit will compile & deploy the smart contract to a live testnet (or mainnet). _We currently support Polygon zkEVM, Gnosis Chain, Ethereum, Metamask Linea, and Avalanche C-Chain)._

# How its made
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


# How its made


