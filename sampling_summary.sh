# /bin/bash

#establish path to csv, output file, and temp txt file of site codes
FILE="/home/shared/hasita/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUT="sampling_summary.txt"
SITES="sites.txt"

#count the unique sample sites, skip the header, extract column 2, print the site names, and count those as well
echo -e "\nNumber of sites:\t$(tail -n +2 $FILE | cut -d',' -f2 | sort | uniq | wc -l)" > "$OUT"

#add header
echo -e "\nSite_Code\tN_Samples\tN_Males\tN_Females" >> "$OUT"

#print list of the site codes to temp text file
tail -n +2 $FILE | cut -d',' -f2 | sort | uniq > "$SITES"

#create a loop for each unique site and the number
for site in $(cat "$SITES")
do
	total=$(grep ",$site," "$FILE" | wc -l)	#total samples
	males=$(grep ",$site," "$FILE" | grep ",M," | wc -l)	#male samples with clarification on which site
	females=$(grep ",$site," "$FILE" | grep ",F," | wc -l) #female samples with clarification on which sitre
	echo -e "$site\t$total\t$males\t$females" >> "$OUT"	#print to outfput file
done

#print to table in correct format
cat sampling_summary.txt | expand -t 20

