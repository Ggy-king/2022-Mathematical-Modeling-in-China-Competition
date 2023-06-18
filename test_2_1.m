%%  ��ȡ���������ݼ�
data_result = xlsread('�߼�Ǧ������.xlsx');
M = size(data_result, 1);

%%  ��ӽؾ���
L_train = data_result(:, 1: end - 1);
R_train = data_result(:, end);

%%  ����ģ��
ctree = fitctree(L_train, R_train, 'MinLeafSize', 8);

%%  �鿴��������ͼ
view(ctree, 'mode', 'graph');

%%  �������
T_sim1 = predict(ctree, L_train);

%%  ����׼ȷ��
error1 = sum((T_sim1 == R_train)) / M * 100 ;

%%  ��ͼ
figure
plot(1: M, R_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('��ʵֵ', 'Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('Ԥ����')
string = {'Ԥ�����Ա�'; ['׼ȷ��=' num2str(error1) '%']};
title(string)
xlim([1, M])
grid

%%  ��������
figure
cm = confusionchart(R_train, T_sim1);
cm.Title = 'Confusion Matrix for Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
