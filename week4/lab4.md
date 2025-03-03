# Lab Week 4. Sociogenomics

[Google Shell](https://cloud.google.com/shell/docs/launching-cloud-shell?hl=en)


## Description
In this lab we will learn:
* Calculate IBS and relatedness
* Association analys

## Part I . Managing files and directories. (no need after week 4, just repeating the command)
Let's have a look a the file. 


Download the data using this command

```
wget https://www.nicolabarban.com/sociogenomics_lab/data/hapmap_CEU.bed --no-check-certificate
wget https://www.nicolabarban.com/sociogenomics_lab/data/hapmap_CEU.bim --no-check-certificate
wget https://www.nicolabarban.com/sociogenomics_lab/data/hapmap_CEU.fam --no-check-certificate

```


**PLINK QC**. combine different commands in one go
```


./plink     --bfile hapmap_CEU \
            --nonfounders \
			--autosome \
			--snps-only \
       	  	--mind 0.03 \
       		--geno 0.05 \
       		--maf 0.05 \
    		--hwe 0.00001 \
        	--make-bed  --out hapmap_CEU_QC     
			
```
## Select independent SNPS

Calculate linkage disequilibrium
```
./plink --bfile 1kg_hm3 \
	 	--ld rs1048488 rs3115850 \
		--out ld_example
```
Check also this: https://ldlink.nih.gov/?tab=home


## Calculate independent SNPs (Pruning)
```

./plink 	 --bfile 1kg_hm3  \
        	--indep-pairwise 50 5 0.2 \
        	--out  1kg_hm3
			
			
```


```
./plink --bfile 1kg_hm3 \
	 	--ld rs1048488 rs2519031 \
		--out ld_example2
```

Select from original sample independent SNPs
```
./plink		--bfile  1kg_hm3 \
			--extract 1kg_hm3.prune.in \
			--make-bed \
 			--out  1kg_hm3_indep

```


## Calculate IBS and relatedness

Calculate Identity By State matrix
```
./plink --bfile  1kg_hm3_indep \
		--keep 1kg_samples_EUR.txt \
		--distance --out ibs_matrix
```
Calculate relatedness matrix

```
./plink --bfile 1kg_hm3_indep --keep 1kg_samples_EUR.txt --make-rel --out rel_matrix

```

		
		
## GCTA

```
wget https://yanglab.westlake.edu.cn/software/gcta/bin/gcta-1.94.4-linux-kernel-4-x86_64.zip 
mv gcta-1.94.1-linux-kernel-4-x86_64/gcta64 ./
rm -r gcta-1.94.1-linux-kernel-4-x86_64/


```

```
./gcta64 --bfile 1kg_hm3 /
		--keep 1kg_samples_EUR.txt /
		 --make-grm-bin --out 1kg_hm3_allSNPs


./gcta64  --reml  --grm 1kg_hm3_allSNPs /
	  	--pheno BMI_pheno.txt /
		--grm-adj 0 /
		--grm-cutoff 0.05 /
		--out BMI_h2

```


## Association analys

Linear additive model
```
./plink    	--bfile 1kg_EU_BMI \
        	--snps rs9674439 \
       	 	--assoc \
      	 	--linear \
      		--out BMIrs9674439
```
Logistic additive model
```

./plink    	--bfile 1kg_hm3 \
			--pheno 
        	--snps rs9674439 \
       	 	--assoc \
      	 	--logistic \
      	 	--out Overweight_rs9674439

```
Linear dominant analysis
```
./plink    	 --bfile 1kg_hm3 \
        	 --snps rs9674439 \
       	 	--assoc \
      	 	--linear dominant \
      	 	--out BMIrs9674439
```		 
	
