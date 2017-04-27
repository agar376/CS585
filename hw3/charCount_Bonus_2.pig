/* Installed Pig on my local Mac Machine and did the assignment. Since it was a local installation, I used the local machine path for the files. Please update the paths in line 1 accordignly if you run the code. The code generates the top #1 flavor and does not generate any 2nd best or 3rd best and so on.*/
customer = load '/Users/ShobhitAgarwal/Dropbox/USC/Spring 17/CS 585/hw3/bonus_2/customer.txt' USING PigStorage(' ') as (name:chararray, age:int);
purchase = load '/Users/ShobhitAgarwal/Dropbox/USC/Spring 17/CS 585/hw3/bonus_2/purchase.txt' USING PigStorage(' ') as (name:chararray, flavor:chararray);
required_customers = FILTER customer BY (age == 10 OR age == 11 OR age == 12);
joined_data = JOIN required_customers by LOWER(name), purchase by LOWER(name);
grouped_data = GROUP joined_data BY LOWER(flavor);
result_data = foreach grouped_data generate group as flavor, COUNT(joined_data.flavor) as total;
fav_flavor = LIMIT (ORDER result_data BY total DESC) 1;
result = FOREACH fav_flavor GENERATE $0;
store result into '/Users/ShobhitAgarwal/Dropbox/USC/Spring 17/CS 585/hw3/out_Bonus_2/';
