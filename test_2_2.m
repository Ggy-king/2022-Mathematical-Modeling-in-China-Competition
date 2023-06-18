
%%  ��������
res = xlsread('Ǧ���Ƿ���.xlsx');

%%  ��������
num_class = 3;              % ���������Ŀ
Tag = 0;                    % ���ݼ����Ƿ������ǩ
Q  = size(res, 1);          % ������Ŀ

%%  �����������ǩ
if (Tag == 1)

    num_class = length(unique(res(:, end)));  % ���������Ŀ
    L_train = res(: , 1 : end - 1)';          % ��������
    R_train = res(: , end)';                  % ��ʵ��ǩ
else

    L_train = res';                           % ��������
end

%%  ���ݹ�һ��
[p_train, ps_input] = mapminmax(L_train, 0, 1);

%%  ��������
net = newsom(p_train, num_class);

%%  ����ѵ������
net.trainParam.epochs = 2000;   % ����������
net.trainParam.goal = 1e-5;     % Ŀ��ѵ�����
net.trainParam.lr = 0.01;       % ѧϰ��

%%  ѵ������
net = train(net, p_train);

%%  ����Ԥ��
t_sim1 = sim(net, p_train);

%%  ����һ��
T_sim1 = vec2ind(t_sim1);

%%  ���ɷַ��� -- ��ά
p_train = p_train';
[~, pc_train] =  pca(p_train);

%%  �ռ�Ԥ���ã��ж���������ö��ٸ���
idt1 = []; idt2 = []; 
idt3 = []; idt4 = []; 

%%  �������
for i = 1: Q

    % ����1
    if T_sim1(i) == 1
        idt1 = [idt1; pc_train(i, 1 : 2)];
    end
    
    % ����2
    if T_sim1(i) == 2
        idt2 = [idt2; pc_train(i, 1 : 2)];
    end
    
    % ����3
    if T_sim1(i) == 3
        idt3 = [idt3; pc_train(i, 1 : 2)];
    end


end

%%  ���ƾ������ɢ��ͼ
figure
plot(idt1(:, 1), idt1(:, 2), '*', 'LineWidth', 1)
hold on
plot(idt2(:, 1), idt2(:, 2), '*', 'LineWidth', 1)
hold on
plot(idt3(:, 1), idt3(:, 2), '*', 'LineWidth', 1)
hold on

%%  �ռ�Ԥ���ã��ж���������ö��ٸ���
idx1 = []; idx2 = []; 
idx3 = []; idx4 = [];

%%  ������ʵ���
if Tag == 1
    for i = 1: Q

        % ���1
        if R_train(i) == 1
            idx1 = [idx1; pc_train(i, 1 : 2)];
        end

        % ���2
        if R_train(i) == 2
            idx2 = [idx2; pc_train(i, 1 : 2)];
        end
    
        % ���3
        if R_train(i) == 3
            idx3 = [idx3; pc_train(i, 1 : 2)];
        end
    
    end

%%  ������ʵ���ɢ��ͼ
    plot(idx1(:, 1), idx1(:, 2), 'o', 'LineWidth', 1)
    hold on
    plot(idx2(:, 1), idx2(:, 2), 'o', 'LineWidth', 1)
    hold on
    plot(idx3(:, 1), idx3(:, 2), 'o', 'LineWidth', 1)
   
    
end

%%  ͼ�εĺ�������
legend('�������A', '�������B', '�������C')

xlabel('��ά���һά��')
ylabel('��ά��ڶ�ά��')
string = {'������ӻ�'};
title(string)
grid on