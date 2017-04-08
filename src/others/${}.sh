for f in *copy.html;
 do mv "$f" "${f/copy.txt/.txt}";
done