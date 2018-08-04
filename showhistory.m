function showhistory

fid2 = fopen('myhistoryprint2.txt','w');
load('myhistoryfile.mat')
fprintf(fid2,'You have taken %d trips\n',trips);
close = fclose(fid2);

fid3 = fopen('myhistoryprint3.txt','w');
load('myhistoryfile.mat')
if trips == 0;
    fprintf(fid3,'On average you have waited 0 minutes\n');
else
    fprintf(fid3,'On average you have waited %.1f minutes\n',(minutestotal/trips));
end
close = fclose(fid3);

f = figure('Position',[100 100 640 480]);
x = 1:2;
y = [minutesuber/tripsuber minutesmbta/tripsmbta];
b = bar(x,y);
set(gca,'XTick',1:2);
set(gca,'XTickLabel',{'Uber', 'MBTA'});
title('Here is a graph of average wait times, more information is available in the command window')
ylabel('Average Wait Time (minutes)')
xlabel('Transportation Service')

type myhistoryprint2.txt
type myhistoryprint3.txt
end