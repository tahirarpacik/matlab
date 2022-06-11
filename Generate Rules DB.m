%% Add Rules from DB %%

% _________ section 1 _________ %
fis=readfis('TKV.fis');
fisrules=fis.rules;
% The amount of rules must assign to 's' %
s=4;
t=17;
ruleList = zeros(s,t);
% _________ section 2 _________ %
% Zero values must be changed in the ruleList then start the below code %
% fis.Rules = []; %clear rules
fis = addRule(fis,ruleList);
fsrl=fis.Rules; % fsrl: shows all the rules in the fis %

% fuzzyLogicDesigner(fis); % this code opend the interface of fis %




