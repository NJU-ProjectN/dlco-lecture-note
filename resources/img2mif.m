function [] = img2mif()
    function [] = processor(imgfile, outfile, mysize)

        img=imread(imgfile);
        img=img(mysize(1):mysize(2),mysize(3):mysize(4),:);
        image(img);
        
        height = mysize(2)-mysize(1)+1;
        width = mysize(4)-mysize(3)+1;
        
        fprintf("height:%d; width:%d;\n", height, width);
        
        s = fopen(outfile,'wb');
        fprintf(s,'%s\n','--VGA Memory Map');
        fprintf(s,'---Height: %d,Width: %d\n\n',height,width);
        fprintf(s,'%s\n','WIDTH=12;');
        fprintf(s,'DEPTH=%d;\n',512*width);
        fprintf(s,'%s\n','ADDRESS_RADIX=HEX;');
        fprintf(s,'%s\n','DATA_RADIX=HEX;');
        
        fprintf(s,'%s\n','CONTENT');
        fprintf(s,'%s\n','BEGIN');
        cnt = 0;
        for r=1 :width
            for c=1:512
                cnt = cnt+1;
                if(c<=height)
                    R = img(c,r,1);
                    G = img(c,r,2);
                    B = img(c,r,3);
                else
                    R = 15;
                    G = 15;
                    B = 15;
                end
                fprintf(s,'%06X: %01X%01X%01X;\n',cnt-1,bitand(R,240)/16,bitand(G,240)/16,bitand(B,240)/16);
            end
        end
        fprintf(s,'%s\n','END;');
    
        fclose(s);
    end

    %processor("picture.png", "picture.mif", [106 585 201 840]);
    processor("picture1.png", "picture1.mif", [1 480 73 712]);

end



