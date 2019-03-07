function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 28-Feb-2019 11:37:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global pathall;
pathall=0;


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
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
    clear global;
    hold off
    FileName=0;
    [FileName,PathName]=uigetfile( ...
    {'*.jpg;*.bmp;*.tif','Image Files(*.jpg,*.bmp,*.tif)';
    '*.jpg','*.jpg';
    '*.bmp','*.bmp';
    '*.tif','*.tif';
    '*.*','All Files(*.*)'},...
    'Select images','Multiselect','on');   
    if isequal(FileName,0)  
        disp('User selected Cancel')  
    else
        try 
            global pathall;
            global imag
            pathall=strcat(PathName,FileName);
            n=rename(pathall);
            img=imread(pathall);
            is_exist=exist(n,'file');
            if is_exist~=0
                load(n);
                img=original_img;
                imag=original_img;
                pathall=1;
            end
            axes(handles.axes1);
            shooow=imshow(img);
        catch ErrorInfo
            disp(ErrorInfo);
            h=warndlg(ErrorInfo.message,'Warning');
        end
        if FileName~=0
            set(handles.listbox1,'String','');
        end
        set(shooow,'ButtonDownFcn',{@myCallback,handles});
        handles.shooow=shooow;
        guidata(hObject,handles);
        if is_exist~=0
            global points;
            se=size(poinnnt);
            se=se(1);
            for i=1:se
                axis=poinnnt(i,:);
                [x,y]=axis_transform(axis);
                hold on
                points(i)=plot(x,y,'.r','Markersize',20);
                str=get(handles.listbox1,'string');
                x2=int2str(x);
                y2=int2str(y);
                new_item=strcat(x2,',');
                new_item=strcat(new_item,y2);
                str=strvcat(str,new_item);
                set(handles.listbox1,'String',str,'Value',1);
            end
        end
    end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
    string = get(handles.listbox1, 'String');
    ze=size(string);
    if ze~=0
        value=get(handles.listbox1,'value');
        str=get(handles.listbox1,'string');
        global points;
        se=size(str);
        se=se(1);
        for i=1:se
            axis=str(i,:);
            [x,y]=axis_transform(axis);
            hold on
            delete(points(i));
            points(i)=plot(x,y,'.r','Markersize',20);
        end
        axis=str(value,:);
        [x,y]=axis_transform(axis);
        hold on
        delete(points(value));
        points(value)=plot(x,y,'.g','Markersize',20);
    end
    


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    value = get(handles.listbox1, 'Value');
    string = get(handles.listbox1, 'String');
    ze=size(string);
    if ze~=0
        string(value,:)=[];
        global points;
        delete(points(value));
        clear points(value);
        points(value)=[];
    
        if value>1
            set(handles.listbox1,'String',string,'Value',value-1);
        else
            set(handles.listbox1,'String',string,'Value',1);
        end
    else
        warndlg('No points in list!','Warning');
    end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    zoom out ;
    new_imagee=getframe(handles.axes1);
    [filename,pathname,fileindex]=uiputfile({'*.png';'*.bmp';'*.jpg';},'Save as');
    if  filename~=0
        file=strcat(pathname,filename);
        switch fileindex     
            case 1
                imwrite(new_imagee.cdata,file,'png')
            case 2
                imwrite(new_imagee.cdata,file,'bmp')
            case 3
                imwrite(new_imagee.cdata,file,'jpg')
        end
        mat_name=rename(filename);
        global points;
        global pathall;
        if pathall~=1 & pathall~=0
            original_img=imread(pathall);
            pathall
        end
        poinnnt=get(handles.listbox1,'String');
        is_exist=exist(mat_name,'file');
        if pathall==1
            global imag
            original_img=imag;
            delete(mat_name);
        end
        save(mat_name,'poinnnt','original_img');
        msgbox('Save successfully£¡','Finished£¡');
    end


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


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global pathall;
    if pathall~=0
        zoom on;
    end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global pathall;
    if pathall~=0
        zoom off;
    end



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
