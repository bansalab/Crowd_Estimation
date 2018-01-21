function varargout = cestimator_1(varargin)
% CESTIMATOR_1 MATLAB code for cestimator_1.fig
%      CESTIMATOR_1, by itself, creates a new CESTIMATOR_1 or raises the existing
%      singleton*.
%
%      H = CESTIMATOR_1 returns the handle to a new CESTIMATOR_1 or the handle to
%      the existing singleton*.
%
%      CESTIMATOR_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CESTIMATOR_1.M with the given input arguments.
%
%      CESTIMATOR_1('Property','Value',...) creates a new CESTIMATOR_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cestimator_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cestimator_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cestimator_1

% Last Modified by GUIDE v2.5 18-Apr-2017 00:03:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cestimator_1_OpeningFcn, ...
                   'gui_OutputFcn',  @cestimator_1_OutputFcn, ...
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


% --- Executes just before cestimator_1 is made visible.
function cestimator_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cestimator_1 (see VARARGIN)

global headcount;
global im;
global im2;
global im3;
global im4;
global threshold;
threshold = 200;
im = 0;
im2 = 0;
im3 = 0;
im4 = 0;
headcount = 0;

% Choose default command line output for cestimator_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cestimator_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cestimator_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
im = imread('delhi_metro.jpg');
imshow(im);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global headcount;
global im;
global im2;
global threshold;
%im = imread('delhi_metro.jpg');
cform = makecform('srgb2lab');
im2=applycform(im,cform);
%axes(handles.axes2)
imshow(im2);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2;
K=im2(:,:,3);
%axes(handles.axes2)
imshow(K);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2;
global im3;
grayth=graythresh(im2(:,:,2));
im3=im2bw(im2(:,:,2),grayth);
imshow(im3);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im3;
global im4;
im4=imfill(im3,'holes');
%axes(handles.axes2)
imshow(im4);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im4;
global im;
global headcount;
global threshold;
s = size(im4);
im51 = bwareaopen(im4,round(0.5*threshold));
im52 = bwareaopen(im4,threshold);
im53 = bwareaopen(im4,round(0.7*threshold));
im5 = zeros(s(1),s(2));
for i = 1:1:200
    for j = 1:1:s(2)
        im5(i,j) = im51(i,j);
    end
end
for i = 201:1:s(1)
    for j = 1:1:30
        im5(i,j) = im53(i,j);
    end
end
for i = 201:1:s(1)
    for j = 690:1:s(2)
        im5(i,j) = im53(i,j);
    end
end
for i = 201:1:s(1)
    for j = 31:1:689
        im5(i,j) = im52(i,j);
    end
end

cc=bwconncomp(im5);
density = cc.NumObjects / (size(im5,1) * size(im5,2))
%axes(handles.axes2)
imshow(im5);
labeledImage = bwlabel(im5, 8);
blobMeasurements = regionprops(labeledImage,'all');
headcount = size(blobMeasurements, 1);
%axes(handles.axes3)
imagesc(im);
hold on;
%set(handles.text1,'string','Final BnW Generated Image');
%title('Original with bounding boxes');
for k = 1 : headcount
Box = blobMeasurements(k).BoundingBox; 
x1 = Box(1);
y1 = Box(2);
x2 = x1 + Box(3);
y2 = y1 + Box(4);
x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
plot(x, y, 'LineWidth', 2);
end
set(handles.text2,'string',headcount);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global threshold;
%global headcount;
th = get(handles.slider1,'value');
threshold = round(th*100);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
