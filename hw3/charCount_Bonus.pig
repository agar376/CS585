/* Installed Pig on my local Mac Machine and did the assignment. Since it was a local installation, I used the local machine path for the files. Please update the paths in line 1 accordignly if you run the code.*/
files = load '/Users/ShobhitAgarwal/Dropbox/USC/Spring 17/CS 585/hw3/in/';
data_token = foreach files generate flatten(TOKENIZE(REPLACE(LOWER($0),'','|'), '|')) as ltr;
vowels = FILTER data_token BY (ltr == 'a' or  ltr == 'e' or ltr == 'i' or ltr == 'o' or ltr == 'u' );
grouped_ltrs = group vowels by ltr;
result = foreach grouped_ltrs generate group as ltr, COUNT(vowels.ltr) as total;
store result into '/Users/ShobhitAgarwal/Dropbox/USC/Spring 17/CS 585/hw3/out_Bonus/';
