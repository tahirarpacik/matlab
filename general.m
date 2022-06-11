%% GENERAL %%
fis=readfis('TKV.fis');
% a=input('Lütfen girdiyi giriniz = ');
% g=evalfis(f,a);
% disp(['Output is = ', num2str(g)]);

% fuzzyLogicDesigner(fis);

% dbNew =[];

% output=fis.Rules;
% disp(output);
fisrules=fis.rules;
cons=fisrules.Consequent;
s=26;
t=27;
H = zeros(s,t);
for x=1:s
    for y=1:t
        H(x,y)=fisrules(x).Antecedent(y);
    end
end
% Hs=fisrules(2).Antecedent(1);

fisStructure = getFISCodeGenerationData(fis);




%% Read FIS %%

fis=readfis('TKV.fis');
Inpt=fis.Inputs;
s=17;
t=3;
H = zeros(s,t);
Hstr=string(H);
% HH = zeros(s,t);
for x=1:s
    Hstr(x,1)=Inpt(1,x).Name;
    Hstr(x,2)=Inpt(1,x).Range(1);
    Hstr(x,3)=Inpt(1,x).Range(2);
%     for z=1:t
%         HH(x,3)=Inpt(1,x).MembershipFunctions;
%     end   
end
%% Aggregation Method %%

aggmetodoffis = fis.AggMethod;
fis.AggregationMethod = "sum";
aggmetodoffis = fis.AggMethod;
%% Build Fuzzy Inference System %%
fis=readfis('TKV.fis');
fis.Rules = [];
ruleList=zeros(1,26);
fis = addRule(fis,ruleList);
fsrl=fis.Rules;
% fuzzyLogicDesigner(fis);

writeFIS(fis,'myFile');


%% GENSURF TOTAL %%
Ztop = zeros(20,7);
for a=1:7
% plotmf(fis,'input',1);
opt = gensurfOptions;
opt.OutputIndex = a;
opt.InputIndex=17;
opt.NumGridPoints=20;
opt.ReferenceInputs= [0.20 0.15 0.25 0.30 1.00 0.75 0.15 0.3 0.10 0.10 0.25 0.20 0.95 0.90 0.15 0.20 1.00];
[X,Y,Z] = gensurf(fis,opt);
% gensurf(fis,opt);
    for y=1:20
        Ztop(y,a) = Z(y,1);
    end
end

%% GENSURF %%


% plotmf(fis,'input',1);
opt = gensurfOptions;
opt.OutputIndex = 3;
opt.InputIndex=[5,17];
opt.NumGridPoints=40;
opt.ReferenceInputs= [0.20 0.15 0.25 0.30 1.00 0.75 0.15 0.3 0.10 0.10 0.25 0.20 0.95 0.90 0.15 0.20 1.00];
[X,Y,Z] = gensurf(fis,opt);
gensurf(fis,opt);
%     for y=1:20
%         Ztop(y,a) = Z(y,1);
%     end

%% EVALFIS %%


options = evalfisOptions('NumSamplePoints',101);
input= [0.20 0.15 0.25 0.30 1.00 0.75 0.15 0.30	0.10 0.10 0.25 0.20 0.95 0.90 0.15 0.20 1.00];
output = evalfis(fis,input,options);

%% SAVE SIMULINK AS PDF %%

saveas(get_param('TKV','Handle'),'TKV.pdf');



