function fileinitialize
fid = fopen('myhistoryfile.mat');
if fid == -1
    trips = 0;
    minutesmbta = 0;
    minutesuber = 0;
    minutestotal = 0;
    tripsuber = 0;
    tripsmbta = 0;
    save('myhistoryfile','trips','minutesmbta','minutesuber','minutestotal','tripsmbta','tripsuber')
end
fid2 = fopen('myhistoryprint2.txt');
if fid == -1
    save('myhistoryprint2.txt')
end
fid3 = fopen('myhistoryprint3.txt');
if fid == -1
    save('myhistoryprint3.txt')
end
end