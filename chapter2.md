---
title       : The Standardized Vocabularies
description : During this part of the course we will be studying the OHDSI Standardized Vocabularies by running queries against the SYNPUF CDM we loaded on a SQL Server instance in the Microsoft Azure cloud. Alternatively, you could use your own CDM instance for these exercises. <p><b>Instructions on how to connect to our CDM are provided during the face-to-face course.</b>
attachments :
  slides_link : https://s3.amazonaws.com/assets.datacamp.com/course/teach/slides_example.pdf


--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:6087d6f53d
## Introduction
In the figure below you see the so-called entity-relationship diagram highlighting the tables within the Standardized Vocabulary section in the CDM. This diagram illustrates how field in the tables are connected to each other. In each table you see a number of 'keys'. A 'red' key means that this is a so-called 'primary key', i.e. each value is unique and is used to reference the data. A 'green' key is a 'foreign key' which means it links to a primary key in another table, e.g. the foreign key vocabulary_id in the concept table refers to the primary key in the vocabulary table. The 'blue' keys represent primary keys that consists of multiple fields, i.e. the combination of these fields is unique and used to lookup data in the table.
These constraints are enforced in a relational database to ensure the data integrity.

![alt text][logo]

[logo]: https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/vocabulary-cdm.png "Vocabulary Table Structure"

In the table below you can find a description of the tables we will discuss in more detail in this course (marked in green boxes in the figure above):
| Table  | Description |
|---|---|
| CONCEPT | Contains all the terminologies. The key is a newly created concept_id, not the original code of the terminology.  | 
| CONCEPT_ANCESTOR | Chains of hierarchical relationships are recorded in the CONCEPT\_ANCESTOR table. Ancestry relationships are only recorded between Standard Concepts that are valid (not deprecated) and are connected through valid and hierarchical relationships in the RELATIONSHIP table (flag defines_ancestry) |
| CONCEPT_RELATIONSHIP | Records in the CONCEPT\_RELATIONSHIP table define semantic relationships between Concepts. Such relationships can be hierarchical or lateral. 
| VOCABULARY | The VOCABULARY table includes a list of the Vocabularies collected from various sources or created de novo by the OMOP community. This reference table is populated with a single record for each Vocabulary source and includes a descriptive name and other associated attributes for the Vocabulary. |

More detailed information about the data model can be found on the <a href="https://github.com/OHDSI/CommonDataModel/wiki/" style="color:black">Github Wiki</a>

We will ask you to run a number of queries to train you in using these tables. You should have received seperate instructions on how to connect to our simulated database containing the latest vocabulary and data of 1000 patients (SYNPUF1000), or you can use your own CDM if you have access to it during the course.

<b>Exercise</b>

As you can see in the table above the concept\_ids in the CONCEPT table are not the original code of the terminolgy. Why are we not using the original SNOMED concept\_id if we use SNOMED as a our standard for example for the domain Conditions?

*** =possible_answers

- The ids are long and will take unnecessary space in the CDM
- We think we can make better codes
- Other terminology systems may have the same code
- We perform a quality control step that requires new code assignment

*** =hint

*** =feedbacks

- This will have no major effect on the CDM size
- Definitely not, we value the effort done by others and re-use this as much as possible
- Correct. You will see some examples later on in the course
- We do perform quality control steps but this is not the reason for defining our own codes.



--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:9eac36b5d7
## Your First Query

First, have a look at the fields in the <a href="https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT" style="color:black">CONCEPT table</a>. 
Then run your first query against the CDM to find the concept\_name of concept\_id = 313217:

```
SELECT * 
FROM concept 
WHERE concept_id = 313217;
```

What is the correct answer?


*** =possible_answers

- Asthma
- [Atrial Fibrillation]
- Stroke
- Death

*** =hint

*** =feedbacks

- Check your query
- You did you first query against the Vocabulary!
- Check your query
- Check your query


--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:788a621547
## Search by concept_code

In the previous exercise we searched for a concept by its 'OMOP' concept\_id. Another option to find a concept is to use its source code, e.g. the code provided by SNOMED.

It is important to understand that a concept\_code is not unique. Try to run this query to see for yourself:

```
SELECT * 
FROM concept 
WHERE concept_code = '1001';
```

Let's have a look at the Atrial Fibrillation example we used earlier if this is also true in that case. Run this query:

```
SELECT * 
FROM concept 
WHERE concept_code = '49436004';
```

What is the vocabulary\_id of this concept?

*** =possible_answers
- [SNOMED]
- ICD-9
- DPD
- RXNORM
*** =hint

*** =feedbacks
- Note that the vocabulary\_ids are available in readible format! 
- Check your query
- Check your query
- Check your query


--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:6654df47a2
## Vocabulary Table
The VOCABULARY table includes the list of the included Vocabularies. This reference table is populated with a single record for each Vocabulary source and includes a descriptive name and other associated attributes for the Vocabulary.

Run the following query to see the content of this table:

```
SELECT * 
FROM vocabulary
```

Which of the following statments is not true:

*** =possible_answers

- The vocabulary\_id=None shows the version of the vocab that is loaded
- [OMOP does not invent new concepts but is only using concepts from other terminology systems]
- The RxNorm Extension Vocabulary contains clinical drugs not on the American market
- The current list of vocabularies is noy covering all concept used in the world yet

*** =hint

*** =feedbacks


--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:c91862a449
## Search by concept_name

Normally you do not know these concept values by heart and you like to search by concept_name.
This can be done in several ways as illustrated below.

A. Extract by full name. Run the query below to see the results.

```
SELECT * 
FROM concept 
WHERE concept_name = 'Atrial fibrillation';
```
Note that this is case-sensitive. If you are not certain you could use LOWER:

```
SELECT * 
FROM concept 
WHERE LOWER(concept_name) = 'atrial fibrillation';
```
B. Search using 'like'. You can easily search for all the concepts that contain a substring using wildcards (%):

```
SELECT * 
FROM concept 
WHERE LOWER(concept_name) like '%fibrillation%';
```

 Let's try to find the standard concept\_id for the clinical finding Asthma in the vocabulary. Try to find this using both methods described above. You will see that if you do not restrict to the concept_class_id = 'Clinical Finding' (AND concept_class_id = 'Clinical Finding') you can get multple standard concepts!
 
 What is the code we asked for?

*** =possible_answers
- 195967001
- 257581
- [317009]
- 45877009
*** =hint

*** =feedbacks
- This is not the field we asked for!
- This exacerbation of Asthma
- Well done. We will learn how to extract the different types of Asthma later in the course
- This is the answer to a question located in the measurement table. 


--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:4a115d0cb3
## Concept Relationship

Records in the CONCEPT\_RELATIONSHIP table define semantic relationships between Concepts. Such relationships can be hierarchical or lateral.
The figure below shows the concept relationships for the condition domain.

<center><img src="https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/hierarchy1.png" alt="Concept Relationship" width="550" height="400"></center>

This shows that all non-standard vocabularies map to the Standard SNOMED vocabulary at different levels. The figure also shows the MEDRA vocabulary which is used for a higher 'Classification' level (denoted as 'C' in the standard_concept field in the concept table).

There are different types of relationships defined in the vocabulary. For example the 'Maps to' relationship defines to witch Standard Concept\_id the codes mappes to. You can explore all the relationships by running the following query:

```
SELECT * FROM relationship;
```

Let's use this new insight to find to which standard code the code '427.31' mappes. You can do this for example by first finding the concept\_id using:
```
SELECT * FROM concept WHERE concept_code = '427.31';
```

You can the use the concept_relationshop table find its relationships.

```
SELECT * FROM concept_relationship WHERE concept_id_1 = 44821957;
```

*** =possible_answers

*** =hint

*** =feedbacks

--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:a44bac8fdd
## Athena

<p><img src="https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/Athena.png" alt="Athena" width="150" height="60"></p>

Finally, we like to make you aware a very nice tool called ATHENA you can find <a href="http://athena.ohdsi.org" style="color:black">here</a>. This tool shows you the current vocabularies maintained by OHDSI. 

If you create an account it will allow you to download a new version of the vocabulary (no need to do this now, you can do this later if you want to). It will nicely archive all your previous downloads.

Let's explore the searching functionality a bit. Search for 'type 2 diabetes' and use the filters on the left to show only the Standard Concepts in the domain 'Condition'. You see many standard codes here which represent different levels in the hierarchy. 

Search for '201826' and click on it. You can now see the hierarchy and related concepts retrieved from the vocabulary tables. 

Try to find some other concepts you are interested in and play around with the tool.

<b> Question: </b>

What is the ICD-10CM standard\_code for 'type 2 diabetes'? Can you find this by using filter or the hierachy and related_concepts information of the standard concept?


*** =possible_answers

- [E11]
- 1567956
- 250.00
- 201826
*** =hint


*** =feedbacks

- Correct
- This the concept\_id
- ICD-10CM?
- This is the standard concept\_id
- 
