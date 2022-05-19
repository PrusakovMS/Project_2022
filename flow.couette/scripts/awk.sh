BEGIN{
read_flag=0;
p=0;
y=0;
k=0;
char mol;
print "Watching...";
}
{
	if (read_flag==1) {
		p=$2;
		y=$4;
		k=k+1;
		read_flag=0;
		if (p==2) {
			print "Step: " k "The first molecule is He, its ys = " y;
	      	}
		else {
			print "Step: " k "The first molecule is Not He and its ys = " y;
		}
	}
	if ($2=="ATOMS") {
		read_flag=1;
	}
}
END{
print "Program finished";
}
