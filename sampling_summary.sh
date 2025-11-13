# /bin/bash

FILE="/home/shared/hasita/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUT="sampling_summary.txt"
SITES="sites.txt"

echo -e "\nNumber of sites:\t$(tail -n +2 $FILE | cut -d',' -f2 | sort | uniq | wc -l)" > sampling_summary.txt
echo -e "\nSite_Code\tN_Samples\tN_Males\tN_Females" >> sampling_summary.txt

tail -n +2 $FILE | cut -d',' -f2 | sort | uniq > "$SITES"

for site in $(cat "$SITES")
do
	total=$(grep ",$site," "$FILE" | wc -l)
	males=$(grep ",$site," "$FILE" | grep ",M," | wc -l)
	females=$(grep ",$site," "$FILE" | grep ",F," | wc -l)
	echo -e "$site\t$total\t$males\t$females" >> "$OUT"
done

cat sampling_summary.txt | expand -t 20

rm sites.txt
