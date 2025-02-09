function [R1, R2, C1, C2] = FilterDesignerSallenKeyLP(Fc, Coeff, ForcedComponent)
    % FILTERDESIGNERSALLENKEYHP Compute values of component for a given low pass filter (Sallen Key).
    % 
    %   Compute the values of component to match a defined transfer
    %   function.
    %
    %   Arguments :
    %       - Fc :      Cuttoff frequency
    %       - Coeff :   The normalized coefficient
    %       - ForcedComponent : The value to be forced. (R=100R or C=1nF).
    %           Value is parsed automatically.
    % 
    %   Returns :
    %       - R1 : Value of the first resistor
    %       - R2 : Value of the second resistor
    %       - C1 : Value of the first capacitor
    %       - C2 : Value of the second capacitor
    %   
    %   Note :
    %       For forced values, both will be set to equal.
    % 
    %   Note2 : 
    %       Coeff is available on standard butterworth tables.
    %
    %   Warning : 
    %       This function only accept a defined C value. Passing an R value
    %       will trigger an error since we end up on a case where we need
    %       to choose a value.
    % 

    % =====================================================================
    % Parse forced component :
    % =====================================================================
        % Check for valid input formats
    if ~startsWith(ForcedComponent, 'R=') && ~startsWith(ForcedComponent, 'C=')
        error('Invalid input format. Input must start with "R=" or "C=".');
    end
    % Extract value string
    tmp = char(ForcedComponent);
    valueString = tmp(3:end);

    % Parse value string
    try
        if contains(valueString, 'k')
            parsedValue = str2double(valueString(1:end-2)) * 1e3; 
        elseif contains(valueString, 'M')
            parsedValue = str2double(valueString(1:end-2)) * 1e6; 
        elseif contains(valueString, 'G')
            parsedValue = str2double(valueString(1:end-2)) * 1e9; 
        elseif contains(valueString, 'T')
            parsedValue = str2double(valueString(1:end-2)) * 1e12;
        elseif contains(valueString, 'm')
            parsedValue = str2double(valueString(1:end-2)) * 1e-3; 
        elseif contains(valueString, 'u')
            parsedValue = str2double(valueString(1:end-2)) * 1e-6;
        elseif contains(valueString, 'n')
            parsedValue = str2double(valueString(1:end-2)) * 1e-9; 
        elseif contains(valueString, 'p')
            parsedValue = str2double(valueString(1:end-2)) * 1e-12; 
        elseif contains(valueString, 'f')
            parsedValue = str2double(valueString(1:end-2)) * 1e-15; 
        else
            parsedValue = str2double(valueString); 
        end
    catch
        error('Invalid value format. Please provide a valid number with optional units (k, M, G, T, m, u, n, p, f).');
    end

    % =========================================================================
    % CALCULS
    % =========================================================================
    Wc = 2 * pi * Fc;

    % Determine component type
    if startsWith(ForcedComponent, 'R=')

        R1 = parsedValue;
        R2 = parsedValue;

        C1 = Coeff / (Wc * (R1 + R2));
        C2 = 1 / ((Wc ^ 2) * R1 * R2 * C1);

    % C is the forced component
    else
        error("This equation is not solvable, please assert that both R are equivalent by setting a value.")

    end

end

