function wbdf(src,cbd) 
    global I
    if I.Model==-1
        return;
    end
        cp=get(gca,'CurrentPoint'); 
        set(src,'Pointer','crosshair') 
        
        set(gcf,'WindowButtonUpFcn',@wbuf)
        function wbuf(src,cbd) 
            cp=cp-get(gca,'CurrentPoint'); 
            xlim(xlim+cp(1));
            ylim(ylim+cp(3));
            set(gcf,'WindowButtonUpFcn','')
            set(src,'Pointer','arrow')
        end
end