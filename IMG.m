classdef IMG < handle
    properties % these are the variables
        path=[];
        x;
        y;
        plot_handle;
        len;
        map;
        prev_point=0;
        surrent_point=0;
        chose_symbol=0;
        useless_data;
        Model=-1; %-1:draw 1:enlarge
    end
    methods % these are the functions
        function obj = IMG() % constructor
        end
        function obj = setInfo(obj, path)
            obj.path = path;
            obj.x=zeros();
            obj.y=zeros();
            obj.plot_handle=[];
            obj.len=0;
            im=dicomread(path);
            obj.path=im;
            [r,c]=size(im);
            map=zeros(r,c);
        end
        function msg_num_add(obj,x,y,h)
            obj.len=obj.len+1;
            obj.x(obj.len)=x;
            obj.y(obj.len)=y;
            obj.plot_handle(obj.len)=h;
            obj.map(x,y)=obj.len;
            obj.prev_point=obj.len;
        end
        function str=get_now_points(obj,p)
            str=[];
            x2=int2str(obj.x(p));
            y2=int2str(obj.y(p));
            new_item=strcat(x2,',');
            new_item=strcat(new_item,y2);
            str=strvcat(str,new_item);
        end
        function next=del_points(obj,p)
            obj.map(obj.x(p),obj.y(p))=0;
            for i=p+1:obj.len
                obj.map(obj.x(i),obj.y(i))=obj.map(obj.x(i),obj.y(i))-1;
                obj.x(i-1)=obj.x(i);
                obj.y(i-1)=obj.y(i);
            end
            delete(obj.plot_handle(p));
            clear obj.plot_handle(p);
            obj.plot_handle(p)=[];
            obj.len=obj.len-1;
            if(p==1)
                next=obj.len;
            else
                next=p-1;
            end
            obj.surrent_point=0;
            delete(obj.chose_symbol);
        end
        function del_highlight(obj)
            %delete(obj.chose_symbol);
            clear obj.chose_symbol;
            obj.chose_symbol=0;
            obj.surrent_point=0;
        end
        function image=save_img(obj)
            try
                warning off
                h1=figure(1);
                set(h1,'visible','off'); 
                imagesc(obj.path);
                set(h1,'visible','off'); 
                hold on;
                
                for i=1:obj.len
                    plot(obj.x(i),obj.y(i),'.r','Markersize',10);
                end
                image=getframe(h1);
            catch
            end
            warning on
        end
        function flag=detect(obj,x,y)
            [r,c]=size(obj.path);
            flag=0;
            d=sqrt(r*r+c*c)/100*1.4;
            for i=1:obj.len
                dx=abs(obj.x(i)-x);
                dy=abs(obj.y(i)-y);
                if(dy<d & dx<d)
                    flag=obj.map(obj.x(i),obj.y(i));
                end
            end
        end
    end
end