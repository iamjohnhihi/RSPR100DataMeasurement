% Find a tcpip object.
obj1 = instrfind('Type', 'tcpip', 'RemoteHost', '130.216.118.120', 'RemotePort', 5555, 'Tag', '');

% Create the tcpip object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = tcpip('130.216.118.120', 5555);
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Disconnect from instrument object, obj1.
fclose(obj1);

% Connect to instrument object, obj1.
fopen(obj1);

% Communicating with instrument object, obj1.
%QUERY
data1 = query(obj1, '*IDN?');

disp(data1);

%WRITE
%fprintf(obj1, '*IDN?');
%READ
%data2 = fscanf(obj1);

%Initialise
%set FFM mode
fprintf(obj1, 'SENS:FREQ:MODE CW');
%set 500k SPAN
fprintf(obj1, 'SENS:FREQ:SPAN 500k');
%set ref level 0 dBm = 107 dBuV
fprintf(obj1, 'DISP:IFP:LEV:REF 107');
%set level range 120 dBm **not sure the unit is either steps or dBuV
fprintf(obj1, 'DISP:IFP:LEV:RANG 120');
%set measurement time 500 us
fprintf(obj1, 'MEAS:TIME 0.5m');


fprintf(obj1, 'FREQ 1881.2MHz');
data3 = query(obj1, 'FREQ?');
disp(data3);

fprintf(obj1, 'CALC:IFP:MARK:MAX');

data = query(obj1, 'SENS:DATA?');
disp(data); %signal strength in dBuV
l = str2double( data ) - 107.0; %convert dBuV to dBm 
disp(l);
