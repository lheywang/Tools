function Points = CreateFrequencyPoints(Fcentrale, TotalPoints, Start, End)
    % CreateFrequencyPoints Create a repartition of the points to take when
    % measuring frequency responses arround a corner frequency.
    %
    %   Parameters :
    %       - Fcentrale :       Frequency of interest
    %       - TotalPoints :     Total number of measure to be done
    %       - Start :           Start frequency
    %       - End :             End frequency
    %
    %   Returns :
    %       - Points : A list of the frequency to be measured.
    %
    %   Description :
    %
    %       This function return a repartition of the frequency to measure to get
    %       the best results when doing Bode diagrams, while measuring in the
    %       fastest way !
    %       This is done by splitting the points in different areas :
    %       | ---------- | ---------- | ---------- | ---------- | ---------- |
    %     Start      0.1 * Fc     0.5 * Fc  Fc   2 * Fc      10 * Fc        End
    %       | ---10 %--- | ---20 %--- | ---40 %--- | ---20 %--- | ---10 %--- |
    %
    %       This gave us the best results with the least number of points.
    %
    %   Warning : 
    %       If the upper range is smaller than 10* Fc, then the last values
    %       will be the same ! The number of values can't be take in account here.

    % =========================================================================
    % CALCULS
    % =========================================================================
    % Decades entourant FC :
    Infe = Fcentrale * 0.1;
    Supe = Fcentrale * 10;
    
    % Points d'intérêt :
    Infe2 = Fcentrale * 0.5;
    Supe2 = Fcentrale * 2;
    
    % Répartition des points pour centrer les mesures là ou il est important de
    % bien mesurer la réponse :
    Nfar = TotalPoints * 0.1;
    Ncentrale = TotalPoints * 0.4;
    Ndecade = TotalPoints * 0.2;
    
    % Normalisation des valeurs pour les fonctions logspace :
    StartNorm = log10(Start);
    EndNorm = log10(End);
    InfNorm = log10(Infe);
    SupNorm = log10(Supe);
    Inf2Norm = log10(Infe2);
    Sup2Norm = log10(Supe2);
    
    % clearing useless variables
    clear Infe Supe Infe2 Supe2 TotalPoints Start End Fcentrale;
    
    % =========================================================================
    % GENERATION DES POINTS
    % =========================================================================
    % Generation des points
    % Pour eviter une valeur dupliquée, nous générons un point de plus, qui
    % sera supprimé
    P1 = round(logspace(StartNorm, InfNorm, Nfar + 1));
    P2 = round(logspace(InfNorm, Inf2Norm, Ndecade + 1));
    P3 = round(logspace(Inf2Norm, Sup2Norm, Ncentrale + 1));
    P4 = round(logspace(Sup2Norm, SupNorm, Ndecade + 1));
    P5 = round(logspace(SupNorm, EndNorm, Nfar + 1));
    
    % Suppression des valeurs supplémentaires
    P1(end) = [];
    P2(end) = [];
    P3(end) = [];
    P4(end) = [];
    P5(end) = [];
    
    % Mise sous une seule liste
    Points = [P1 P2 P3 P4 P5];
    
    % Nettoyage des valeurs inutiles
    clear P1 P2 P3 P4 P5 StartNorm EndNorm InfNorm SupNorm Inf2Norm Sup2Norm Ncentrale Ndecade Nfar;
end