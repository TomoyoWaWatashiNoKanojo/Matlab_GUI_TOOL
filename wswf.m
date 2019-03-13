function wswf(src,cbd)
    global I;
    if I.Model==1
        cp=get(gca,'CurrentPoint'); 
        if cbd.VerticalScrollCount > 0
            k=1.15; 
        else
            k=0.85; 
        end
        axis(k*axis+(1-k)*cp([1,1,3,3]))
    end
end
