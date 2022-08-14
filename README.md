

<p align="center">

  <a target="_blank">
    <img alt="amplication-logo" height="250" alt="Amplication Logo" src="https://drive.google.com/uc?export=view&id=1FPnl1iekg-Afmee-kTs6BhfbvXyXUK0x"/>
  </a>
</p>
<h3 align="center">
  <b>
    <a>
      FARMING USING AI AND BLOCKCHAIN
    </a>
  </b>
</h3>



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


![image](https://drive.google.com/uc?export=view&id=187N079IJKutAoDjLp5tkhPKVv7FRjqSk)


## REST API DESIGN
![image](https://drive.google.com/uc?export=view&id=1KA4nWnFdQ6ucwq7Dho8mAIjjUvvg2X03)



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


![pic Class Diagram Of Crowdfunding](https://drive.google.com/uc?export=view&id=1DNKT6K1ARYgY9E9_s51DufpxeMur1h_m)


### State Transfer Diagram Of Crowdfunding

![pic State Transfer Diagram Of Crowdfunding](https://drive.google.com/uc?export=view&id=1snca_p1rAoBmSVvt3dtZCAbpNYvF8dwI)

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

![pic of accuracy metrcs](https://drive.google.com/uc?export=view&id=1ejbrs0uTLhWdmNoHvVcyX4BHekQltaDF)

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

![pic custon dataset](https://drive.google.com/uc?export=view&id=1vEP4gx5q4rZtB49l6yE2DhL1fdPW0o_p)

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

![pic of model summery](https://drive.google.com/uc?export=view&id=1HQOe_UsiZgf1ipDarrZdk9XFMzB1Jusj)


![accuracy](https://drive.google.com/uc?export=view&id=1uNNz61PMnPD5FkUH-70dw8YFctjlCVi2)


## SCREENSHOTS OF MOBILE APPLICATION

![image](https://drive.google.com/uc?export=view&id=1-a3pGOuuflfHxWeY8NitaobNF3FttBSf)

![image](https://drive.google.com/uc?export=view&id=1rpeUQJBWDzWmL1NHF7RSY8uyecNmtT_g)


![image](https://drive.google.com/uc?export=view&id=19XUFBcwyjPZfaog-ONtzg0LOCPKKFXHU)

![image](https://drive.google.com/uc?export=view&id=1uCgxirJJYGlh8LxWjtdfznUFuc7VOPyU)


![image](https://drive.google.com/uc?export=view&id=1w8TExUh-RovmLBsvPwGeReUoeSpFDpRF)

![image](https://drive.google.com/uc?export=view&id=1Y1PD60btiymiA_ZgbjHKpKM8GDdt4ulU)

---
---
<div align="center">
<i>Follow me around the web:</i><br>
<p>

<a href="https://www.linkedin.com/in/adil-rahman-80b17a23a/" target="_blank"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"></a>
<a href="https://www.instagram.com/___i_am_iron_man/?hl=en" target="_blank"><img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white" alt="Instagram"></a>
<a href="https://medium.com/@adilrahman_1337" target="_blank"><img src="https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white" alt="DEV.to"></a><a href="https://twitter.com/bitbyte_1337" target="_blank"><img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" alt="DEV.to"></a>

</p>
</div>

---
