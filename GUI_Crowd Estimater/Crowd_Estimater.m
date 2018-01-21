function varargout = Crowd_Estimater(varargin)
% CROWD_ESTIMATER MATLAB code for Crowd_Estimater.fig
%      CROWD_ESTIMATER, by itself, creates a new CROWD_ESTIMATER or raises the existing
%      singleton*.
%
%      H = CROWD_ESTIMATER returns the handle to a new CROWD_ESTIMATER or the handle to
%      the existing singleton*.
%
%      CROWD_ESTIMATER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROWD_ESTIMATER.M with the given input arguments.
%
%      CROWD_ESTIMATER('Property','Value',...) creates a new CROWD_ESTIMATER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Crowd_Estimater_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Crowd_Estimater_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Crowd_Estimater

% Last Modified by GUIDE v2.5 04-Mar-2017 18:45:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Crowd_Estimater_OpeningFcn, ...
                   'gui_OutputFcn',  @Crowd_Estimater_OutputFcn, ...
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


% --- Executes just before Crowd_Estimater is made visible.
function Crowd_Estimater_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Crowd_Estimater (see VARARGIN)

% Choose default command line output for Crowd_Estimater
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Crowd_Estimater wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Crowd_Estimater_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2
[path,user_cance]=imgetfile();
if user_cance
msgbox(sprintf('Error'),'Error','Error');
return
end
im=imread(path);
im=im2double(im);
im2 = im;
axes(handles.axes1);
imshow(im);

% --- Executes on button press in lab.
function lab_Callback(hObject, eventdata, handles)
% hObject    handle to lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im3
imlab = im;
cform = makecform('srgb2lab');
imlab = applycform(im,cform);
axes(handles.axes1);
imshow(imlab);
im3 = imlab;


% --- Executes on button press in equalize.
function equalize_Callback(hObject, eventdata, handles)
% hObject    handle to equalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im3 im4
imequal = im3;
K=imequal(:,:,2);
axes(handles.axes1);
imshow(imequal);



function th_Callback(hObject, eventdata, handles)
% hObject    handle to th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th as text
%        str2double(get(hObject,'String')) returns contents of th as a double


% --- Executes during object creation, after setting all properties.
function th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bnw.
function bnw_Callback(hObject, eventdata, handles)
% hObject    handle to bnw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fill.
function fill_Callback(hObject, eventdata, handles)
% hObject    handle to fill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in box.
function box_Callback(hObject, eventdata, handles)
% hObject    handle to box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
