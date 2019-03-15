 function myCallback(hObject, eventdata, handles)
    global I;
    if I.Model==-1
        pt=get(gca,'CurrentPoint');
        x2=pt(1,1);
        y2=pt(1,2);
        %fprintf('x=%f,y=%f \n',x2,y2);
        x2=round(x2);
        y2=round(y2);
        try
            hold on
            hh=plot(x2,y2,'.r','Markersize',10);
            set(hh,'ButtonDownFcn',{@pointCallback,handles});
            handles.hh=hh;
            guidata(hObject,handles);
            I.msg_num_add(x2,y2,hh);
            str=I.get_now_points(I.len);
            set(handles.text3,'string',str);
            I.surrent_point=I.len;
            if I.chose_symbol~=0
                delete(I.chose_symbol);
            end
            I.chose_symbol=plot(I.x(I.len),I.y(I.len),'go','Markersize',8);
        catch
        end
    end
    set(gcf,'WindowScrollWheelFcn',@wswf);
    set(gcf,'WindowButtonDownFcn',@wbdf);
 end