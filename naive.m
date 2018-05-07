trainingpath = 'training.csv';
testingpath = 'testing.csv';
trainingdata = getdata(trainingpath);
testingdata = getdata(testingpath);
classyes = strcmp(trainingdata{9},'yes');
classno = not(classyes);
nyes = sum(classyes);
testingclasses = testingdata{9};
ntraininginstances = length(testingclasses);
ntestinginstances = length(testingdata{9});
nno = ntraininginstances - nyes;
pyes = nyes/ntraininginstances;
pno = 1-pyes;
allevidencegivenyes = zeros(ntestinginstances,8);
allevidencegivenno = zeros(ntestinginstances,8);
for column = 1:8
    testingevidence = testingdata{column};
    trainingevidence = trainingdata{column};
    evidencegivenyes = trainingevidence(classyes);
    evidencegivenno = trainingevidence(classno);
    averageofyesses = mean(evidencegivenyes);
    averageofnos = mean(evidencegivenno);
    deviationofyesses = std(evidencegivenyes);
    deviationofnos = std(evidencegivenno);
    ppartialevidencegivenyes = normpdf(testingevidence,averageofyesses,deviationofyesses);
    ppartialevidencegivenno = normpdf(testingevidence,averageofnos,deviationofnos);
    allevidencegivenyes(:,column) = ppartialevidencegivenyes;
    allevidencegivenno(:,column) = ppartialevidencegivenno;
end
finalevidencegivenyes = prod(allevidencegivenyes(:,[1:8]),2);
finalevidencegivenno = prod(allevidencegivenno(:,[1:8]),2);
classification = finalevidencegivenyes > finalevidencegivenno;
outputs = {'no','yes'};
nbcounter = 0;
for i = 1:length(classification)
    disp(outputs{classification(i)+1})
    if strcmp(outputs{classification(i)+1},testingclasses{i})
        nbcounter = nbcounter+1;
    end
end
naivebayesaccuracy = nbcounter/ntestinginstances

zrcounter = 0;
if nyes > nno
    zerorprediction = 'yes';
else
    zerorprediction = 'no';
end
for i = 1:length(classification)
    if strcmp(zerorprediction,testingclasses{i})
        zrcounter = zrcounter + 1;
    end
end

zeroraccuracy = zrcounter/ntestinginstances



