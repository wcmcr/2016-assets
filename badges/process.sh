
count=0;
othername='';
othertwitter='';
while IFS=, read ticket name twitter
do
	let count=count+1;
	  if [ $count -eq 2 ]
	  then
		count=0;
	    echo "Handling: $name|$twitter";
	    echo "Handling2: $othername|$othertwitter";
		cp template.svg temp.svg

		# search replace name1
		sed -i -e 's/name1/$name/g' temp.svg

		# search replace twitter1
		sed -i -e 's/twitter1/$twitter/g' temp.svg
		# search replace name2
		sed -i -e 's/name2/$othername/g' temp.svg
		# search replace twitter2
		sed -i -e 's/twitter2/$othertwitter/g' temp.svg

		# output PDF
		svg-convert -f pdf -o next.pdf temp.svg

		# remove temp.svg
		rm temp.svg

		# append page to master PDF
		gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf next.pdf
	else
		othername=$name;
		othertwitter=$twitter;
	fi;
done < "names.csv"
