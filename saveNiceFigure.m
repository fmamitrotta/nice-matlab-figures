function saveNiceFigure(nameArray,figHandleArray)
%saveNiceFigure Save figures giving a nice appearance
%   saveNiceFigure(nameArray,figHandleArray) saves the figures referred by
%   the Figure object array figHandleArray with the names given in cell
%   array nameArray. The function saves the figure in both the .fig Matlab
%   format and in .eps format. If the figure contains more than one tab,
%   each is saved individually into an .eps file.

% Check whether nameArray is a string
if ischar(nameArray)
    nameArray = {nameArray};
end
% Check number of input arguments
if nargin == 1
    % If figure handle is not provided then find all open figures
    figHandleArray = findobj('Type','figure');
end
% Iterate through figure handles
for f = 1:length(figHandleArray)
    % Set the figure background color to white
    set(figHandleArray(f),'color','w');
    % Get rid of the white space bordering the figure
    set(figHandleArray(f),'Units','normalized','Outerposition',[0,0,1,1]);
    % Set figure name
    set(figHandleArray(f),'NumberTitle','off','Name',nameArray{f});
    % Save figure nicely in pdf format
    filename = matlab.lang.makeValidName(nameArray{f});
    set(figHandleArray(f),'Units','Inches');
    pos = get(figHandleArray(f),'Position');
    set(figHandleArray(f),'PaperPositionMode','Auto',...
        'PaperUnits','Inches',...
        'PaperSize',[pos(3),pos(4)])
    % Save MATLAB figure
    savefig(figHandleArray(f),filename)
    % If tabs are present in the current figure then iterate through those
    if isa(figHandleArray(f).Children,'matlab.ui.container.TabGroup')
        for i = 1:length(figHandleArray(f).Children.Children)
            % Activate tab
            figHandleArray(f).Children.SelectedTab =...
                figHandleArray(f).Children.Children(i);
            % Make background white
            set(figHandleArray(f).Children.Children(i),...
                'BackgroundColor','w')
            % Save eps file appending tab name to filename
            print(figHandleArray(f),[filename,'_',...
                matlab.lang.makeValidName(...
                figHandleArray(f).Children.Children(i).Title)],...
                '-depsc','-r0')
            % Save png file appending tab name to filename
%             print(figHandleArray(f),[filename,'_',...
%                 matlab.lang.makeValidName(...
%                 figHandleArray(f).Children.Children(i).Title)],...
%                 '-dpng','-r0')
        end
    else
        % Save eps file
        print(figHandleArray(f),filename,'-depsc','-r0')
        % Save tiff file
%         print(figHandleArray(f),filename,'-dtiff','-r0')
        % Save png file
%         print(figHandleArray(f),filename,'-dpng','-r0')
    end
end
end
