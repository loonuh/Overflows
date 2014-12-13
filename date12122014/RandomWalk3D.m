
clear all
close all
errorNum = 0
walkers = 100
L = 251;
oceanMat = zeros([L,L,L]);
for N = 1:walkers
    iterations = 1000;  
    %arrW = zeros([walkers,iterations]);
    %r = zeros([walkers,iterations]);
    close all
    clearvars -except N errorNum r arrW iterations walkers posHistMat oceanMat L
    ocean = zeros([L,L,L]);
    posInit = [126,126,126];
    pos = posInit;
    W = 1;
    arrW(N,1) = W;
    try
        for i = 1:iterations
            arrW(N,i) = W;
            r(N,i) = W/mean(arrW(N,:));
            if r(N,i) < 1
                break
            end
            ocean(pos(1),pos(2),pos(3)) = 1;
            posHist(i,:) = pos;
            posHistMat(N,i,:) = pos;
            %posHistMat
            [xcor,ycor,zcor,W] = posWalk(pos,ocean,W);
            pos = [xcor ycor zcor];
        end
        
        sum(arrW,2);
    catch e
        %e.message
        %e.stack
        errorNum = errorNum +1
    end
    
    
    oceanMat = oceanMat + ocean;
    %subplot(2,1,1)
    %plot(log10(r),'b.-');hold on
    %plot(zeros(length(r)),'r-')
    %subplot(2,1,2)
    %plot3(posHist(:,1),posHist(:,2),posHist(:,3),'.-')
    %fprintf('%f %f \n',[N errorNum])
end
Xdist = []
Ydist = []
Zdist = []
for i = 1:size(posHistMat,1)
    if any(posHistMat(i,:,end)==0)
        continue
    else
        Xdist = [Xdist posHistMat(i,:,1)];
        Ydist = [Ydist posHistMat(i,:,2)];
        Zdist = [Zdist posHistMat(i,:,3)];
        
        plot3(posHistMat(i,:,1),posHistMat(i,:,2),posHistMat(i,:,3),'.-');hold all
    end
end

%%
figure()
for j = 100:175
    pcolor(reshape(oceanMat(j,:,:),[251 251]));shading interp
    caxis([0 5]);colorbar
    drawnow
    j
    pause(.1)
end
