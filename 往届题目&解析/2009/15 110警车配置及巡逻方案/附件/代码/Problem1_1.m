for u=1:1350
    for v=1:1350
        for w=1:1350
            if (newlagroad2(v,u)+newlagroad2(u,w))<newlagroad2(v,w)
                newlagroad2(v,w)=newlagroad2(v,u)+newlagroad2(u,w);
            end
        end
    end
    u
end