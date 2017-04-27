/* Installed Pig on my local Mac Machine and did the assignment. Since it was a local installation, I used the local machine path for the files. Please update the paths in line 1 accordignly if you run the code.*/
files = load '/Users/ShobhitAgarwal/Dropbox/USC/Spring 17/CS 585/hw3/in/';
data_token = foreach files generate flatten(TOKENIZE(REPLACE(LOWER($0),'','|'), '|')) as character;
grouped_chars = group data_token by character;
result = foreach grouped_chars generate group, COUNT(data_token);
store result into '/Users/ShobhitAgarwal/Dropbox/USC/Spring 17/CS 585/hw3/out/';
