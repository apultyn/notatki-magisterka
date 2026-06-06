= Combining multiple classifiers

== Two themes

+ combining multiple classifier decisions (meta-classifiers):
  - simple voting
  - weighted votingcombination of classifiers rank lists
  - naive probability combination rule
  - Bayesian combination rule
  - behavior-knowledge space
+ OCR postprocessing methods:
  - lexical methods
  - word context
  - document context

== Why ensembles help

+ *Statistical premise* - when several classifiers perform well, averaging them reduces the risk of betting on one that happens to be wrong
+ *Computational premise* - training is imperfect, so combining several search paths gives more chance of finding true optimum
+ *Representational premise* - the true optimal classifier may lay outside of the space any single model can represent, but ensemble allows to build that complexity

== Design aspects

+ *Degree of integrity* - measure of how strongly the individual classifiers are directed by meta-classifier
+ *Representation of results* - how much information each classifier outputs - from single winning label to full ranked list with probabilities
+ *Combination method* - depending heavily on representation of results

== Four levels of design choices

+ *Data level* - how to manipulate the training data so that base classifiers are both diverse and individually accurate
+ *Feature level* - all features or chosen set for each classifier? How to select them?
+ *Classifier level* - same or different classifier types? how many? train together or incrementally?
+ *Combination level* - how to handle each output

== Three forms of classifier output

+ *Abstract level* - just a single label without any information $e(x) = j$
+ *Rank level* - ordered list of ranked results $e(x) = L$
+ *Measurement level* - adding confidence level in the recognition result

== Combining results

=== Simple voting

- unanimity tends to strongly reduce error amount, but rejects many cases
- majority and plurality drives success rate really high, at the cost of more errors

=== Class set reduction

- goal - shrink the canditate list, while keeping the true class inside of it
- success is meausered by:
  - probability of true class being still included
  - the size of candidate set (the lower the better)

=== Class set reordering

- goal - produce ranking that pushes the true class as close to the top as possible
- the only success measurement is true class score at the end
- two common approaches:
  - highest rank - assign each class the best rank position of this class in any of the individual rankings - tends to create many ties
  - Borda Count - you assign Borda count for every class and classifier, that denotes the number of classes in the decision class ranking which are ranked below our class in that classifier

=== Naive probability combination

- when classifiers are Bayes classifiers (they approximate the _posteriori_ probability), one way to combine them is to average the measurements
- that's problematic, since diferent classifiers can use different confidence scales, which may be not comparable

=== Genetic algorithm

- Start with initial population (randomly generated)
- Select best solutions for survival via _fitness function_
- Combine these best solutions via exchanging information and random mutations to find another, possibly better, solutions
- *Bayesian rule*
  - in the end, you assign the weight to the vote of each classifier
  -