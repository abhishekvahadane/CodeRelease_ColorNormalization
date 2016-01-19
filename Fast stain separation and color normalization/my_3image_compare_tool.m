function my_3image_compare_tool(left_image, middle_image, right_image)

% Create the figure
hFig = figure('Toolbar','none',...
              'Menubar','none',...
              'Name','My Image Compare Tool',...
              'NumberTitle','off',...
              'IntegerHandle','off');
          
% Display left image              
subplot(131)  
hImL = imshow(left_image,[]);

% Display middle image
subplot(132)
hImM = imshow(middle_image,[]);

% Display right image
subplot(133)
hImR = imshow(right_image,[]);

% Create a scroll panel for left image
hSpL = imscrollpanel(hFig,hImL);
 set(hSpL,'Units','normalized',...
     'Position',[0 0.1 1/3 0.9])

% Create scroll panel for middle image
hSpM = imscrollpanel(hFig,hImM);
 set(hSpM,'Units','normalized',...
     'Position',[1/3 0.1 1/3 0.9])

% Create scroll panel for righ image
hSpR = imscrollpanel(hFig,hImR);
 set(hSpR,'Units','normalized',...
     'Position',[2/3 0.1 1/3 0.9])
 
% Add a Magnification box 
hMagBox = immagbox(hFig,hImL);
pos = get(hMagBox,'Position');
set(hMagBox,'Position',[0 0 pos(3) pos(4)])

%% Add an Overview tool
imoverview(hImL) 

%% Get APIs from the scroll panels 
apiL = iptgetapi(hSpL);
apiM = iptgetapi(hSpM);
apiR = iptgetapi(hSpR);

%% Synchronize left middle and right scroll panels
apiL.setMagnification(apiM.getMagnification())
apiL.setVisibleLocation(apiM.getVisibleLocation())
apiM.setMagnification(apiR.getMagnification())
apiM.setVisibleLocation(apiR.getVisibleLocation())

% When magnification changes on left scroll panel, 
% tell middle and right scroll panel
apiL.addNewMagnificationCallback(apiM.setMagnification);
apiL.addNewMagnificationCallback(apiR.setMagnification);

% When magnification changes on middle scroll panel, 
% tell left and right scroll panel
apiM.addNewMagnificationCallback(apiL.setMagnification);
apiM.addNewMagnificationCallback(apiR.setMagnification);

% When magnification changes on right scroll panel, 
% tell left and middle scroll panel
apiR.addNewMagnificationCallback(apiL.setMagnification);
apiR.addNewMagnificationCallback(apiM.setMagnification);

% When location changes on left scroll panel, 
% tell middle and right scroll panel
apiL.addNewLocationCallback(apiM.setVisibleLocation);
apiL.addNewLocationCallback(apiR.setVisibleLocation);

% When location changes on middle scroll panel, 
% tell left and right scroll panel
apiM.addNewLocationCallback(apiL.setVisibleLocation);
apiM.addNewLocationCallback(apiR.setVisibleLocation);

% When location changes on right scroll panel, 
% tell left and middle scroll panel
apiR.addNewLocationCallback(apiL.setVisibleLocation);
apiR.addNewLocationCallback(apiM.setVisibleLocation);

