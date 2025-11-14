# /bin/bash

#establish path to csv and output text files
FILE="/home/shared/hasita/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUT="measurer_summary.txt"
INITIALS="measurer_initials.txt"
SAMPLES="measurer_sample_total.txt"

#extract the initials from column 1
tail -n +2 "$FILE" | tr -d '\r' | cut -d',' -f1 | sort | uniq > "$INITIALS"

#create header
echo -e "Measurer\tSamples\tRural\tSuburban\tUrban" > "$OUT"

#create while loop for each measurer
while read M
do

	#extract the number of samples meadured
	grep "^$M," "$FILE" | tr -d '\r' > "$SAMPLES"

	#count all samples
	TOTAL=$(wc -l < "$SAMPLES")

	#set counters to zero
	RURAL=0
	SUBURBAN=0
	URBAN=0

	#create while loop that reads the amount of samples and organizes them based on column 5
	while IFS=',' read measurer site sex length ip
	do

		#clean ip
		ip=$(echo "$ip" | tr -d '\r' | tr -d '\n' | tr -d ' ')

		if [ "$ip" -lt 15 ]; then
			RURAL=$(expr $RURAL + 1)
		elif [ "$ip" -ge 15 ] && [ "$ip" -le 49 ]; then
			SUBURBAN=$(expr $SUBURBAN + 1)
		else
			URBAN=$(expr $URBAN + 1)
		fi
	done < "$SAMPLES"

	#format the output table
	echo -e "$M\t$TOTAL\t$RURAL\t$SUBURBAN\t$URBAN" >> "$OUT"

done < "$INITIALS"

#print table
cat "$OUT" | expand -t 16
