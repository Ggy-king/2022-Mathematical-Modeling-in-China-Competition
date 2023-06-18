%%  ��ջ�������
warning off             % �رձ�����Ϣ
close all               % �رտ�����ͼ��
clear                   % ��ձ���
clc                     % ���������

%%  �ڣ�1�����еڶ���
% ������С���˷�������ѧ�ɷֺ������Ƿ�绯֮�����ѧ��ϵ
% �Բ�ͬ���͵�����ֱ���ģ�� 0 δ�绯 1 �绯

%%  ��ȡ���������ݼ�
res_gj = xlsread('�߼�.xlsx');
M = size(res_gj, 1);

%%  ��ӽؾ���
P_train = [res_gj(:, 1: end - 1), ones(M, 1)];
T_train =  res_gj(:, end);

%%  ����ģ��
beta = regress(T_train, P_train);

%%  Ԥ�����
T_sim1 = P_train * beta;

%%  �����
T_sim1(T_sim1 >= 0.5) = 1;
T_sim1(T_sim1 <  0.5) = 0;

%%  ����׼ȷ��
error1 = sum((T_sim1 == T_train)) / M * 100 ;

%%  ��ͼ
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('��ʵֵ', 'Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('Ԥ����')
string = {'Ԥ�����Ա�'; ['׼ȷ��=' num2str(error1) '%']};
title(string)
xlim([1, M])
grid

%%  ��������
figure
cm = confusionchart(T_train, T_sim1);
cm.Title = 'Confusion Matrix for Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';

%%  �����ʽϵ��
disp(beta')

%%  Ҳ���� Y = �������x1w1+x2w2+...+xnwn��
%%  ��������Ǵ���0.5����1��С��0.5����0