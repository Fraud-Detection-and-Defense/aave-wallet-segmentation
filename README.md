# aave-wallet-segmentation
A wallet segmentation analysis provided for Aave Grants DAO 

View readme in google docs at https://docs.google.com/document/d/1qPe5P7X9FhsVrNgdny8CuE81-3dOJ7LVAOKCvPnsn5M/edit?usp=sharing

# Aave Grant Final Submission 
### Aave Wallet Segmentation Profiles
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")
* Final Submission [Video Presentation](https://drive.google.com/file/d/1X8KSfrqaKvzJaZ69aol6_EEbzpAySXTG/view?usp=drive_link) 
* Final Presentation Slides [Doc](https://docs.google.com/presentation/d/1jmH_mYUKAbfpeS26G_rKwC1nDa-zkxxgucDgSEfEBPk/edit?usp=drive_link) [PDF](https://drive.google.com/file/d/1LlVqZOpd2JTfXs4PyrUI18NZj940sd0f/view?usp=drive_link)
* Final Write Up [Doc](https://docs.google.com/document/d/1PhqBSPe3vLQHI8e07EeMqUaj_aviwA2RFN_l5xjTpGU/edit?usp=drive_link) [PDF](https://drive.google.com/file/d/1wMvG5qZhcb5KCYB-RKCOalvjL9aOeXHl/view?usp=drive_link)

## Intro / TL;DR
The Fraud Detection & Defense workstream at Gitcoin applied and was approved for a grant to perform a wallet segmentation analysis for the Aave ecosystem. Using their unique understanding of onchain behaviors and analysis provided by 2 years defending Gitcoin from Sybil attacks, they put their team to work understanding the user groups & personas which interact with Aave contracts.

* The analysis clearly identifies 13 user personas
* The 13 personas are bucketed into 3 categories: Testers, Income, & Special Cases

**Recommendations for insights**
* Improve targeting & copy for marketing & to focus on revenue generating users
* Use to qualify participants in product research
* Consider custom experiences for highest value user personas*

**Potential to build on this work**
* Open source work can be built on by the community
* Consider time based behavioral analysis and retention analysis
* Create a system for identifying how this analysis is used to measure impact
* Run a targeted campaign to incentivize qualitative feedback at scale
  
## Data Discovery & Cleaning
* Previous Aave grant had already documented all data sources
* Contract calls: deposit, supply, borrow, repay, withdraw, redeemunderlying, liquidationcall, flashloan
* Chains: Arbitrum, Avalanche, Polygon, Fantom, Optimism, Ethereum
* Versions: 1,2,3
* Exogenous data sources: Lens, Snapshot, Trustalabs, Gitcoin, Debank
* Removed outliers, reduced sample size, merging of function calls
* Profiling based on 114,915 wallets available on mainnet for data availability
* Histograms: by chain, by event, by version
* Scatterplot matrix of all variables endogenous & exogenous
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")

## Methodology
* Non-linear dimensional reduction: t-SNE & UMAP
* Manual parameter search looking for meaningful separation
* Visual investigation of 3-Dimensional feature space
* Plotting multiple 2 dimensional projections of UMAP space
* Linking graphs with an interactive table to track cluster averages
* Manual brushing to investigate pairs of clusters for cohesion, compactness, & quantitative distinctness
* Reviewing the final cluster solution in 2D & 3D space

## Results (Personas)
![Image of 3D space gif](https://github.com/Fraud-Detection-and-Defense/aave-wallet-segmentation/blob/main/aave_cluster_pcp.png)( "Logo Title Text 1")
* Quantitative review of the group mean vectors using color g* radient for examination
* Parallel coordinate plots to visualize segments in multiple dimensions
* Personas created based on behavioral observations:

### Special Cases
* The Good Guys (18,512 | 16.11%)
* The Liquidated (2,324 | 2.02%)
* The Throwaway Accounts (3,191 | 2.78%)
* The Potential Arbitragers (3,824 | 3.33%)

### Income
#### **High Rollers**
* Without debt (6,553 | 5.7%)
* With debt (7,016 | 6.11%)
#### **Middle Class**
* High checking, low savings (10,174 | 8.85%)
* High savings, low checking (9,477 | 8.25%)
#### **Small Frys**
* Depositors on Ethereum (2,773 | 2.41%)
* Degen Active Depositors (1,202 | 1.05%)
* Debt Users (16,529 | 14.38%)
### **Testers**
* Ethereum Only (9,321 | 8.03%)
* Multichain (24,107 | 20.98%)

* ![procouvar](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")
