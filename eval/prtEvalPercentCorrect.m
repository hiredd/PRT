function percentCorrect = prtEvalPercentCorrect(classifier,dataSet,nFolds)
% prtEvalPercentCorrect    Calculate percent correct of a classification operation
% 
%   percentCorrect = prtEvalPercentCorrect(prtClassifier, prtDataSet)
%   returns the percentage of correctly classified elements of prtDataSet
%   when classifier by prtClassifier. prtDataSet must be a labeled,
%   prtDataSetStandard object. prtClassifier must be a prtClass object.
%
%   percentCorrect = prtEvalPercentCorrect(prtClassifier, prtDataSet,
%   nFolds)  returns the percentage of correctly classified elements of
%   prtDataSet when classifier by prtClassifier with K-fold
%   cross-validation. prtDataSet must be a labeled, prtDataSetStandard
%   object. prtClassifier must be a prtClass object. nFolds is the number
%   of folds in the K-fold cross-validation.
%
%   percentCorrect = prtEvalPercentCorrect(prtClassifier, prtDataSet,
%   xValInds) same as above, but use crossValidation with specified indices
%   instead of random folds.
%
%   Example:
%   dataSet = prtDataGenSpiral;
%   classifier = prtClassDlrt;
%   pc =  prtEvalPercentCorrect(classifier, dataSet)
%
%   See Also: prtEvalPdAtPf, prtEvalPfAtPd, prtEvalAuc,
%   prtEvalMinCost









if nargin < 3 || isempty(nFolds)
    nFolds = 1;
end
results = prtUtilEvalParseAndRun(classifier,dataSet,nFolds);

%(note: can't check results.nFeatures here any more...)
if dataSet.nClasses == 2 %binary classifier 
    [pf,pd] = prtScoreRoc(results.getObservations,dataSet.getTargets);
    pe = prtUtilPfPd2Pe(pf,pd);
    minPe = min(pe);
    percentCorrect = 1-minPe;
else
    %Note, this is a hack; we need to fix this.
    if isa(classifier,'prtAlgorithm')
        guess = results.getObservations;
    else
        if classifier.includesDecision
            guess = results.getObservations;
        else
           %Naive MAP decision:
           % [twiddle,guess] = max(results.getObservations,[],2); %#ok<ASGLU>
           %Naive MAP decision:
           prtMap = prtDecisionMap;
           prtMap = train(prtMap,results);
           results = prtMap.run(results);
           guess = results.getObservations;
        end
    end
    percentCorrect = prtScorePercentCorrect(guess,dataSet.getTargets);
    %confusionMatrix = prtScoreConfusionMatrix(guess,dataSet.getTargets);
    %percentCorrect = prtUtilConfusion2PercentCorrect(confusionMatrix);
end
  
