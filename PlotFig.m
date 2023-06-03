function PlotFig(Q)
    xb = 10; % 山坡x方向宽度的一半
    yb = 220; % 山坡y方向长度
    e = 8; % 运动员放大的倍数
    lw = 2; % 线宽
    nts = size(Q,2);
%     kFig = 1:32:193; % 图的第kFig帧
    kFig = 1:2:193; % 图的第kFig帧
    Q(3,:) = e*Q(3,:);
    h1 = [1;0;0]; h2 = [0;1;0]; h3 = [0;0;1];
    l1 = e*0.206; l2 = e*0.478; l3 = e*0.355; l4 = e*0.478; l5 = e*0.355; l6 = e*0.710; % 各个刚体的长度
    l7 = e*0.309; l8 = e*0.229; l9 = e*0.309; l10 = e*0.229; l11 = e*0.229;
    a2 = -l2*h3/2; a3 = -l3*h3/2; a4 = -l4*h3/2; a5 = -l5*h3/2; a6 = l6*h3/2; a7 = -l7*h3/2; a8 = -l8*h3/2;
    a9 = -l9*h3/2; a10 = -l10*h3/2; a11 = l11*h3/2;
    b12 = l1*h1/2; b2 = a2*2; b14 = -l1*h1/2; b3 = a3*2; b4 = a4*2; b5 = a5*2; b6 = l6*h3; b67 = l6*h3+l1*h1/2; b69 = l6*h3-l1*h1/2;
    b7 = a7*2; b9 = a9*2; b8 = a8*2; b10 = a10*2; b11 = a11*2;
    sita = -20/180*pi;
    Rg = RxFunc(sita);
    % 山坡的定点
    Xb = [-xb xb xb -xb]; 
    Yb = [0 0 yb yb]; 
    Zb = zeros(1,4);
    B = Rg*[Xb;Yb;Zb];
    % 运动员脚的坐标
    c = Rg*[Q(1:2,:);zeros(1,nts)];
    n2 = 22; % 变量的个数
    j = 40;
    for k = kFig
        j = j+1;
        q = Q(1:n2,k);
        x = q(1); y = q(2); z = q(3);
        for i = 4:n2
            eval(['fai' num2str(i-3) '=q(i);'])
        end
        %% 刚体
        % 刚体1
        R1x = RxFunc(fai1); R1y = RyFunc(fai2); R1z = RzFunc(fai3);
        T1 = R1x*R1y*R1z;
        p1 = [x;y;z];
        p2 = p1+T1*b12;
        p4 = p1+T1*b14;
        % 刚体2
        R2x = RxFunc(fai4); R2y = RyFunc(fai5);
        A2 = R2x*R2y;
        T2 = T1*A2;
        p3 = p2+T2*b2;
        % 刚体3
        R3x = RxFunc(fai6);
        T3 = T2*R3x;
        p3e = p3+T3*b3;
        % 刚体4
        R4x = RxFunc(fai7); R4y = RyFunc(fai8);
        A4 = R4x*R4y;
        T4 = T1*A4;
        p5 = p4+T4*b4;
        % 刚体5
        R5x = RxFunc(fai9);
        T5 = T4*R5x;
        p5e = p5+T5*b5;
        % 刚体6
        R6x = RxFunc(fai10); R6y = RyFunc(fai11);
        A6 = R6x*R6y;
        T6 = T1*A6;
        p11 = p1+T6*b6;
        p7 = p1+T6*b67;
        p9 = p1+T6*b69;
        % 刚体7
        R7x = RxFunc(fai12); R7y = RyFunc(fai13);
        A7 = R7x*R7y;
        T7 = T6*A7;
        p8 = p7+T7*b7;
        % 刚体8
        R8x = RxFunc(fai14);
        T8 = T7*R8x;
        p8e = p8+T8*b8;
        % 刚体9
        R9x = RxFunc(fai15); R9y = RyFunc(fai16);
        A9 = R9x*R9y;
        T9 = T6*A9;
        p10 = p9+T9*b9;
        % 刚体10
        R10x = RxFunc(fai17);
        T10 = T9*R10x;
        p10e = p10+T10*b10;
        % 刚体11
        R11x = RxFunc(fai18); R11y = RyFunc(fai19);
        A11 = R11x*R11y;
        T11 = T6*A11;
        p11e = p11+T11*b11;
        %% 画图
        p = Rg*[p1 p2 p3 p3e p4 p5 p5e p7 p8 p8e p9 p10 p10e p11 p11e];
        pos1 = [1 2 3 4];
        pos2 = [1 5 6 7];
        pos3 = [1 14 15];
        pos4 = [14 8 9 10];
        pos5 = [14 11 12 13];
        figure('visible','On')
        hold on
        plot3(p(1,pos1),p(2,pos1),p(3,pos1),'k','LineWidth',lw)
        plot3(p(1,pos2),p(2,pos2),p(3,pos2),'k','LineWidth',lw)
        plot3(p(1,pos3),p(2,pos3),p(3,pos3),'k','LineWidth',lw)
        plot3(p(1,pos4),p(2,pos4),p(3,pos4),'k','LineWidth',lw)
        plot3(p(1,pos5),p(2,pos5),p(3,pos5),'k','LineWidth',lw)
        plot3(c(1,1:k),c(2,1:k),c(3,1:k),'r','LineWidth',lw/2)
        plot3([B(1,1) B(1,1) B(1,4)],[0 0 B(2,4)],[0 B(3,4) B(3,4)],'k')
        plot3([B(1,2) B(1,2) B(1,3)],[0 0 B(2,3)],[0 B(3,3) B(3,3)],'k')
        plot3([B(1,1) B(1,2)],[0 0],[B(3,4) B(3,3)],'k')
        fill3(B(1,:),B(2,:),B(3,:),[228 242 246]/255,'EdgeColor','k')
        fill3([B(1,1) B(1,1) B(1,4)],[0 0 B(2,4)],[0 B(3,4) B(3,4)],[228 242 246]/255,'EdgeColor','k')
        fill3([B(1,2) B(1,2) B(1,3)],[0 0 B(2,3)],[0 B(3,3) B(3,3)],[228 242 246]/255,'EdgeColor','k')
        axis equal
        axis([-xb-1 xb+1 -0.2 220 -76 15])
        xlabel('{\itx} (m)')
        ylabel('{\ity} (m)')
        zlabel('{\itz} (m)')
        set(gca,'FontSize',16,'Fontname','Times New Roman')
        view(146,12)
%         view(90,0) % yz视图
%         view(180,0) % xz视图
        pause(0.02)
        saveas(gcf,num2str(j),'tif')
    end
end

% 子函数
% R
function Rx = RxFunc(fai)
    Rx = [1 0 0; 0 cos(fai) -sin(fai); 0 sin(fai) cos(fai)];
end
function Ry = RyFunc(fai)
    Ry = [cos(fai) 0 sin(fai); 0 1 0; -sin(fai) 0 cos(fai)];
end
function Rz = RzFunc(fai)
    Rz = [cos(fai) -sin(fai) 0; sin(fai) cos(fai) 0; 0 0 1];
end
