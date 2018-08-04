function clearhistory
%This file sets all of the variables in myhistory to 0
%When show history is prompetd, it will display zero trips and zero for
%average wait time
load('myhistoryfile.mat');
minutesmbta = 0;
minutestotal = 0;
minutesuber = 0;
totalcost = 0;
trips = 0;
tripsuber = 0;
tripsmbta = 0;
save('myhistoryfile','totalcost','trips','minutesmbta','minutesuber','minutestotal','tripsmbta','tripsuber')
end