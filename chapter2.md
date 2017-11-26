---
title       : The Standardized Vocabularies
description : During this part of the course we will be studying the OHDSI Standardized Vocabularies by running queries against the SYNPUF CDM we loaded on a SQL Server instance in the Microsoft Azure cloud. Alternatively, you could use your own CDM instance for these exercises. <p><b>Instructions on how to connect to our CDM are provided during the face-to-face course.</b>
attachments :
  slides_link : https://s3.amazonaws.com/assets.datacamp.com/course/teach/slides_example.pdf


--- type:PureMultipleChoiceExercise lang:sql xp:50 skills:1 key:6087d6f53d
## Introduction
In the figure below you see the table structure of the Standardized Vocabulary section in the CDM. This illustrates how tables are connected to each other (data model). In each table you see a number of 'keys'. A 'red' key means that this is a so-called 'primary key', i.e. each value is unique and is used to reference the data. A 'green' key is a 'foreign key' which means it links to a primary key in another table, e.g. the vocabulary_id in the concept table. The 'blue' keys represent primary keys that consists of multiple fields, i.e. the combination of these fields is unique and use to lookup data in the table.

![alt text][logo]

[logo]: https://github.com/PRijnbeek/VocabularyCourse/raw/master/img/vocabulary-cdm.png "Vocabulary Table Structure"

In the upcoming questions we will explore the following most important tables:

CONCEPT: all concepts of all vocabularies

CONCEPT_RELATIONSHIP: all hierarchical relationships among concepts

CONCEPT_ANCESTOR: Multi-step hierarchical relationships pre-processed to make traversing the vocabulary easier

We will ask you to run a number of simple queries to train you in using these tables.

Let's start very simple. Try to find the the concept\_name of concept\_id = 313217 using the query below.

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


