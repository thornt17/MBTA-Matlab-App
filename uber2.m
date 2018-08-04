function uber2(startlat,startlong,endlat,endlong,in);
server_token = '8QujhrD-Ys_J1a14Ken4ZGXJYUtTEWN_AXvEX7Mc';
%Uber has multiple APIS, the ones used below estimate time and prices 
timeendpoint = 'https://api.uber.com/v1.2/estimates/time';
priceendpoint = 'https://api.uber.com/v1.2/estimates/price';
resptime = webread(timeendpoint,'server_token',server_token,'start_latitude',startlat,'start_longitude',startlong,'end_latitude',endlat,'end_longitude',endlong);
respprice = webread(priceendpoint,'server_token',server_token,'start_latitude',startlat,'start_longitude',startlong,'end_latitude',endlat,'end_longitude',endlong);
%in is an index for which type of uber you wish to take

%From the API, we are storing the type of uber, time until the next uber
%comes, the estimate price of the trip, and the estimated time of the trip
type = resptime.times(in).localized_display_name;
waitime = resptime.times(in).estimate;
wminutes = round(waitime/60);
estimateprice = respprice.prices(in).estimate;
duration = respprice.prices(in).duration;
dminutes = round(duration/60);
%The infor gathered is dispayed in a figure window, which will be called
%from our app
closest = sprintf('The closest %s is %d minutes away',type,wminutes);
totaltime = sprintf('The total trip will take %d minutes',dminutes);
costrange = sprintf('The total cost is in the range of %s',estimateprice);
f = figure('Position',[100 100 640 480]);
closestgui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.1 .75 .8 .15], 'FontSize', 20, 'String', closest);
totaltimegui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.1 .45 .8 .15], 'FontSize', 20, 'String', totaltime);
costrangegui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.1 .15 .8 .15], 'FontSize', 20, 'String', costrange);
%The information on the trip is saved in myhistoryfile.mat
load('myhistoryfile.mat')
trips = trips + 1;
tripsuber = tripsuber+1;
minutesuber = minutesuber + wminutes;
minutestotal = minutestotal + wminutes;
save('myhistoryfile','trips','minutesmbta','minutesuber','minutestotal','tripsmbta','tripsuber')
end