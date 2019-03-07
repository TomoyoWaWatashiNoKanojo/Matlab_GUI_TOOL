function [x,y]=axis_transform(a)
    i=1;
    while(a(i)~=',')
        i=i+1;
    end
    e=size(a);
    e=e(2);
    x=str2num(a(1:i-1));
    y=str2num(a(i:e));
end