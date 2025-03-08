# Lab Week 5. Sociogenomics

[Google Shell](https://cloud.google.com/shell/docs/launching-cloud-shell?hl=en)


## Description
In this lab we will learn:
* Calculate IBS and relatedness
* Calculate and visualize PCA
* Quality control 
* GWAS with covariates


YOu can download data from 1000Genome from week3 tutorial

```
cd $HOME

wget -O week3.zip https://www.dropbox.com/scl/fi/kvsdtvsl3m4gl19omle1y/week3.zip?rlkey=3fyj402e77jsvo97iwz8ke7sc&e=1&st=k1x60x1z&dl=0
unzip  week3.zip 
mv week3/*.*  ./
rm -r week3/
rm -r __MACOSX
```


## **Step 1: Compute IBD Using PLINK**
PLINK estimates the proportion of IBD alleles between pairs of individuals. To do this, use the `--genome` flag:

```
./plink --bfile 1kg_hm3 --genome --out ibd_results

```


This will generate an output file (ibd_results.genome) with pairwise relatedness estimates.

## **Step 2: Understanding the IBD Output**
The output file (`ibd_results.genome`) contains several columns. The most relevant for identifying relatives are:

- **PI_HAT**: Estimated proportion of alleles shared identical by descent (IBD).
- **Z0**: Probability that the pair shares **zero** alleles IBD.
- **Z1**: Probability that the pair shares **one** allele IBD.
- **Z2**: Probability that the pair shares **two** alleles IBD.
- **IBS0**: Number of SNPs where both individuals have different alleles (used to detect sample swaps).

### **Interpreting PI_HAT Values**
The **PI_HAT** value helps classify relationships between individuals. Use the following thresholds as a guide:

| **PI_HAT Value** | **Relationship** |
|------------------|------------------------------|
| > 0.9           | Duplicate samples / Identical twins |
| 0.4 - 0.6       | Full siblings |
| 0.2 - 0.4       | Half-siblings / Grandparent-grandchild |
| 0.1 - 0.2       | First cousins |
| < 0.1           | Unrelated individuals |

If PI_HAT is **greater than 0.9**, the individuals are likely **duplicates** or **identical twins**. If it falls between **0.4 and 0.6**, they are likely **full siblings**.

You can also check **Z0, Z1, and Z2** values:
- **Z2 ≈ 1** → The individuals are likely **monozygotic twins**.
- **Z1 ≈ 1** → Indicates **first-degree relatives** (e.g., siblings or parent-child).
- **Z0 ≈ 1** → The individuals are likely **unrelated**.


```
head ibd_results.genome 

```


