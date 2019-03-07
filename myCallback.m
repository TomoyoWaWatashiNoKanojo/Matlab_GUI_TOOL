 function myCallback(hObject, eventdata, handles)
    str=get(handles.listbox1,'string');
    s=size(str);
    ss=s(1)+1;
    pt=get(gca,'CurrentPoint');
    x=pt(1,1);
    y=pt(1,2);
    fprintf('x=%f,y=%f \n',x,y);
    try
        x2=int2str(x);
        y2=int2str(y);
        new_item=strcat(x2,',');
        new_item=strcat(new_item,y2);
        str=strvcat(str,new_item);
        global points;
        hold on
        points(ss)=plot(x,y,'.r','Markersize',20);
    catch
    end
    set(handles.listbox1,'string',str);
 end