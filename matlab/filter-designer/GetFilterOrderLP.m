function N = GetFilterOrderLP(As, Fc, Fa)
    %GETFILTERORDERHP Return the minimal filter order to match theses
    %criterions
    %   
    %   Compute and round the filter order needed to achieve the
    %   specifications needed.
    % 
    %   Arguments :
    %       - As : Attenuation needed
    %       - Fc : Cutoff frequency
    %       - Fa : Attenuation frequency
    %
    %   Returns :
    %       - N : Order of the filter

    N = ceil(As / (20 * log10(Fa / Fc)));

end

