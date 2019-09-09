%% �������� �ɼ� ����
opts = delimitedTextImportOptions("NumVariables", 6);

% ���� �� ���� ��ȣ ����
opts.DataLines = [1, Inf];
opts.Delimiter = ";";

% �� �̸��� ���� ����
opts.VariableNames = ["Time", "CS", "Lick", "Water", "Air", "Rstate"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double"];
opts = setvaropts(opts, [2, 4, 5, 6], "TrimNonNumeric", true);
opts = setvaropts(opts, [2, 4, 5, 6], "ThousandsSeparator", ",");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% �������� ��Ģ ����
opts = setvaropts(opts, [1, 2, 3, 4, 5, 6], "FillValue", 0);

% ������ ��������
rawdata = readtable("C:\Users\hyesu\OneDrive\���� ȭ��\Lick_analysis\I5_d17_s4.txt", opts);


%% �ӽ� ���� �����
clear opts
%% ��¥ ����
number_of_trial = 50;
%% trial ���� ���̺� ������
j = 1;
for i = 1:height(rawdata)
    if rawdata{i,2}== 1
        l_on(j) = i;
        j = j+1;
    end
end
l_on(2*number_of_trial +1) = height(rawdata);
for i = 1:number_of_trial
    for j = l_on(2*i-1):l_on(2*i+1)
        if rawdata{j,1} >= rawdata{l_on(2*i-1),1}+13000
            cs_off(i)=j;
            break
        end
    end
end
if length(cs_off) ~= number_of_trial
    cs_off(number_of_trial) = height(rawdata);
end
j = 1;
for i = 1:height(rawdata)
    if rawdata{i,6}== 1
        r_on(j) = i;
        j = j+1;
    end
end
for i = 1:length(r_on)/2
    rawdata{r_on(2*i-1):r_on(2*i),6} = 1;
end
j=1;
for i = 1:number_of_trial
    temp_txt1 = ['rawdata', int2str(i), '= rawdata(l_on(', int2str(2*i-1),'):cs_off(', num2str(i),'),:);'];
    eval(temp_txt1);
end
%% Linear motor ���� �ð� 0���� �Ȱ��� �����ֱ�
for i = 1:number_of_trial
    temp_txt1 = ['ndata', int2str(i),'= rawdata', int2str(i)];
    temp_txt2 = ['h = height(rawdata', int2str(i), ')'];
    temp_txt3 = ['ndata', int2str(i), '{:,1} = rawdata', int2str(i), '{:,1} - rawdata', int2str(i), '{1,1}'];
    eval(temp_txt1);
    eval(temp_txt2);
    eval(temp_txt3);
end
%% Lick �� �ð���, �ߺ� �ȵǰ� �����
for i = 1:number_of_trial
    temp_txt1 = ['lickdata', int2str(i),'= ndata', int2str(i)];
    temp_txt2 = ['a= (lickdata', int2str(i), '{:,3} ==1)'];
    temp_txt3 = ['lickdata', int2str(i), '(not(a),:) = []'];
    temp_txt4 = ['lickdata', int2str(i), '= unique(lickdata', int2str(i), ')'];
    temp_txt5 = ['h(', int2str(i), ')= height(lickdata', int2str(i),')'];
    temp_txt6 = ['lickdata', int2str(i), '{:,7} = ', int2str(i)];
    temp_txt7 = ['lickdata', int2str(i), '{:,8} = 3'];
    eval(temp_txt1);
    eval(temp_txt2);
    eval(temp_txt3);
    eval(temp_txt4);
    eval(temp_txt5);
    eval(temp_txt6);
    eval(temp_txt7);
end
%% Water ���� �ð���, �ߺ� �ȵǰ� �����
for i = 1:number_of_trial
    temp_txt1 = ['waterdata', int2str(i),'= ndata', int2str(i)];
    temp_txt2 = ['a= (waterdata', int2str(i), '{:,4} ==1)'];
    temp_txt3 = ['waterdata', int2str(i), '(not(a),:) = []'];
    temp_txt4 = ['waterdata', int2str(i), '= unique(waterdata', int2str(i), ')'];
    temp_txt5 = ['h(', int2str(i), ')= height(waterdata', int2str(i),')'];
    temp_txt6 = ['waterdata', int2str(i), '{:,7} = ', int2str(i)];
    temp_txt7 = ['waterdata', int2str(i), '{:,8} = 2'];
    eval(temp_txt1);
    eval(temp_txt2);
    eval(temp_txt3);
    eval(temp_txt4);
    eval(temp_txt5);
    eval(temp_txt6);
    eval(temp_txt7);
end
%% Air ���� �ð���, �ߺ� �ȵǰ� �����
for i = 1:number_of_trial
    temp_txt1 = ['airdata', int2str(i),'= ndata', int2str(i)];
    temp_txt2 = ['a= (airdata', int2str(i), '{:,5} ==1)'];
    temp_txt3 = ['airdata', int2str(i), '(not(a),:) = []'];
    temp_txt4 = ['airdata', int2str(i), '= unique(airdata', int2str(i), ')'];
    temp_txt5 = ['h(', int2str(i), ')= height(airdata', int2str(i),')'];
    temp_txt6 = ['airdata', int2str(i), '{:,7} = ', int2str(i)];
    temp_txt7 = ['airdata', int2str(i), '{:,8} = 1'];
    eval(temp_txt1);
    eval(temp_txt2);
    eval(temp_txt3);
    eval(temp_txt4);
    eval(temp_txt5);
    eval(temp_txt6);
    eval(temp_txt7);
end
%% ǥ ��ġ��, �Ʒ��� ��ġ��
lickdata = lickdata1;
for i = 2:number_of_trial
    temp_txt = ['lickdata = [lickdata;lickdata', int2str(i), ']'];
    eval(temp_txt);
end
waterdata = waterdata1;
for i = 2:number_of_trial
    temp_txt = ['waterdata = [waterdata;waterdata', int2str(i), ']'];
    eval(temp_txt);
end
airdata = airdata1;
for i = 2:number_of_trial
    temp_txt = ['airdata = [airdata;airdata', int2str(i), ']'];
    eval(temp_txt);
end
%% Go/ No Go Trial �и�
lickdata_go = lickdata(lickdata{:,6}==0,:);
lickdata_nogo = lickdata(lickdata{:,6}==1,:);
waterdata_go = waterdata(waterdata{:,6}==0,:);
waterdata_nogo = waterdata(waterdata{:,6}==1,:);
airdata_go = airdata(airdata{:,6}==0,:);
airdata_nogo = airdata(airdata{:,6}==1,:);
%% �׷��� �׸��� --> ���� --> �Ӽ� �����⿡�� ���� üũ ����
graph_data = [lickdata; waterdata; airdata];
graph_data(:,[2,3,4,5,6]) = [];
graph_data.Properties.VariableNames = {'Time' 'Trial' 'Group'};
x = graph_data(:,1);
y = graph_data(:,2);
g = graph_data(:,3);
x = table2array(x)/1000 -8.26; %% CS �ð� ����
y = table2array(y);
g = table2array(g);
s = gscatter(x,y,g,[1 0.7 0; 0 0 1; 1 0 0.8],'s',[7 12 7]); %% Air Water Lick
set(s(1), 'MarkerFaceColor', [1 0.7 0]); %%�׸� �ȿ� ���� ä���
set(s(2), 'MarkerFaceColor', [0 0 1]);
set(s(3), 'MarkerFaceColor', [1 0 0.8]);
graypatch_x = [0 0 2 2];
graypatch_y = [0 50 50 0];
patch(graypatch_x,graypatch_y, [0.2 0.2 0.2],'Edgecolor',[1 1 1], 'FaceAlpha', 0.2);
xticks([-2 -1 0 1 2 3 4 5]); %% ���ݰ� ������� []�� ������ּ���
yticks([0 5 10 15 20 25 30 35 40 45 50]); %% ���ݰ� ������� []�� ������ּ���
xlim([-2 2]);
ylim([0 50]);
% %% �׷��� �׸��� Go Nogo ����
% graph_data_go = [lickdata_go; waterdata_go; airdata_go];
% graph_data_go(:,[2,3,4,5,6]) = [];
% graph_data_go.Properties.VariableNames = {'Time' 'Trial' 'Group'};
% x = graph_data_go(:,1);
% y = graph_data_go(:,2);
% g = graph_data_go(:,3);
% x = table2array(x)/1000 -10;
% y = table2array(y);
% g = table2array(g);
% s_go = gscatter(x,y,g,[0 0 1; 1 0 0.8],'.',[35 20]); %% Air Water Lick
% xticks([-2 -1 0 1 2 3 4 5]); %% ���ݰ� ������� []�� ������ּ���
% yticks([0 5 10 15 20 25 30 35 40 45 50]); %% ���ݰ� ������� []�� ������ּ���
% xlim([-2 5]);
% ylim([0 50]);
% graph_data_nogo = [lickdata_nogo; waterdata_nogo; airdata_nogo];
% graph_data_nogo(:,[2,3,4,5,6]) = [];
% graph_data_nogo.Properties.VariableNames = {'Time' 'Trial' 'Group'};
% x = graph_data_nogo(:,1);
% y = graph_data_nogo(:,2);
% g = graph_data_nogo(:,3);
% x = table2array(x)/1000 -10;
% y = table2array(y);
% g = table2array(g);
% s_nogo = gscatter(x,y,g,[1 0.7 0; 1 0 0.8],'.',[20 20]); %% Air Water Lick
% xticks([-2 -1 0 1 2 3 4 5]); %% ���ݰ� ������� []�� ������ּ���
% yticks([0 5 10 15 20 25 30 35 40 45 50]); %% ���ݰ� ������� []�� ������ּ���
% xlim([-2 5]);
% ylim([0 50]);
%% Lick Ƚ�� ���� --> ���� 10ms ���� ���ϸ� ����ŷ�. --> ���� number_of_lick �ȿ� ���� ���.
for i = 1:number_of_trial
    temp_txt1 = ['lick_number_data', int2str(i),'= rawdata', int2str(i)];
    temp_txt2 = ['a= (lick_number_data', int2str(i), '{:,3} ==1)'];
    temp_txt3 = ['lick_number_data', int2str(i), '(not(a),:) = []'];
    temp_txt4 = ['lick_number_data', int2str(i), '= unique(lick_number_data', int2str(i), ')'];
    temp_txt5 = ['h(', int2str(i), ')= height(lick_number_data', int2str(i),')'];
    temp_txt6 = ['lick_number_data', int2str(i), '{:,7} = ', int2str(i)];
    eval(temp_txt1);
    eval(temp_txt2);
    eval(temp_txt3);
    eval(temp_txt4);
    eval(temp_txt5);
    eval(temp_txt6);
end
lick_number_data = lick_number_data1;
for i = 2:number_of_trial
    temp_txt = ['lick_number_data = [lick_number_data;lick_number_data', int2str(i), ']'];
    eval(temp_txt);
end
number_of_lick=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
for i = 2:height(lick_number_data)
    if lick_number_data {i,1} - lick_number_data {i-1,1} >=10
        a = lick_number_data{i,7};
        number_of_lick(a) = number_of_lick(a) +1;
    end
end