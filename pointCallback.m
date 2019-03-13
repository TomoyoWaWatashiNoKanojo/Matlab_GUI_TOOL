function pointCallback(hObject, eventdata, handles)
    global I;
    pt=get(gca,'CurrentPoint');
    x2=pt(1,1);
    y2=pt(1,2);
    %fprintf('x=%f,y=%f \n',x2,y2);
    x2=round(x2);
    y2=round(y2);
    if I.chose_symbol~=0
            delete(I.chose_symbol);
    end
    
    flag=I.detect(x2,y2);
    I.surrent_point=flag;
    I.chose_symbol=plot(I.x(flag),I.y(flag),'go','Markersize',10);
    flag
    str=I.get_now_points(flag);
    set(handles.text3,'string',str);
end