%%  ��ջ�������
warning off             % �رձ�����Ϣ
close all               % �رտ�����ͼ��
clear                   % ��ձ���
clc                     % ���������

%%  �ڣ�1�����еڶ���
% ������С���˷�������ѧ�ɷֺ������Ƿ�绯֮�����ѧ��ϵ
% �Բ�ͬ���͵�����ֱ���ģ�� 0 δ�绯 1 �绯

%%  ��ȡ���������ݼ�
res_qb = xlsread('�߼�Ԥ��.xlsx');
M = size(res_qb, 1);

for i = 0 : 3

    %%  ��ӽؾ���
    P_train = [res_qb(:, 1: end - 4), ones(M, 1)];
    T_train =  res_qb(:, end - i);
    
    %%  ����ģ��
    beta = regress(T_train, P_train);
    
    %%  Ԥ�����
    T_sim1 = P_train * beta;
    T_sim1(T_sim1 < 0) = 0;

    error1 = sqrt(sum((T_sim1 - T_train).^2) ./ M);

    %%  ��ͼ
    figure
    plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
    legend('��ʵֵ', 'Ԥ��ֵ')
    xlabel('Ԥ������')
    ylabel('Ԥ����')
    string = {'Ԥ�����Ա�'; ['RMSE=' num2str(error1)]};
    title(string)
    xlim([1, M])
    grid

    %%  ��ȡǦ��δ�绯����
    None_qb = P_train(13: end, :);
    None_qb(:, 1) = 0;
    T_sim2(:, i + 1) = None_qb * beta;
    T_sim2(T_sim2 < 0) = 0;

end

%%  Ǧ��Ԥ����
xlswrite('�߼�Ԥ����.xlsx', T_sim2)
