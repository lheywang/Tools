function [TF, Fit, SimOut] = estimateTF(Time, In, Out, MaxNp, IOD)
    % estimateTF Try a lot of options and return the greatest TF function
    % over a specified data set.
    %
    %   Parameters :
    %       - Time :    Time axis of the measure
    %       - In :      Command values
    %       - Out :     Measured values
    %       - MaxNp :   Maximal number of poles / zeroes for the TF. (*) 
    %       - IOD :     Delay of the TF. NaN if unkown, otherwise set delay (**)
    %
    %   Returns :
    %       - TF :      The estimated TF
    %       - Fit :     The fit percentage over the input data.
    %       - SimOut :  The values computed by Matlab that correspond to
    %                   the TF response to the input data. Used to get the
    %                   matching value and for the user to estimate the
    %                   best option !
    %
    %   Description :
    %
    %       This function approximate a transfer function to match the
    %       input output relation seen.
    %
    %   Warning : 
    % 
    %       (*) :   This value greatly impact performances of the function. 
    %               Reduce if the code is too slow for you, or increase if
    %               the result isn't enough precise.
    %               This parameter change the CPU load, and thus impact
    %               more the lower end machines.
    % 
    %       (**) :  This value change the IO delay of the TF. When NaN is
    %               used, the tool detect the delay by itself, but from
    %               experience does not output the greatest results. 
    %               A second run with the real IO delay may be needed to get
    %               the greatest results (this time with a defined IOD
    %               value)

    % -------------------------------------------------------------------------
    % Data preparation
    % -------------------------------------------------------------------------
    % First create data
    data = array2timetable([In, Out],StartTime=seconds(Time(1)), SampleRate=Time(2) - Time(1));
    
    % -------------------------------------------------------------------------
    % TF estimation for various settings
    % -------------------------------------------------------------------------
    Fit = 0;
    for p = 1:1:MaxNp
        for z = 1:p
            % debug prints...
            fprintf("Iteration %d-%d over %d-%d", p, z, MaxNp, MaxNp)
    
            % Estimate TF
            tf = tfest(data, p, z, IOD);
        
            % Store data 
            if tf.Report.Fit.FitPercent > Fit
                TF = tf;
                Fit = tf.Report.Fit.FitPercent;
            end
        end
    end
    
    % -------------------------------------------------------------------------
    % Output the results
    % -------------------------------------------------------------------------
    fprintf("After trying everything, found a TF that is %.3f percents matching with the input data. Plots are available then", Fit)
    % Print the TF
    TF
    
    % Get the best TF here
    SimOut = lsim(TF, In, Time);
    
    % plot it
    plot(Time, In); hold on;
    plot(Time, Out); hold on;
    plot(Time, SimOut); hold on;
    
    % END !
end