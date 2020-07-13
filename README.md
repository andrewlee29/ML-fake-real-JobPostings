# ML-fake-real-JobPostings
Introduction
 	The fake job position dataset contains 17,880 job postings, among which 866 are fake. There are 16 different features and a target variable (fraudulent) in the data. We are going to use the dataset to create classification models which can learn the job descriptions which are fraudulent. We will use Naive bayes classification and decision trees to analyze the data and find out which will produce better results. Since some of the features are textual information and unique (company profile, description, requirements), we will omit those features for greater simplicity.
Results & Discussion
Decision Tree Model
In order to create a classification decision tree using R, the following features were used:
Telecommuting required
Has company logo
Has question
Employment type
Required experience
Required education
Function

The factor levels of the column ‘function’ had to be collapsed to allow for a number of factors that could be handled by the R package ‘tree’, such that:
‘Product Management’ and ‘Project Management’ were put under the ‘Management’ umbrella, which was a pre-existing level
‘Business Development’ was put under the pre-existing ‘General Business’ level
‘Business Analyst’, ‘Financial Analyst’ and ‘Data Analyst’ were renamed to a new level titled ‘Analyst’
‘Other’ was considered to be an N/A field, just like for cells missing information
These assumptions allow us to get the following tree as an immediate output:


Legend (alphabetical from left to right):
Function
A/A: Accounting/Auditing
Adm: Administrative
Adv: Advertising
An: Analyst
A/C: Art/Creative
C: Consulting
CS: Customer Service
Dsg: Design
Dst: Distribution
Ed: Education
En: Engineering
F: Finance
GB: General Business
HCP: Health Care Provider
HR: Human Resources
IT: Information Technology
L: Legal
Mng: Management
Mnf: Manufacturing
Mr: Marketing
Prd: Production
PR: Public Relations
Prc: Purchasing
QA: Quality Assurance
R: Research
Sl: Sales
Sc: Science
S/: Strategy/Planning
SC: Supply Chain
T: Training
W: Writing/Editing




Required education
AD: Associate Degree
BD: Bachelor’s Degree
C: Certification
D: Doctorate
HSoe: High School or equivalent
MD: Master’s Degree
P: Professional
SCCC: Some College Coursework Completed
SHSC: Some High School 
 Coursework
U: Unspecified
V: Vocational
V-D: Vocational - Degree
V-HD: Vocational - HS Diploma




Required experience
A: Associate
D: Director
El: Entry level
E: Executive
I: Internship
Ml: Mid-Senior level
NA: Not Applicable 





(It’s also good to remember that what is being evaluated is the postings’ fraudulence. Therefore, 0 signifies non-fraudulent, a.k.a. ‘real’, and 1 conversely means ‘fake’.) A pruned and improved version of it:

N.B.: The reason why some decision nodes might look foreign or even wrong is because they ask exactly the opposite question that was asked in the original tree (complements), to save some space and add visual clarity. For instance, instead of asking whether the required experience was A, El, E, I, or NA, the question instead asked whether the required experience was D or Ml (the two remaining values for this feature). ‘Yes’ and ‘No’ branches were swapped accordingly to maintain the original tree structure.
The tree, which was formed using a random sample of 75% of the entire dataset, was tested against the remaining 25%. The test given a seed of 2 for replicable random number generation (which was the seed used to create the first tree model) lent a predictive accuracy of about 0.9526.
Based on the model produced and with a dataset containing the same feature levels, we may infer that a posting proposing a job in anything else than Distribution, Engineering, or General Business, provided that it does not require Associate, Mid-Senior level or Director experience and that the company logo is absent from the posting has a very high likelihood of being fake. Additionally, a job posting in Distribution containing the company logo where a Mid-Senior level or Director experience is required is also likely to be fake.
Naive Bayes Classification Model
To apply naive bayes classification to the dataset, we have to assume all features are independent. Although some features seem like they depend on each other in this dataset (such as department and industry), most features are quite independent (such as location and telecommuting). Some features are also optional and can be empty. Therefore, we can assume most of the features are independent in this dataset. Unfortunately, I am not able to use all the features to create Naive Bayes classification models. The reason is if the feature variable wasn’t observed in the training data, the model will assign a 0 probability and will destroy the model. For example, most job positions have unique variables in description. If we include the description feature in the model, most of the probability will return 0. Here are the features that we use to create the model:
Location
Department
Telecommuting required
Has company logo
Has question
Employment type
Required experience
Required education
Function

Those features mostly have the stable variable and it is not easy to produce 0 probability in the model.
I set the 75% of random data to be the training data and 25 % data to be test data. Here is the result:


The overall accuracy of the model is around 80% and the fake job accuracy is about 60%. There is a main reason that the model accuracy couldn’t be more accurate. The model can’t tell a big difference in the data without some features. For example:
In this data, title is the most effective feature that shows most administrative assistants are fake positions. The model didn’t use the title feature because the feature has a lot of unique variables and it will drop the accuracy. This makes the model more difficult to classify the data accurately. In addition, other minor problems also affect the result of the model. Some features are not completely independent and it makes some features have higher effect than others. The probability may become 0 because some features have a unique variable.
Conclusion
One thing that should be recognized when it comes to this dataset is how its existence is something of a miracle in the first place. Creating a dataset based on almost 18,000 job postings and creating uniformity among the columns for so many features must have been a real trouble, especially since some features like the presence of the company’s logo or even fraudulence itself must have required more than just an automated text-reading process, but rather much more intelligent image processing and spoof-testing respectively. It is also worth noting that the precision of each model could have been improved further using such advanced algorithms, in order to analyze the several text-based features present in the dataset, had more research been done on relevant keywords for the specific problem.
The decision tree model proved a much more precise predictive method for the fake job postings dataset compared to the Naive Bayes classification model, even with the few convenience modifications applied to the former. It also allows us to have a neat visual representation of the recommended decisions based on some of the postings’ features, especially when revised graphically. Perhaps this model could one day prevent somebody from being hired for a fake job?
