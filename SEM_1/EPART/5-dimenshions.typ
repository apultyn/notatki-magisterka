= Dimensionality Reduction

== Problem

- often we have vectors with many many features
- we usually can't asses which features are more important and which less
- also features are usually not independent
- but large dimenshionality urges us to have more training data
- computational complexity also radically grows with high amount of dimenshions

== PCA

- finding new coordinate axes in which data has the biggest variance
- ignores class labels
- usefull for data compression and retaining maxiumum information

== FLD

- _Fisher's Linear Discriminant_
- finding projection that best seperates the classes
- discrimination is the priority