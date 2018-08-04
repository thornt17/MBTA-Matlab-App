function mbta3(startlat,startlong,endlat,endlong)
%A figure window is created to display our information
f = figure('Position',[100 100 640 480],'Visible','off');
endpoint = 'http://realtime.mbta.com/developer/api/v2/stopsbylocation?api_key=Bt447AhaTUyq0UKL8rnfLA';
startresp = webread(endpoint,'lat', startlat, 'lon', startlong, 'format', 'json');
i = 1;
while isempty(startresp.stop(i).parent_station_name) == 1
    i = i+1;
end
startstation = startresp.stop(i).parent_station_name;
startdistance = startresp.stop(i).distance;
startdistance = str2double(startdistance);
origin = sprintf('Your origin station is %s',startstation);
distance1 = sprintf('%s is %.2f miles away',startstation,startdistance);
origingui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.1 .75 .8 .15], 'FontSize', 14, 'String', origin);
distance1gui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.1 .7 .8 .15], 'FontSize', 14, 'String', distance1);
endresp = webread(endpoint,'lat', endlat, 'lon', endlong, 'format', 'json');
i = 1;
while isempty(endresp.stop(i).parent_station_name) == 1
    i = i+1;
end
endstation = endresp.stop(i).parent_station_name;
enddistance = endresp.stop(i).distance;
enddistance = str2double(enddistance);
destination = sprintf('Your destination station is %s\n',endstation);
distance2 = sprintf('%s is %.2f miles away from your final destination\n\n',endstation,enddistance);
destinationgui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.1 .6 .8 .15], 'FontSize', 14, 'String', destination);
distance2gui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.1 .55 .8 .15], 'FontSize', 14, 'String', distance2);
count = 0;
count2 = 0;
for j = 1:length(startresp.stop)
    if startresp.stop(j).stop_id(1) == '7'
        if length(startstation) == length(startresp.stop(j).parent_station_name)
            if startstation == startresp.stop(j).parent_station_name
                count2 = count2 + 1;
                stopid = startresp.stop(j).stop_id;
                count = count + 1;
                if count2 == 1
                    alertstop = stopid;
                end
                mbtanexttrain(stopid,count);
            end
        end
    end
end
alertpicture(alertstop)
f.Visible = 'on'
end

function alertpicture(stop)
    endpoint2 = 'http://realtime.mbta.com/developer/api/v2/predictionsbystop?api_key=Bt447AhaTUyq0UKL8rnfLA';
    resp2 = webread(endpoint2,'stop',stop);
    alertimage = ones(9,9,3)*255;
    if isempty(resp2.alert_headers) == 1
        alertimage(:,:,[1 3]) = 0;
    end
    if ~isempty(resp2.alert_headers) == 1
        alertimage(:,:,[2 3]) = 0;
    end
    alertimage(2,2:8,:) = 0;
    alertimage(2:8,5,:) = 0;
    g = figure('Position',[840 400 440 280]);
    image(alertimage)
end
 
function mbtanexttrain(stop,count)
endpoint2 = 'http://realtime.mbta.com/developer/api/v2/predictionsbystop?api_key=Bt447AhaTUyq0UKL8rnfLA';
resp2 = webread(endpoint2,'stop',stop);
train_name = resp2.stop_name;
if isempty(resp2.alert_headers) == 1
if isfield(resp2,'mode') == 1
    if iscell(resp2.mode.route.direction.trip)
        secondsaway = resp2.mode.route.direction.trip{1}.pre_away;
    else
        secondsaway = resp2.mode.route.direction.trip(1).pre_away;
    end
    secondsaway = str2double(secondsaway);
    minutes = floor(secondsaway/60);
    seconds = secondsaway - (minutes*60);
    nexttrain = sprintf('%d minutes and %d seconds until the next %s train\n',minutes,seconds,train_name);
    guiloc = .35 - 0.1*count;
    nexttraingui = uicontrol('Style', 'Text', 'Units', 'Normalized', 'Position',[.05 guiloc .95 .25], 'FontSize', 14, 'String', nexttrain);
end
if count == 1;
    load('myhistoryfile.mat')
    trips = trips + 1;
    tripsmbta = tripsmbta +1;
    minutesmbta = minutesmbta + minutes;
    minutestotal = minutestotal + minutes;
    save('myhistoryfile','trips','minutesmbta','minutesuber','minutestotal','tripsmbta','tripsuber')
end
end
end