Thanks for visiting

The purpose of this project was to mildly investigate if we could reduce the amount of data needed to accurately train a machine learning model on RF data.
This study aims to look at if we can capture the soul of the signal with out needing 97,000 points per signal. The dataset is a collections of RF recordings
taken from 7 equal drones. The idea is to independantly classifiy which of the 7 drones is transmitting just by looking at the RF signal. Our first baseline 
method tries to use 13 features but the results are not great. Our second method uses an audio signal technique that gives us 188 features. For now my results 
indicate that 188 points per signal does a pretty good job. Using these 188 points, what else can we find out about the signal?

If you would like to replicate this project. Please download the data and start with SigMF to MATLAB folder.
