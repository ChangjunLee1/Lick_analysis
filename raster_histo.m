% ���� �÷� ���� Ƚ�� ����
number_of_trial = 100;
histogram_data = readtable("C:\Users\cjblu\OneDrive\����\MATLAB\raster_histo_1.txt"); %% ������׷� ������ �ҷ�����
x = table2array(histogram_data(:,1))-0.05;
y = table2array(histogram_data(:,2));
histogram = bar(x,y); %% ������׷� �׸���
raster_data = readtable("C:\Users\cjblu\OneDrive\����\MATLAB\raster_histo_1a.txt"); %% ���� ������ �ҷ�����
raster_dataonly = table2array(raster_data(:,3));
% ������ ���࿡�� �ĸ��� ���е� ���� ������ ������
for i = 1:number_of_trial
    temp_txt1 = ['raster_data',int2str(i),'= strsplit(cell2mat(raster_dataonly(',int2str(i),')),",")'];
    eval(temp_txt1);
    temp_txt2 = ['raster_data',int2str(i),'(2,:) = {',int2str(i),'}'];
    eval(temp_txt2);
    temp_txt3 = ['raster_data',int2str(i),'= transpose(raster_data',int2str(i),')'];
    eval(temp_txt3);
end
% ǥ ��ġ��
raster_dataplot = raster_data1;
for i = 2:number_of_trial
    temp_txt = ['raster_dataplot = [raster_dataplot;raster_data', int2str(i), ']'];
    eval(temp_txt);
end
y = cell2mat(raster_dataplot(:,2));
x = str2double(cellstr(raster_dataplot(:,1)))-0.05;
scatter(x,y,'s','filled');
xlim([-0.05,1]);