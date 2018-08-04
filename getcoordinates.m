function [lat long] = getcoordinates(address)
%This function converts a street to latitude and longitude, we did this
%by using the google maps API
endpoint = 'https://maps.googleapis.com/maps/api/geocode/json';
resp = webread(endpoint,'key','AIzaSyBxkutvq7uQQzm9d5rZ1GRdgvqzoJNHC-M','address',address);
lat = resp.results.geometry.location.lat;
long = resp.results.geometry.location.lng;
end