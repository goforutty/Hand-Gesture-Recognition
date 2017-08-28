function varargout = guitrain(varargin)
% GUITRAIN M-file for guitrain.fig
%      GUITRAIN, by itself, creates a new GUITRAIN or raises the existing
%      singleton*.
%
%      H = GUITRAIN returns the handle to a new GUITRAIN or the handle to
%      the existing singleton*.
%
%      GUITRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITRAIN.M with the given input arguments.
%
%      GUITRAIN('Property','Value',...) creates a new GUITRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guitrain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guitrain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guitrain

% Last Modified by GUIDE v2.5 14-Feb-2011 22:47:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guitrain_OpeningFcn, ...
                   'gui_OutputFcn',  @guitrain_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before guitrain is made visible.
function guitrain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guitrain (see VARARGIN)

% Choose default command line output for guitrain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guitrain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guitrain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbut

sss='Capturing Background';
set(handles.edit2,'String',sss);

vid=videoinput('winvideo',1,'YUY2_640x480'); 
set(vid,'ReturnedColorSpace','rgb');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
triggerconfig(vid,'manual'); 
%Capture one frame per trigger
set(vid,'FramesPerTrigger',1 );
set(vid,'TriggerRepeat', Inf);
start(vid); %start video

 BW = imread('mask.bmp');
 BW=im2bw(BW);
 [B,L,N,A] = bwboundaries(BW);
axes(handles.axes1);
 imshow(BW); hold on;
       for k=1:length(B),
         if(~sum(A(k,:)))
           boundary = B{k};
           axes(handles.axes1);
           plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
           for l=find(A(:,k))'
             boundary = B{l};
             axes(handles.axes1);
             save boundary boundary
             plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
           end
         end
       end
       
       
%        imshow(AA); hold on;
load boundary       
       
aa=1;
%Infinite while loop
load r;
load c;
% r=69:400;
% c=83:500;
while(1)
% preview(vid)
%Get Image
trigger(vid);
im=getdata(vid,1);
axes(handles.axes1);
imshow(im);
hold on
if aa == 5
    red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
 axes(handles.axes2);
 imshow(Out);
imwrite(Out,'bg.bmp');
sss='Capturing Gesture';
set(handles.edit2,'String',sss);
   
end

axes(handles.axes1);
plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
aa=aa+1;
set(handles.timer,'String',num2str(aa));
disp(aa);
if aa == 30
   break 
end


end

stop(vid),delete(vid),clear vid; 

red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
imwrite(Out,'final.bmp');
%figure, 
axes(handles.axes3);
imshow(Out,[])
clear Out;
        a=imread('bg.bmp');
a=imread('bg.bmp');
a=rgb2gray(a);
figure;
imshow(a);
b=imread('final.bmp');
b=rgb2gray(b);
c1=imsubtract(a,b);
d=im2bw(c1);
[r c]=size(d);

for i=1:r
    for j=1:c
        
        if c1(i,j)> 25
            Out(i,j)=255;
        else
            Out(i,j)=0;
            
        end
        
    end
end


% figure;
Out=medfilt2(Out,[3 3]);
% imshow(Out,[]);
[L num]=bwlabel(Out);
STATS = regionprops(L,'all');


removed=0;
for i=1:num
dd=STATS(i).Area;
if dd < 500
  	L(L==i)=0;
	removed = removed + 1;
    num=num-1;
else
% imshow(L==i);
end
    
    
end
    disp(num);
    [L num]=bwlabel(L);


STATS = regionprops(L,'all');
stats1 = regionprops(L, 'Image'); % get image features
C = [];
c = stats1(1);
C = [c.Image]; % sepreate diffrent objects into C cell array.
C1 = imresize(C, [256 256], 'bilinear'); %
axes(handles.axes4);
imshow(C1);
bb = get(handles.edit1,'String')
 imwrite(C1,bb);
 warndlg('Training sequence stored');


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timer_Callback(hObject, eventdata, handles)
% hObject    handle to timer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timer as text
%        str2double(get(hObject,'String')) returns contents of timer as a double


% --- Executes during object creation, after setting all properties.
function timer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
