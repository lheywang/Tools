% Tfestimator
% Output a TF that match in the best manner the inputed function
% 

% -------------------------------------------------------------------------
% Input variables
% -------------------------------------------------------------------------
% Maximal number of poles
MaxNp = 5;
% Minimal ressemblance percentage
Resolution = 99.5;

% -------------------------------------------------------------------------
% Data preparation
% -------------------------------------------------------------------------
% Get the minimal ressemblance percentage to be conserved
Minimal_Ressemblance = 100 - 10* ( 100 - Resolution);

% Prepare data (while handling initial conditions)


% To do
% Discard wrong ones
% Iterate until criterions are matched

% First create data
data = array2timetable([In, Out],StartTime=seconds(0),SampleRate=1);

% Create data collectors
ValidTF = [];
ValidFit = [];

% Then, get the best value
for Poles = 1:1:MaxNp
    parfor n = 1:Poles
        data2 = iddata(data);

        tf = tfest(data, 8, n, NaN);
    
        % Get simulation of TF
        Out_sim = parsim(tf);
        
        % simulate the value
        opt = compareOptions('InitialCondition','z');
        [ymod, fit] = compare(data2,tf,opt);

        % check if function is looking enough to the input data...
        % If, yes, append to stored data !
        if fit > Minimal_Ressemblance
           ValidFit = [ValidFit, fit];
           ValidTF = [ValidTF, tf];
        end
    end
end






