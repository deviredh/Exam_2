#!/bin/bash

#establish path to csv and output text file
FILE="/home/shared/hasita/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUT="Urbanization_classification.txt"

#add header for output table
echo -e "Site_Code\tClass" > "$OUT"

#extract a list of the sites and ips, remove any extra characters and duplicates
tail -n +2 "$FILE" | tr -d '\r' | tr -d '\t' | tr -d ' ' | cut -d',' -f2,5 | sort -u  > ip_sites.txt

#create a loop for each site and ip class
while IFS=',' read site ip
do
	#make sure ips are clean
	ip=$(echo "$ip" | tr -d '\r')

	#establish class rules
	if [ "$ip" -lt 15 ]; then
		class="Rural"
	elif [ "$ip" -le 49 ]; then
		class="Suburban"
	else
		class="Urban"
	fi

	#print results to output table
	echo -e "$site\t$class" >> "$OUT"
done < ip_sites.txt

#print to text file
cat "$OUT"
