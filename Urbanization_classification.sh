#!/bin/bash

FILE="fixed.csv"
echo -e "Site_Code\tClass" > urbanization_classification.txt

tail -n +2 "$FILE" | cut -d',' -f2,5 > pairs.txt

> seen.txt

while IFS=',' read site ip
do
	if grep -w "$site" seen.txt > /dev/null; then
		continue
	fi

	echo "$site" >> seen.txt

	if [ "$ip" -lt 15 ]; then
		class="Rural"
	elif [ "$ip" -le 49 ]; then
		class="Suburban"
	else
		class="Urban"
	fi

	echo -e "$site\t$class" >> urbanization_classification.txt
done < pairs.txt

cat urbanization_classification.txt

