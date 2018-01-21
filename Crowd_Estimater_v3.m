function varargout = Crowd_Estimater_v3(varargin)
% CROWD_ESTIMATER_V3 MATLAB code for Crowd_Estimater_v3.fig
%      CROWD_ESTIMATER_V3, by itself, creates a new CROWD_ESTIMATER_V3 or raises the existing
%      singleton*.
%
%      H = CROWD_ESTIMATER_V3 returns the handle to a new CROWD_ESTIMATER_V3 or the handle to
%      the existing singleton*.
%
%      CROWD_ESTIMATER_V3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROWD_ESTIMATER_V3.M with the given input arguments.
%
%      CROWD_ESTIMATER_V3('Property','Value',...) creates a new CROWD_ESTIMATER_V3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Crowd_Estimater_v3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Crowd_Estimater_v3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Crowd_Estimater_v3

% Last Modified by GUIDE v2.5 04-Mar-2017 17:00:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Crowd_Estimater_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @Crowd_Estimater_v3_OutputFcn, ...
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


% --- Executes just before Crowd_Estimater_v3 is made visible.
function Crowd_Estimater_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Crowd_Estimater_v3 (see VARARGIN)

% Choose default command line output for Crowd_Estimater_v3
handles.output = hObject;

% Update handles structure
im = imread('C:/Users/Aakash/Desktop/test.jpg');
im=im2double(im); %converts to double
imgray=(im(:,:,1)+im(:,:,2)+im(:,:,2))/3;
handles.imgray=imgray;
hy=fspecial('sobel');
hx=hy;
Iy=imfilter(double(imgray),hy,'replicate');
Ix=imfilter(double(imgray),hx,'replicate');
imgradmag=sqrt(Ix.^2+Iy.^2);
handles.imgradmag=imgradmag;
se=strel('disk',20);
Ie=imerode(imgray,se);
handles.Ie=Ie;
Iobr=imreconstruct(Ie,imgray);
handles.Iobr=Iobr;
edgeim=edge(Iobr,'canny',[0.15 0.2]);
handles.edgeim=edgeim;
[centers,radii]=imfindcircles(edgeim,[5 10],'sensitivity',0.92,'Edge',0.03);
handles.radii=radii;
h=length(centers);
handles.h=h;
Total=ones(240,320);
%HDText=insertText(Total,[205 55],h,'AnchorPoint','LeftCenter');
%handles.HDText=HDText;

guidata(hObject, handles);

% UIWAIT makes Crowd_Estimater_v3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Crowd_Estimater_v3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[path,user_cance]=imgetfile();
if user_cance
msgbox(sprintf('Error'),'Error','Error');
return
end
handles.im=imread(path);
global im;
im = handle.im;
axes(handles.axes1);
imshow(handles.im);


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
hold off;
cla reset;
set(handles.axes1,'xtick',[],'ytick',[]);
axes(handles.axes2);
hold off;
cla reset;
set(handles.axes2,'xtick',[],'ytick',[]);
axes(handles.axes3);
hold off;
cla reset;
set(handles.axes3,'xtick',[],'ytick',[]);
axes(handles.axes4);
hold off;
cla reset;
set(handles.axes4,'xtick',[],'ytick',[]);
axes(handles.axes5);
hold off;
cla reset;
set(handles.axes5,'xtick',[],'ytick',[]);


% --- Executes on button press in customize.
function customize_Callback(hObject, eventdata, handles)
% hObject    handle to customize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=get(handles.option,'Value');
if v==2
axes(handles.axes1);
imshow(handles.imgradmag);
elseif v==3
axes(handles.axes2);
imshow(handles.Ie);
elseif v==4
axes(handles.axes3);
imshow(handles.Iobr);
elseif v==5
axes(handles.axes4);
imshow(handles.edgeim);
elseif v==6
[centers,handles.radii]=imfindcircles(handles.edgeim,[5 10],'sensitivity',0.92,'Edge',0.03);
viscircles(centers,handles.radii,'EdgeColor','b');
axes(handles.axes4);
imshow(handles.edgeim);
end


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on selection change in option.
function option_Callback(hObject, eventdata, handles)
% hObject    handle to option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns option contents as cell array
%        contents{get(hObject,'Value')} returns selected item from option
contents=get(hObject,'Value');
switch contents
case 1
handles.imgray=(im(:,:,1)+im(:,:,2)+im(:,:,2))/3;
axes(handles.axes2);
imshow(handles.imgray);
handles.hy=fspecial('sobel');
handles.hx=handles.hy;
handles.Iy=imfilter(double(handles.imgray),handles.hy,'replicate');
handles.Ix=imfilter(double(handles.imgray),handles.hx,'replicate');
handles.imgradmag=sqrt(handles.Ix.^2+handles.Iy.^2);
axes(handles.axes5);
imshow(handles.imgradmag);
handles.se=strel('disk',20);
handles.Ie=imerode(handles.imgray,handles.se);
handles.Iobr=imreconstruct(handles.Ie,handles.imgray);
axes(handles.axes3);
imshow(handles.Iobr);
handles.edgeim=edge(handles.Iobr,'canny',[0.15 0.2]);
axes(handles.axes5);
imshow(handles.edgeim);
handles.d=imdistline;
[centers,handles.radii]=imfindcircles(handles.edgeim,[5 10],'sensitivity',0.92,'Edge',0.03);
viscircles(centers,handles.radii,'EdgeColor','b');
axes(handles.axes4);
imshow(handles.edgeim);
handles.h=length(centers);
handles.Total=ones(240,320);
figure,imshow(handles.Total);
hold on
handles.HDText=insertText(handles.Total,[205 55],handles.h,'AnchorPoint','LeftCenter');
imshow(handles.HDText);
text(25,55,'TOTAL : ','FontSize',12,'FontWeight','bold','Color','m');
hold off
axes(handles.axes1);
imshow(handles.im);
case 2
handles.imgray=(im(:,:,1)+im(:,:,2)+im(:,:,2))/3;
axes(handles.axes2);
imshow(handles.imgray);
case 3
axes(handles.axes3);
imshow(handles.Iobr);
case 4
axes(handles.axes4);
imshow(handles.edgeim);
otherwise
end

% --- Executes during object creation, after setting all properties.
function option_CreateFcn(hObject, eventdata, handles)
% hObject    handle to option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in technique.
function technique_Callback(hObject, eventdata, handles)
% hObject    handle to technique (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns technique contents as cell array
%        contents{get(hObject,'Value')} returns selected item from technique


% --- Executes during object creation, after setting all properties.
function technique_CreateFcn(hObject, eventdata, handles)
% hObject    handle to technique (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
