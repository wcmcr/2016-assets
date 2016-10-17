rm temp.svg;
rm finished.pdf;
rm next.pdf;
finalcount=0;
count=0;
othername='';
othertwitter='';
rm -r pdfs;
mkdir pdfs;
while IFS=, read ticket name twitter first last
do
	let count=count+1;
	let finalcount=finalcount+1;
	  if [ $count -eq 2 ]
	  then
		count=0;
	    echo "Handling: ${name} ${twitter}";
	    echo "Handling2: ${othername} ${othertwitter}";
		cp template.svg temp.svg

		# search replace names and handles
		sed -i -e "s/name1/$name/g;s/twitter1/$twitter/g;s/name2/$othername/g;s/twitter2/$othertwitter/g" temp.svg

		# output PDF
		rsvg-convert -f pdf -o pdfs/$finalcount.pdf temp.svg

		# remove temp.svg
		rm temp.svg

		#exit;
	else
		othername=$name;
		othertwitter=$twitter;
	fi;
done < "names.csv"

# append page to master PDF
"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o finished.pdf pdfs/*.pdf
