function makePlotNicer(specStruct)
%makePlotNicer Set a variety of parameters to improve the appearance of a
%plot within an Axes object
%   makePlotNicer(specStruct) modifies the parameters indicated in the
%   input structure. The allowed parameters are:
%   - 'targetAxes' (Axes object)
%   - 'position' (vector indicating Axes position)
%   - 'txtTitle' (string indicating Axes title)
%   - 'txtXlabel' (string indicating x-axis label)
%   - 'txtYlabel' (string indicating y-axis label)
%   - 'txtZlabel' (string indicating z-axis label)
%   - 'legendArray' (cell array with legend labels)
%   - 'lineHandleVector' (vector of line handles corresponding to legend
%   labels)
%   - 'legendLocation' (vector indicating legend position)
%   - 'xGrid' (logical indicating whether the x-grid should be formatted)
%   - 'yGrid' (logical indicating whether the y-grid should be formatted)
%   - 'zGrid' (logical indicating whether the z-grid should be formatted)
%   - 'xlim' (vector indicating the limits of the x-axis)
%   - 'ylim' (vector indicating the limits of the y-axis)
%   - 'zlim' (vector indicating the limits of the z-axis)
%   - 'xTick' (vector indicating the x-axis tick values)
%   - 'yTick' (vector indicating the y-axis tick values)
%   - 'zTick' (vector indicating the z-axis tick values)

%% If no argument is provided as input generate an empty structure
if nargin==0
    specStruct = struct;
end

%% If no target axes is specified then use current axes
if ~isfield(specStruct,'targetAxes')
    specStruct.targetAxes = gca;
end

%% Set axes position if specified
if isfield(specStruct,'position')
    set(specStruct.targetAxes,'Position',specStruct.position)
end

%% Parameters
axisLineWidth = 1;
fontSize = 28;
lineWidth = 2.5;
markerSize = 12;

%% Set line width and marker size for line objects
lineHandleArray = findobj(specStruct.targetAxes,'Type','line');
set(lineHandleArray,...
    'LineWidth',lineWidth,...
    'MarkerSize',markerSize)

%% Set marker size for scatter objects
scatterHandleArray = findobj(specStruct.targetAxes,'Type','scatter');
set(scatterHandleArray,'LineWidth',lineWidth,'SizeData',markerSize^2)

%% Set line width and marker size for line objects
errorbarHandleArray = findobj(specStruct.targetAxes,'Type','ErrorBar');
set(errorbarHandleArray,...
    'LineWidth',1,...
    'Marker','o',...
    'MarkerSize',markerSize/2,...
    'CapSize',markerSize/2*1.5)
for i = 1:length(errorbarHandleArray)
    set(errorbarHandleArray(i),...
        'MarkerEdgeColor',get(errorbarHandleArray(i),'Color')*0.7,...
        'MarkerFaceColor',get(errorbarHandleArray(i),'Color'))
end

%% Set text propperties
textHandleArray = findobj(specStruct.targetAxes,'Type','text');
if ~isempty(textHandleArray)
    set(textHandleArray,...
        'FontName','AvantGarde',...
        'FontSize',fontSize);
end

%% Set textbox propperties
% Get the handle of the hidden annotation axes
hAnnotAxes = findall(gcf,'Tag','scribeOverlay');
% Get its children handles
if ~isempty(hAnnotAxes)
    hAnnotChildren = get(hAnnotAxes,'Children');
    for hAnnot = hAnnotChildren'
        if isprop(hAnnot,'FontSize')
            hAnnot.FontSize = fontSize;
        end
    end
end

%% Set title
if isfield(specStruct,'txtTitle')
    hTitle  = title(specStruct.targetAxes,specStruct.txtTitle);
    set(hTitle,...
        'FontName','AvantGarde',...
        'FontSize',fontSize+2,...
        'FontWeight','bold',...
        'Interpreter','latex');
end

%% Set xlabel
if isfield(specStruct,'txtXlabel')
    hXLabel = xlabel(specStruct.targetAxes,specStruct.txtXlabel);
    set(hXLabel,...
        'FontName','AvantGarde',...
        'FontSize',fontSize,...
        'Interpreter','latex');
end

%% Set ylabel
if isfield(specStruct,'txtYlabel')
    hYLabel = ylabel(specStruct.targetAxes,specStruct.txtYlabel);
    set(hYLabel,...
        'FontName','AvantGarde',...
        'FontSize',fontSize,...
        'Interpreter','latex');
end

%% Set zlabel
if isfield(specStruct,'txtZlabel')
    hZLabel = zlabel(specStruct.targetAxes,specStruct.txtZlabel);
    set(hZLabel,...
        'FontName','AvantGarde',...
        'FontSize',fontSize,...
        'Interpreter','latex');
end

%% Set legend
if isfield(specStruct,'legendArray')
    if ischar(specStruct.legendArray)
        specStruct.legendArray = {specStruct.legendArray};
    end
    if isfield(specStruct,'lineHandleVector')
        % Set legend corresponding to indicated lines if indicated
        if isfield(specStruct,'legendLocation')
            % Set legend location if specified
            legend(specStruct.targetAxes,...
                specStruct.lineHandleVector,specStruct.legendArray{:},...
                'Interpreter','latex',...
                'Location',specStruct.legendLocation,...
                'FontSize',fontSize-2);
        else
            legend(specStruct.targetAxes,...
                specStruct.lineHandleVector,specStruct.legendArray{:},...
                'Interpreter','latex',...
                'FontSize',fontSize-2);
        end
    else
        if isfield(specStruct,'legendLocation')
            % Set legend location if specified
            legend(...
                specStruct.targetAxes,specStruct.legendArray{:},...
                'Interpreter','latex',...
                'Location',specStruct.legendLocation,...
                'FontSize',fontSize-2);
        else
            legend(...
                specStruct.targetAxes,specStruct.legendArray{:},...
                'Interpreter','latex',...
                'FontSize',fontSize-2);
        end
    end
end

%% Set x and y grid
if ~isfield(specStruct,'xGrid') || specStruct.xGrid
    set(specStruct.targetAxes,...
        'Xgrid','on',...
        'XMinorGrid','on')
end
if ~isfield(specStruct,'yGrid') || specStruct.yGrid
    set(specStruct.targetAxes,...
        'Ygrid','on',...
        'YMinorGrid','on')
end
if (~isfield(specStruct,'zGrid') || specStruct.zGrid) &&...
        isprop(specStruct.targetAxes,'Zgrid')
    set(specStruct.targetAxes,...
        'Zgrid','on',...
        'ZMinorGrid','on')
end

%% Axis limits
if isfield(specStruct,'xlim')
    set(specStruct.targetAxes,'XLim',specStruct.xlim);
end
if isfield(specStruct,'ylim')
    set(specStruct.targetAxes,'YLim',specStruct.ylim);
end
if isfield(specStruct,'zlim')
    set(specStruct.targetAxes,'ZLim',specStruct.zlim);
end

%% Axis ticks
if isfield(specStruct,'xTick')
    set(specStruct.targetAxes,'XTick',specStruct.xTick)
else
    set(specStruct.targetAxes,'XMinorTick','on')
end
if isfield(specStruct,'yTick')
    set(specStruct.targetAxes,'YTick',specStruct.yTick)
else
    set(specStruct.targetAxes,'YMinorTick','on')
end
if isfield(specStruct,'zTick')
    set(specStruct.targetAxes,'ZTick',specStruct.zTick)
else
    set(specStruct.targetAxes,'ZMinorTick','on')
end

%% Other settings
set(specStruct.targetAxes,...
    'FontName','Helvetica',...
    'FontSize',fontSize);
set(specStruct.targetAxes,...
    'Box','off',...
    'TickDir','out',...
    'TickLength',[.02 .02],...
    'XColor',[.3 .3 .3],...
    'LineWidth',axisLineWidth);
% Set right-y axis if present
if ~strcmp(specStruct.targetAxes.YAxisLocation,'right')
    set(specStruct.targetAxes,'YColor',[.3 .3 .3]);
end
% Set z grid if z-axis present
if isprop(specStruct.targetAxes,'ZMinorTick')
    set(specStruct.targetAxes,...
        'ZMinorTick','on',...
        'ZColor',[.3 .3 .3])
end

%% Set colorbar properties
cObject = findall(gcf,'type','ColorBar');
if ~isempty(cObject)
    set(cObject,'Color',[.3 .3 .3])
    set(cObject.Label,...
        'FontName','AvantGarde',...
        'FontSize',fontSize,...
        'Interpreter','latex',...
        'Color',[.3 .3 .3])
end
end
