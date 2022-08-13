[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&color=5800F7&background=FF000000&width=435&lines=FARMING+USING+AI+AND+BLOCKCHAIN)](https://git.io/typing-svg)
`` Bachelor’s degree final project ``

## PROJECT SCOPE

The scope of this project is to help farmers with ``crop recommendations``, ``fertilizers
recommendations`` based on the soils properties as well as the weather condition of that field
and predicting the ``right time to fertilize plants`` or crops based on the weather forecasting
information and ``detect diseases in plant's leaves``, and also help farmers with the financial
issues such as ``raising funds or investments for farming projects using crowdfunding method``.
And make
accessible these functionalities or services through a mobile application to
farmers

## FEATURES

## TOOLS AND LIBRARIES

- FLUTTER
- FAST API
- SOLIDITY
- FIREBASE
- SKLEARN
- TENSORFLOW
- TRUFFLE SUITE
- GANACHE

## ARCHITECTURE

[architecture pic]


## REST API DESIGN
[pic]

#### 1. Crop Recommendation

This endpoint will only accept POST requests, And that consists of the
information required for the crop recommendation model in the form of text. And It
will respond to those requests with the possible crops they can grow.

#### 2. Fertilizer Recommendation

This endpoint will only accept POST requests, And that consists of the
information required for the fertilizer recommendation model in the form of text. And
It will respond to those requests with the possible fertilizers they can apply.

#### 3. Fertilizer Time Prediction

This endpoint will only accept POST requests, And that consists of the
information required for predicting the time to fertilize. And It will respond to those
requests with required information about the time to fertilize.

#### 4. Plant Disease Detection

This endpoint will only accept POST requests, And that consists of the photo
of the plant leaves. And It will respond to those requests with the disease information
as well as is it healthy or not.
This endpoint will only accept POST requests, And that consists of the
information required for the crop recommendation model in the form of text. And It
will respond to those requests with the possible crops they can grow.

## CROWDFUNDING DESIGN

- Crowdfunding is a technique for financing business, artistic or other projects and
initiatives by pooling often small amounts of capital from a large number of people.

- Crowdfunding has the potential to play an important role in the agriculture sector for
several reasons. One of the main reasons is that agriculture projects can require a large
amount of capital that can exceed the investment thresholds of smaller investors.
Crowdfunding can allow smaller investors to participate in promising agriculture ventures of
different sizes and in different parts of the world.

- This crowdfunding service is completely implemented using blockchain technology
because the properties such as distributed ledger will provide storage of both static and
dynamic transactions without the need for a centralized authority, along with a consensus
mechanism that helps in the validation of the transactions.

### Class Diagram Of Crowdfunding

[pic Class Diagram Of Crowdfunding]

### State Transfer Diagram Of Crowdfunding

[pic State Transfer Diagram Of Crowdfunding]

#### 1. FUNDRAISING STATE
When a project is created it will be initialized to the Fundraising state. So in this state,
the investors can invest in these projects, and also from this state creator can cancel the
project

#### 2. CANCELED STATE
The project contract will change the state from fundraising to canceled when the
creator cancels the project. So from this state, it will not accept any more investments

#### 3. EXPIRED STATE
The project contract state will change from fundraising to Expired, if the project due
date occurred as well as also the project didn't achieve its required amount

#### 4. SUCCESSFUL STATE
This state occurs when the project achieved its required amount within the due date

#### 5. COMPLETED STATE
This State change happens when the project creator did that project successfully and
is ready to return the returns to investors

#### 6. CLOSED STATE
It's the end of every project cycle. The projects will reach this state only after
receiving the approval from all their investors


## IMPLEMENTATION AND TESTING

### REGISTRATION AND LOGIN

- The registration and logging service is implemented using firebase services. The
firebase database is used for storing the details of farmers that got while registration

- Firebase authentication service is used to implement the login or sign-in mechanism
of the mobile application.

### REST API AND SERVER

- Fast API library is used to implement the rest API service of this system.

### CROP RECOMMENDATION

- The proposed model predicts the crops for the data sets of the given region. The data
from previous years are the key elements in forecasting current performance.

- Historical data
is collected from kaggle.com[url]

#### Accuracy Of Different Ml Algorithms On Crop Recommendation Dataset

[pic of accuracy metrcs]

- This system will recommend possible crops and it will allow a user to explore the
possible crops they can grow on the field to make more educated decisions. For this, various
machine learning algorithms are used such as Random Forest, SVM, Decision Tree Naive
Bayes, Logistic Regression, and XGBoost were implemented and tested on the datasets. The
various algorithms are compared with their accuracy as shown in figure 6.10. The results
obtained indicate that the Random Forest algorithm is the best among the set of standard
algorithms used on the given datasets with an accuracy of 99%

### FERTILIZER RECOMMENDATION

- Fertilizer recommendation is implemented using the information we got from the
statistical analysis of the crop recommendation dataset from kaggle.com[link]

- By using the
information obtained from the analysis we formulated a custom dataset that consists of the
minimum, mean, and maximum values of each and every crop's nutrients values such as
nitrogen (n), phosphorus (p), and potassium (k)

[pic custon dataset]

- So, based on this dataset and given input it will check if the given values are higher
than the maximum or lower than the minimum, and Based on the evaluation it will return
results as the remedies

### FERTILIZER TIME PREDICTION

- The timing of applying the fertilizer is very crucial. The farmer's effort and money
will get wasted if the rain comes down too early. The proposed fertilizer usage service will
guide the farmer on when to use the fertilizer. The model will fetch the weather forecasting
data, especially the rain data for the specific location for the next 5 days using Weather API,
And based on the analysis of the data it will respond as either "not safe to use the fertilizers"
or "safe to use fertilizers"

### PLANT DISEASE DETECTION

- The proposed model predicts the plant diseases from the given plant leaf image. For
this, we have used the dataset named PlantVillage which is collected from kaggle.com[link]. For
prediction, we have used transfer learning technique with Resnet50 model

[pic of model summery]

[accuracy]

## SCREENSHOTS OF MOBILE APPLICATION


