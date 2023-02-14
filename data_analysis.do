********************************************************************************
* Author: Dr. Qi Kang                                                          *
* Adapted by: Manuel Garcia                                                    *                                               
* Date: January 2023                                                           *
********************************************************************************

//STEP 1: Import the raw data from Qualtrics (*.xlsx), merge it, apply quality assurance, and save it (*.dta).

// TTU PC code
/*clear
import excel "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data\Survey_B1_Dec15_2020.xlsx", sheet("Sheet0") firstrow
gen Block = 1
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data_output\block1.dta", replace

clear
import excel "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data\Survey_B2_Dec15_2020.xlsx", sheet("Sheet0") firstrow
gen Block = 2
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data_output\block2.dta", replace

clear
import excel "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data\Survey_B3_Dec15_2020.xlsx", sheet("Sheet0") firstrow
gen Block = 3
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data_output\block3.dta", replace

clear
use "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data_output\block1.dta"
append using "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data_output\block2.dta"
append using "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data_output\block3.dta"
drop if StartDate == "Start Date" | Progress != "100" | Finished == "False" | Q1 == "Abandonar encuesta"

save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain\data_output\data.dta", replace
*/


****************************************************************************************************************************************************************************

//STEP 2: Use as input the output from step 1, follow the procedure below and as a result each observation will be assigned its specific alternative, set, and choice

// TTU PC code
clear
use "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\data.dta", clear

// Drop missing answers
drop if (Block == 1 | Block == 2 | Block == 3) & (Q30 == "" | Q32 == "" | Q34 == "" | Q36 == "" | Q38 == "" | Q40 == "" | Q42 == "" | Q44 == "" | Q46 == "" | Q48 == "" | Q50 == "" | Q52 == "")


// Number of observations
gen obs = .
forvalues i = 1/`=_N' {
    replace obs = `i' if _n == `i'
    replace obs = obs[_n-1]+1 if _n > `i'
}


// Generate 12 choice sets with 3 alternatives each
foreach i in Alta Altb Altc Altd Alte Altf Altg Alth Alti Altj Altk Altl {
    gen `i'1 = 1
    gen `i'2 = 2
    gen `i'3 = 3
}


// transpose the matrix of alternatives
reshape long Alt, i(obs) j(Q) string


// Generate sets=12
gen Set = 12
local letters = "abcdefghijkl"

forval i = 1/12 {
    local l = substr("`letters'", `i', 1)
    replace Set = `i' if Q == "`l'1" | Q == "`l'2" | Q == "`l'3"
}


// Generate Choice
gen Choice = 0
forvalues i = 1/3 {
	replace Choice=1 if (Set==1) & (Block==`i') & (Q=="a1") & (Q30=="Opción 1")
	replace Choice=1 if (Set==1) & (Block==`i') & (Q=="a2") & (Q30=="Opción 2") 
	replace Choice=1 if (Set==1) & (Block==`i') & (Q=="a3")& (Q30=="Ninguno") 
	replace Choice=1 if (Set==2) & (Block==`i') & (Q=="b1") & (Q32=="Opción 1")
	replace Choice=1 if (Set==2) & (Block==`i') & (Q=="b2") & (Q32=="Opción 2") 
	replace Choice=1 if (Set==2) & (Block==`i') & (Q=="b3")& (Q32=="Ninguno") 
	replace Choice=1 if (Set==3) & (Block==`i') & (Q=="c1") & (Q34=="Opción 1")
	replace Choice=1 if (Set==3) & (Block==`i') & (Q=="c2") & (Q34=="Opción 2") 
	replace Choice=1 if (Set==3) & (Block==`i') & (Q=="c3") & (Q34=="Ninguno") 
	replace Choice=1 if (Set==4) & (Block==`i') & (Q=="d1") & (Q36=="Opción 1")
	replace Choice=1 if (Set==4) & (Block==`i') & (Q=="d2") & (Q36=="Opción 2") 
	replace Choice=1 if (Set==4) & (Block==`i') & (Q=="d3") & (Q36=="Ninguno") 
	replace Choice=1 if (Set==5) & (Block==`i') & (Q=="e1") & (Q38=="Opción 1")
	replace Choice=1 if (Set==5) & (Block==`i') & (Q=="e2") & (Q38=="Opción 2") 
	replace Choice=1 if (Set==5) & (Block==`i') & (Q=="e3") & (Q38=="Ninguno") 
	replace Choice=1 if (Set==6) & (Block==`i') & (Q=="f1") & (Q40=="Opción 1")
	replace Choice=1 if (Set==6) & (Block==`i') & (Q=="f2") & (Q40=="Opción 2") 
	replace Choice=1 if (Set==6) & (Block==`i') & (Q=="f3") & (Q40=="Ninguno") 
	replace Choice=1 if (Set==7) & (Block==`i') & (Q=="g1") & (Q42=="Opción 1")
	replace Choice=1 if (Set==7) & (Block==`i') & (Q=="g2") & (Q42=="Opción 2") 
	replace Choice=1 if (Set==7) & (Block==`i') & (Q=="g3") & (Q42=="Ninguno") 
	replace Choice=1 if (Set==8) & (Block==`i') & (Q=="h1") & (Q44=="Opción 1")
	replace Choice=1 if (Set==8) & (Block==`i') & (Q=="h2") & (Q44=="Opción 2") 
	replace Choice=1 if (Set==8) & (Block==`i') & (Q=="h3") & (Q44=="Ninguno")
	replace Choice=1 if (Set==9) & (Block==`i') & (Q=="i1") & (Q46=="Opción 1")
	replace Choice=1 if (Set==9) & (Block==`i') & (Q=="i2") & (Q46=="Opción 2") 
	replace Choice=1 if (Set==9) & (Block==`i') & (Q=="i3") & (Q46=="Ninguno") 
	replace Choice=1 if (Set==10) & (Block==`i') & (Q=="j1") & (Q48=="Opción 1")
	replace Choice=1 if (Set==10) & (Block==`i') & (Q=="j2") & (Q48=="Opción 2") 
	replace Choice=1 if (Set==10) & (Block==`i') & (Q=="j3") & (Q48=="Ninguno") 
	replace Choice=1 if (Set==11) & (Block==`i') & (Q=="k1") & (Q50=="Opción 1")
	replace Choice=1 if (Set==11) & (Block==`i') & (Q=="k2") & (Q50=="Opción 2") 
	replace Choice=1 if (Set==11) & (Block==`i') & (Q=="k3") & (Q50=="Ninguno") 
	replace Choice=1 if (Set==12) & (Block==`i') & (Q=="l1") & (Q52=="Opción 1")
	replace Choice=1 if (Set==12) & (Block==`i') & (Q=="l2") & (Q52=="Opción 2") 
	replace Choice=1 if (Set==12) & (Block==`i') & (Q=="l3") & (Q52=="Ninguno") 
}

* Save it
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\main_dataset.dta", replace


****************************************************************************************************************************************************************************

//STEP 3: Merge the main dataset with the experimental design and save it (*.dta)


* 3.1 Import the original experimental design, either in .xlsx or .dta format
use "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\exp_design.dta", clear

* 3.2 Create dummy variables for each stage of the supply chain and rename them
tab born, gen(dummy_born)
rename dummy_born1 Born_mx
rename dummy_born2 Born_us
rename dummy_born3 Born_tx
rename dummy_born4 Born_can
rename dummy_born5 Born_nic

tab raised, gen(dummy_raised)
rename dummy_raised1 Raised_mx
rename dummy_raised2 Raised_us
rename dummy_raised3 Raised_tx
rename dummy_raised4 Raised_can
rename dummy_raised5 Raised_nic

tab slaughtered, gen(dummy_slaughtered)
rename dummy_slaughtered1 Slaughtered_mx
rename dummy_slaughtered2 Slaughtered_us
rename dummy_slaughtered3 Slaughtered_tx
rename dummy_slaughtered4 Slaughtered_can
rename dummy_slaughtered5 Slaughtered_nic

tab fsafety, gen(dummy_fsafety)
rename dummy_fsafety1 Fsafety // 0=Standard; 1=Enhanced
drop dummy_fsafety2

tab prod, gen(dummy_prod)
rename dummy_prod2 Prod // 0=Approved; 1=Natural production practices
drop dummy_prod1

* 3.3 Save it
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\dataset_design.dta", replace

* 3.4 Create a new set of variables
//First, generate the new rows
clear 
input block set alt born raised slaughtered price fsafety prod 
0 0 3 0 0 0 0 0 0 0
end

//Next, use the `expand` command to add the 36 new rows
expand 36

//Iterate the variable block, assigning values of 1,2,3
replace block = int((_n-1)/12) +1

//Iterate the variable set, assigning values of 1 up to 12
replace set = 1 + (mod( _n-1, 12 ) )

//Save the new dataset
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\dataset_design2.dta", replace

* 3.5 Use the function append to merge horizontally the two databases for design
use "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\dataset_design2.dta", clear
append using "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\dataset_design.dta"

* 3.6  Rename the variables, generate the variable ASC (none option), fill up all the missing values with zeros, and drop unnecessary variables 
rename block Block 
rename set Set
rename alt Alt
rename price Price

replace Price=150 if Price==1
replace Price=220 if Price==2
replace Price=280 if Price==3
replace Price=350 if Price==4

foreach var of varlist * {
	replace `var' = 0 if missing(`var')
}

sort Block Set Alt

gen ASC = 0
replace ASC =1 if Alt ==3

drop born
drop raised
drop slaughtered
drop fsafety
drop prod

order Block Set Alt ASC Born_mx Born_us Born_tx Born_can Born_nic Raised_mx Raised_us Raised_tx Raised_can Raised_nic Slaughtered_mx Slaughtered_us Slaughtered_tx Slaughtered_can Slaughtered_nic Price Fsafety Prod

* 3.7 Save the new data set 
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\new_design.dta", replace

* 3.8 Merge the main dataset and the experimental design
use "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\main_dataset.dta", clear
merge m:1 Block Set Alt using "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\new_design.dta"


sort  obs Block Set Alt
drop if Block == . // 0 obervation deleted

gen CHOICESITUATION = int((_n-1)/3) +1

order CHOICESITUATION obs Block Set Alt Choice ASC Born_mx Born_us Born_tx Born_can Born_nic Raised_mx Raised_us Raised_tx Raised_can Raised_nic Slaughtered_mx Slaughtered_us Slaughtered_tx Slaughtered_can Slaughtered_nic Price Fsafety Prod

* 3.9 Save it
save "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\data_final.dta", replace // Data updated using TTU PC code


****************************************************************************************************************************************************************************

//STEP 4: Willingness to pay analysis, as input we will use the output from Step 3.

// TTU PC code
use "C:\Users\gar14685\OneDrive - Texas Tech University\PUBLICATIONS\In Progress\complex_supply_chain_backup_code\data_output\data_final.dta", clear

// Installing the mixlogitwtp package
ssc install mixlogitwtp
ssc install mixlogit

gen PRICEATRIB= (Price/18.9)/2.2 //USD/Lb. Exchange rate = $18.90:1USD
gen PRICEATRIB2= (-Price/18.9)/2.2 //USD/Lb. Exchange rate = $18.90:1USD

// Mix logit model
*Model 1
mixlogit Choice PRICEATRIB, rand(ASC Born_us Born_tx Born_can Born_nic Raised_us Raised_tx Raised_can Raised_nic Slaughtered_us Slaughtered_tx Slaughtered_can Slaughtered_nic Fsafety Prod) group(CHOICESITUATION)  id(obs) //Baseline: Domestic market (Mexico)

*Model 2
mixlogit Choice, rand(ASC PRICEATRIB Born_us Born_tx Born_can Born_nic Raised_us Raised_tx Raised_can Raised_nic Slaughtered_us Slaughtered_tx Slaughtered_can Slaughtered_nic Fsafety Prod) group(CHOICESITUATION)  id(obs) //Baseline: Domestic market (Mexico)


// Mix logit model in WTP space
*Model 1- including Texas as a independent place of origin
*mixlogitwtp Choice,  price(PRICEATRIB2)  rand(ASC Born_us Born_tx Born_can Born_nic Raised_us Raised_tx Raised_can Raised_nic Slaughtered_us Slaughtered_tx Slaughtered_can Slaughtered_nic Fsafety Prod) group(CHOICESITUATION)  id(obs) nrep(5) 


*Model 2- considering Texas as the same place of origin as the United States

//Merging the US and Texas
gen Born_usa_d = 1 if Born_us == 1 | Born_tx ==1
replace Born_usa_d = 0 if Born_usa_d == .

gen Raised_usa_d = 1 if Raised_us == 1 | Raised_tx ==1
replace Raised_usa_d = 0 if Raised_usa_d == .

gen Slaughtered_usa_d = 1 if Slaughtered_us == 1 | Slaughtered_tx ==1
replace Slaughtered_usa_d = 0 if Slaughtered_usa_d == .

*Model 2- considering Texas as the same place of origin as the United States
mixlogitwtp Choice,  price(PRICEATRIB2)  rand(ASC Born_usa_d Born_can Born_nic Raised_usa_d Raised_can Raised_nic Slaughtered_usa_d Slaughtered_can Slaughtered_nic Fsafety Prod) group(CHOICESITUATION)  id(obs) nrep(250) 


mixlbeta Born_us Born_tx Born_can Born_nic Raised_us Raised_tx Raised_can Raised_nic Slaughtered_us Slaughtered_tx Slaughtered_can Slaughtered_nic Price Fsafety Prod, nrep(50) saving(LABEL) replace
use LABEL.dta, replace


