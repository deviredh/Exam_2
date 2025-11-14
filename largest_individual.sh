#!/bin/bash

#establish path to csv and output text files
FILE="/home/shared/hasita/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUT="largest_individual_report.txt"
LIST="S_L_IP.txt"

#extract columns 2,3,4 (site/sex/length)
tail -n +2 "$FILE" | cut -d',' -f2,3,4 > "$LIST"

#find largest male and female, sort by length, and pick the largest value 
MALE=$(grep "M," "$LIST" | sort -t',' -k3,3n | tail -n 1)
FEMALE=$(grep "F," "$LIST" | sort -t',' -k3,3n | tail -n 1)

#print the columns to output
MLENGTH=$(echo "$MALE" | cut -d',' -f3)
MSITE=$(echo "$MALE" | cut -d',' -f1)

FLENGTH=$(echo "$FEMALE" | cut -d',' -f3)
FSITE=$(echo "$FEMALE" | cut -d',' -f1)


#compare the collection sites
if [ "$MSITE" = "$FSITE" ]; then
    same="Same site"
else
    same="Different sites"
fi

#create template for report
echo "" > "$OUT"
echo "Largest Individuals Report" >> "$OUT"
echo "" >> "$OUT"

echo "Largest Male Length: $MLENGTH" >>"$OUT"
echo "Collection Site: $MSITE" >> "$OUT"
echo "" >> "$OUT"

echo "Largest Female Length: $FLENGTH" >>"$OUT"
echo "Collection Site: $FSITE" >> "$OUT"
echo "" >> "$OUT"

echo "$same" >> "$OUT"

#print output file
cat "$OUT"
