function new=rename(name)
    new='';
    i=1;
    while(name(i)~='.')
        new=strcat(new,name(i));
        i=i+1;
    end
    new=strcat(new,'.mat');
end