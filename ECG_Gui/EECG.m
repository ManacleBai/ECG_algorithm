function varargout = EECG(varargin)
% EECG MATLAB code for EECG.fig
%      EECG, by itself, creates a new EECG or raises the existing
%      singleton*.
%
%      H = EECG returns the handle to a new EECG or the handle to
%      the existing singleton*.
%
%      EECG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EECG.M with the given input arguments.
%
%      EECG('Property','Value',...) creates a new EECG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EECG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EECG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EECG_OpeningFcn, ...
                   'gui_OutputFcn',  @EECG_OutputFcn, ...
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


% --- Executes just before EECG is made visible.
function EECG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EECG (see VARARGIN)

% Choose default command line output for EECG
global UD RL
UD=0;RL=0;
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%% �]�w�Ҧ�����������
set(handles.edit1,'Visible','off');
set(handles.pushbutton4,'Visible','off');
set(handles.pushbutton2,'Visible','off')
set(handles.slider1,'Visible','off')
set(handles.pushbutton5,'String','����');
set(handles.popupmenu1,'Visible','off');
set(handles.pushbutton2,'Visible','off');
set(handles.pushbutton1,'Visible','off')
    set(handles.pushbutton6,'Visible','off')
    
    set(handles.text2,'Visible','off')
%%
% global person
%  backgroundImage = importdata('C:\Users\TrenTronBioMed\Desktop\����\����T���B�z\ECG_word.png');
% person = importdata('C:\Users\User\Desktop\�����.jpg');
%  axes(handles.axes2);
%  image(backgroundImage);
%  axis off
%  axes(handles.axes1);
% image(person);





% UIWAIT makes EECG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EECG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fullpathname val heart person%�]�m��ӥ����ܼ�
set(handles.pushbutton2,'visible','off'); %�N���s2����
popup_sel_index=get(handles.popupmenu1,'Value');%�Nmenu1������ȶǦ^
value = val.audioarray ;%�N���c�}�C�̪�data���X
L = max(size(value));%��Xdata�V�q����
fs= L/10;T = 1/fs;t = (0:L-1)*T;%�]�w�򥻪������W�v�B�ɶ�����
NFFT = 2^nextpow2(L);%����V�q���ת�2^x
f = fs/2*linspace(0,1,NFFT/2);% �]�wFFT���᪺�C�I�������W�v��m
filterOrder=3;%�ҨϥΪ�FILTER�OBUTTER�A�ó]�m�Ҽ�5
stopBand=[58,63]; %58-63 hz �a�Z
[b, a]=butter(filterOrder, stopBand/(fs/2), 'stop');%��Xb�Fa
data=filtfilt(b,a,value(1,:)); %�o�������
Y=fft(data,NFFT);%�Ndata���ť߸��ഫ
[THR,SORH,KEEPAPP,CRIT] = ddencmp('cmp','wp',data);
toplotdata = data;
        for i=1:(L)
            if(toplotdata(i)<0.9) %�N�H�U���I�Ƴ]�m��0
                toplotdata(i)=0;
            end
        end
        heart=find(diff(sign(diff(toplotdata)))<0)+1;%��M���I����m
        axes(handles.axes1);
        axis off
switch popup_sel_index %meau���Ǧ^
    case 1 %�ɤJ�Ϥ�
        image(person);  
    case 2 %��Ϲ�
       plot(t,data);
    case 3 %�L���ᤧ���I��
        z=toplotdata(1,:);
        plot(t,toplotdata(1,:),t(heart),toplotdata(heart),'r*');
    case 4 %�Ҧb��m���I�Ʀ�m
        B=zeros(1,10);
        for j =1:length(heart)-1;
            B(j)=t((heart(j+1)))-t((heart(j)));
        end
        plot(B);
        hold on
        space=zeros(1,10);
        space(:)=sum(B)/10;
        plot(space);
        legend('RR���j','RR�������j');
        text(2,0.911,'\uparrow0.911');
    case 5 %�s�@�ʹ�
             for i=1:(length(t)/20)
             g=data(1:20*i);
             TT=t(1:20*i);
             plot(TT,g,'r-');
             hold on
             axis([0 10 -1 1]);
             var=get(handles.slider1,'Value')
             var=var/1000;
             pause(var)
             end
             end
  hold off %�C�Ӷ��q���M��


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global val  fullpathname %�]�w�����ܼ�
set(handles.edit1,'String',fullpathname); %�]�wedit����ܪ��r��
c=get(handles.edit1,'String')%���o�r��
val = load(c);%���J�ɮ�
set(handles.edit1,'Visible','off');%�N��
set(handles.pushbutton2,'Visible','off');
set(handles.pushbutton4,'Visible','off');



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(EECG) %�����Ҧ�EEG



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile('','please chose the file(only .m)');%���o�ɮצ�m
global fullpathname val %�]�w�����ܼ�
fullpathname = strcat(pathname, filename); %�N�ɮצ�m���ɮצW�٦X�� 
set(handles.edit1,'String',fullpathname);%�]�wedit��ܦr�鬰fullpathname


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global person
number=get(handles.pushbutton5,'String');
if number=='����'
    set(handles.edit1,'Visible','on');
    set(handles.pushbutton4,'Visible','on');
    set(handles.pushbutton2,'Visible','on')
    set(handles.slider1,'Visible','on');
    set(handles.edit2,'Visible','off');
    set(handles.popupmenu1,'Visible','on')
    set(handles.pushbutton2,'Visible','on');
    set(handles.pushbutton1,'Visible','on');
    set(handles.pushbutton6,'Visible','on');
    set(handles.pushbutton5,'String','����');
    axes(handles.axes1);
     cla reset

else
    set(handles.edit1,'Visible','off');
    set(handles.pushbutton4,'Visible','off');
    set(handles.pushbutton2,'Visible','off')
    set(handles.pushbutton1,'Visible','off');
    set(handles.pushbutton6,'Visible','off')
    set(handles.slider1,'Visible','off')
    set(handles.text2,'Visible','off')
    set(handles.edit2,'Visible','on');
    set(handles.pushbutton2,'Visible','off');
    set(handles.pushbutton5,'String','����');
    set(handles.popupmenu1,'Visible','off')
%handles:�y�`
axes(handles.axes1);
cla reset
axes(handles.axes1);
image(person);

end
    
    



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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global heart
minheart=length(heart)*6;
set(handles.text2,'String',minheart);
set(handles.text2,'Visible','on');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global person UD RL
axes(handles.axes1);
cla reset
axes(handles.axes1);
d=importdata('C:\Users\User\Desktop\�Ϥ�1.png');
floower=d.cdata;
x2=imresize(floower,1/2);
x2=imresize(x2,1/2);
newphoto=person;
for i=1:125
    for j=1:125
        if x2(i,j,:)==129
        else
           newphoto(i+UD,j+RL,:)=x2(i,j,:);
        end
    end
end
h=image(newphoto);
set(handles.pushbutton8,'Value',0);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)global UD person
global UD person RL
state=get(handles.pushbutton9,'Value');
if state==1
    UD=UD-50;
else
end
axes(handles.axes1);
cla reset
axes(handles.axes1);
d=importdata('C:\Users\User\Desktop\�Ϥ�1.png');
floower=d.cdata;
x2=imresize(floower,1/2);
x2=imresize(x2,1/2);
newphoto=person;
for i=1:125
    for j=1:125
        if x2(i,j,:)==129
        else
           newphoto(i+UD,j+RL,:)=x2(i,j,:);
        end
    end
end
h=image(newphoto);



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RL person UD
state=get(handles.pushbutton10,'Value');
if state==1
    RL=RL-50;
else
end
axes(handles.axes1);
cla reset
axes(handles.axes1);
d=importdata('C:\Users\User\Desktop\�Ϥ�1.png');
floower=d.cdata;
x2=imresize(floower,1/2);
x2=imresize(x2,1/2);
newphoto=person;
for i=1:125
    for j=1:125
        if x2(i,j,:)==129
        else
           newphoto(i+UD,j+RL,:)=x2(i,j,:);
        end
    end
end
h=image(newphoto);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global UD person RL
state=get(handles.pushbutton11,'Value');
if state==1
    UD=UD+50;
else
end
set(handles.pushbutton8,'Value',1);
axes(handles.axes1);
cla reset
axes(handles.axes1);
d=importdata('C:\Users\User\Desktop\�Ϥ�1.png');
floower=d.cdata;
x2=imresize(floower,1/2);
x2=imresize(x2,1/2);
newphoto=person;
for i=1:125
    for j=1:125
        if x2(i,j,:)==129
        else
           newphoto(i+UD,j+RL,:)=x2(i,j,:);
        end
    end
end
h=image(newphoto);
set(handles.pushbutton8,'Value',0);
    
% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RL person UD
state=get(handles.pushbutton12,'Value');
if state==1
    RL=RL+50;
else
end
axes(handles.axes1);
cla reset
axes(handles.axes1);
d=importdata('C:\Users\User\Desktop\�Ϥ�1.png');
floower=d.cdata;
x2=imresize(floower,1/2);
x2=imresize(x2,1/2);
newphoto=person;
for i=1:125
    for j=1:125
        if x2(i,j,:)==129
        else
           newphoto(i+UD,j+RL,:)=x2(i,j,:);
        end
    end
end
h=image(newphoto);
