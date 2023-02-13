# Willingness-to-pay-for-US-beef-in-foreing-markets
We are going to explore the WTP for US-Texas beef in international markets (Mexico), using Choice Experiments

//This code is a contribution of Manuel Garcia, Oscar Sarasty, and Qi Kang, all of them Ph.D. students of the Agricultural and Applied Economics Department of Texas Tech University

Software: STATA
File: data_analysis.do


STEP 1
a.	Import the raw data from Qualtrics in Excel format (*.xlsx). Usually, data is collected in Blocks; therefore, you can import more than one block.
b.	If your data involves more than one dataset or block, you must merge all the datasets.
c.	You should check the data quality. For example, drop incomplete observations ("Progress" is not 100%; "Finished" is False; or  Q1 == "Abandonar encuesta"). The criteria applied here are up to the researcher; they may vary from researcher to researcher.
d.	Finally, you need to save the new dataset in the STATA database format (*.dta)


STEP 2 
a.	As input, use the output from Step 1 (*.dta) 
b.	The procedure below is going to guide you through a process of data quality, eliminating observations with empty answers to the choice experiments. Recall: The criteria applied here are up to the researcher; they may vary from researcher to researcher.
c.	The code will assign an id to each observation (variable "obs")
d.	The code will generate 12 variations for the variable Alternative. The value 12 is selected because the dataset (survey) includes 12 Choice experiments.
e.	The variable Alternative will be transposed, and each observation/respondent will be assigned a total of 36 alternatives (combination of letters "abcdefghijkl" and numbers "1,2,3")
f.	The code will generate 12 Sets; each Alternative will be assigned to a specific Set. 
g.	The code will generate a dummy variable, "Choice," with values of 1 indicating the choice selected by respondents in each set.


STEP 3 
a.	As input, use the experimental design it can be either in .xlsx or .dta 
b.	The process create dummy variables for each stage of the supply chain (born, raised, and slaughtered), also for Food safety =1 (enhanced) and Production practices =1 (natural production practices)
c.	The code also generate a 3rd alternative (Alt=3) and ASC variable with values =1 if Alt=3; to reflect the consumer selection of "None."
d.	The code ends merging the main dataset and the experimental design to identify the choice selected in each set by consumers and, therefore, the combination of attributes chosen.
e. 	Finally, we save the dataset in the STATA dabase format (*.dta)


STEP 4
a.	We need to install the mixlogitwp and mixlogit packages into STATA.
b.	We must transform the product's Price from MX pesos/Kg to USD/lb to make easy further analysis. We generate two variables for Price, one positive and one negative.
c.	We can run a Mix logit model and the Mix logit model in WTP space.
