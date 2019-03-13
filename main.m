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

% Last Modified by GUIDE v2.5 12-Mar-2019 19:21:11

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
global I;
I=0;

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
        %handles.axes1
        try 
            hold off;
            global I;
            I=IMG;
            pathall=strcat(PathName,FileName);
            n=rename(pathall);
            is_exist=exist(n,'file')
            if is_exist~=0
                load(n);
                I=saved_I;
                axes(handles.axes1);
                shooow=imagesc(I.path);
                axis image
                hold on;
                for i=1:I.len
                    h=plot(I.x(i),I.y(i),'.r','Markersize',10);
                    set(h,'ButtonDownFcn',{@pointCallback,handles});
                    handles.h=h;
                    guidata(hObject,handles);
                    I.plot_handle(i)=h;
                end
                set(shooow,'ButtonDownFcn',{@myCallback,handles});
                handles.shooow=shooow;
                guidata(hObject,handles);
                I.Model=-1;
                set(handles.text5, 'string','Draw');
                return;
            end
            img=imread(pathall);
            axes(handles.axes1);
            shooow=image(img);
            axis image
            hold on;
            I.setInfo(pathall);
        catch ErrorInfo
            disp(ErrorInfo);
            h=warndlg(ErrorInfo.message,'Warning');
        end
        set(shooow,'ButtonDownFcn',{@myCallback,handles});
        handles.shooow=shooow;
        guidata(hObject,handles);
        I.Model=-1;
        set(handles.text5, 'string','Draw');
    end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global I;
    if(I.surrent_point~=0)
        flag=I.del_points(I.surrent_point);
        set(handles.text3,'string','current point');
    end
    


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global I;
    new_imagee=I.save_img();
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
        saved_I=I;
        saved_I.surrent_point=0;
        clear saved_I.chose_symbol;
        saved_I.chose_symbol=0;
        is_exist=exist(mat_name,'file');
        if is_exist==1
            delete(mat_name);
        end
        save(mat_name,'saved_I');
        msgbox('Save successfully£¡','Finished£¡');
    end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global I;
    if I~=0
        I.Model=I.Model*-1;
        if I.Model==-1
            set(handles.text5, 'string','Draw');
        else
            set(handles.text5, 'string','Enlarge');
        end
    end

% --- Executes on button press in pushbutton7.
