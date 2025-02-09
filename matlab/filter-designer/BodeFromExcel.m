function BodeFromExcel(FileName, OutputName)
    % BODEFROMEXCEL This function parse an Excel file with multiple columns :
    % 
    %   Arguments :  
    %       - Filename : Input filename (XLSX, CSV ...)
    %       - OutputName : Name of the file where the Bode plot is going to be
    %           printed once done. Printed as SVG and PNG.
    %
    %   Returns :
    %       - None
    %
    %   Waited columns :
    %       - F :   Frequency
    %       - Ve :  Input voltage
    %       - Vs :  Output voltage
    %       - Phi : Phase
    %
    %   Actions :
    %       Function will read the values, compute the bode diagram and
    %       plot it on screen and save it under the OutputName file in PNG
    %       and SVG.

    % Reading data
    data = readtable(FileName);

    F = data.F;
    Vs = data.Vs;
    Ve = data.Ve;
    Phi = data.Phi;

    % Computing values
    G = 20 * log(Vs ./ Ve);

    % Creating figure and plotting :
    figure;
    subplot(2, 1, 1);
    title("Gain (dB)");
    semilogx(F, G);

    subplot(2, 1, 2);
    title("Phase (°)");
    semilogx(F, Phi);

    % Ability to save the bode to a PNG file
    print(OutputName + ".png", '-dpng');
    print(OutputName + ".svg", '-dsvg');
end

