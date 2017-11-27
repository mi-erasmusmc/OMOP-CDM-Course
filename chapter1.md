---
title       : The OMOP Common Data Model
description : You will learn more about the CDM data structure and will understand which tables to query to retrieve the necessary data for your research questions.
attachments :
  slides_link : https://s3.amazonaws.com/assets.datacamp.com/course/teach/slides_example.pdf

--- type:VideoExercise lang:sql xp:50 skills:1 key:7b121737a5
## Introduction OHDSI

*** =video_link
//player.vimeo.com/video/244444565

---
## What is the OMOP-CDM?

```yaml
type: PureMultipleChoiceExercise
key: 6924ed57f3
lang: sql
xp: 50
skills: 1
```
<b>Data standardization</b> is the critical process of bringing data into a common format that allows for collaborative research, large-scale analytics, and sharing of sophisticated tools and methodologies. Why is it so important?

<b>Healthcare data can vary greatly from one organization to the next</b>. Data are collected for different purposes, such as provider reimbursement, clinical research, and direct patient care. These data may be stored in different formats using different database systems and information models. And despite the growing use of standard terminologies in healthcare, the same concept (e.g., blood glucose) may be represented in a variety of ways from one setting to the next.

We at OHDSI are deeply involved in the evolution and adoption of a Common Data Model known as the OMOP Common Data Model. We provide resources to convert a wide variety of datasets into the CDM, as well as a plethora of tools to take advantage of your data once it is in CDM format.

Most importantly, we have an active community that has done many data conversions (often called ETLs) with members who are eager to help you with your CDM conversion and maintenance.

The current version of the CDM (v5.2) is shown in the figure below.

<p><center><img src="https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/omop-cdm.png" alt="OMOP-CDM" width="550" height="400"></center></p>

As you can see the OMOP-CDM is divided in multiple sections. Clinical Data is stored in the Standardized Clinical Data section on the left (light blue). The clinical data tables are domain-oriented, e.g. condition\_occurrence, measurement\_occurrence. The Standardized Vocabulary tables are grouped in the orange box on the right. The real power of the CDM is the blend between the data model and the conceptual model, called an information model. This strongly improves the inter-operability of the datasources as you will experience in this course.

You can find all information about the OMOP-CDM and its tables on the <a href="https://github.com/OHDSI/CommonDataModel/wiki/" style="color:black">Github Wiki</a>

Which of the following statements is true? Feel free to try each of them to get valuable feedback.

`@possible_answers`
- The model does not preserves data provenance
- The clinical data tables contain clinical concepts in human readible form
- [This is a patient centric model]
- The model is now final and will be used as is in the future

`@hint`

`@feedbacks`
- We stored all source\_codes and values in the CDM in addition to the standard concept\_ids
- Only concept\_ids are stored in the clinical data tables, e.g. 8507 = male
- Correct Answer. All the clinical data tables have a link to the person table
- The model is evolving over time. This is driven by new use cases and input by the active OHDSI community

---
## Person Table
The central table in the CDM is the person table. All other Standardized Clinical Data tables have a key (person\_id) that refers to this table. You can see all the fields in this table below and can find detailed information <a href="https://github.com/OHDSI/CommonDataModel/wiki/PERSON" style="color:black">here</a>. 

<p><center><img src="https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/persontable.png" alt="OMOP-CDM" width="300" height="400"></center></p> 

On the wiki you can see that a person can occur only once in this table. This also suggests a person can have only one location, provider, care\_site. Does this mean we cannot track different care providers, care_sites etc over time? 

```yaml
type: PureMultipleChoiceExercise
key: e7bce3227c
lang: sql
xp: 50
skills: 1
```


`@possible_answers`
- Yes
- [No]

`@hint`

`@feedbacks`
- Not correct, the other domains have fields for this as well. For example, a condition\_occurrence can be associated with its own care_site, provider etc.
- Correct, the other domains have fields for this as well. For example, a condition\_occurrence can be associated with its own care\_site, provider etc. It is true the person can have only one location of residence in the current version of the CDM. However, if there is a good use case for this kind of time-varying information we can easily extend the CDM.
---

## Finding data (1)

```yaml
type: PureMultipleChoiceExercise
key: 254b13962b
lang: sql
xp: 50
skills: 1
```
Let's see if you know which tables you need to query to find your data elements of interest. We will test this by asking you to name all the tables you need to include in your query for a certain research question. We will not go into the details of really creating the full query here. (MORE OF THESE TO ADD WITH PATRICK)

<p><center><img src="https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/omop-cdm.png" alt="OMOP-CDM" width="550" height="400"></center></p>

Suppose you have to extract all males that have had a bypass surgical procedure during a hospital visit. Which clinical tables should you include in your query to do that?

`@possible_answers`
- PROCEDURE\_OCCURRENCE, PERSON
- VISIT\_OCCURRENCE, PROCEDURE\_OCCURRENCE
- VISIT\_OCCURRENCE, PERSON
- [PROCEDURE\_OCCURRENCE, PERSON, VISIT\_OCCURRENCE, CONCEPT]

`@hint`
Detailed information about the data model can be found on the <a href="https://github.com/OHDSI/CommonDataModel/wiki/" style="color:black">Github Wiki</a>

`@feedbacks`
- How do you find the hospital visit and the bypass?
- How do you extract the male?
- How do you find the hospital visit
- Indeed you need all these tables in you query.
---
## Variable Name Conventions

```yaml
type: PureMultipleChoiceExercise
key: 824cbcdfdf
lang: sql
xp: 50
skills: 1
```
There are a number of implicit and explicit conventions that have been adopted in the CDM. Developers of methods that run methods against the CDM need to understand these conventions. The table below shows the most important conventions.

![alt text][logo]

[logo]: https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/conventions.png "Variable Name Conventions"

Which of the following statements is true?


`@possible_answers`

- all fields ending with \_concept\_id refer to the VOCABULARY table
- [a entity_id value is unique for the domain not for the whole CDM]
- an ICD-9 code should be placed in the condition\_source\_value field
- If we cannot map to a standard code we loose the record


`@hint`

`@feedbacks`
- All concepts are stored in the CONCEPT table. The VOCABULARY table includes a list of the Vocabularies collected from various sources or created de novo by the OMOP community.
- The entity\_id is primary key for that table. The same id value could for exmaple occur for a visit\_occurrence\_id or a location\_id.
- Only the verbatim text should be placed in the value field. The code should be place in the condition\_source\_id field which refers to a concept\_id in the CONCEPT table
- We can still store this data in the provenance fields source\_value and source\_id (if there is a source code in the vocabulary)

---

## Onboarding | Tables

```yaml
type: MultipleChoiceExercise
lang: sql
xp: 50
skills: 1
key: e5ea66e23d
```
TO BE REMOVED UNTIL we have a full vocab linked up in DataCamp!!

If you've used DataCamp to learn [R](https://www.datacamp.com/courses/free-introduction-to-r) or [Python](https://www.datacamp.com/courses/intro-to-python-for-data-science), you'll be familiar with the interface. For SQL, however, there are a few new features you should be aware of.

For this course, you'll be using a database containing information on almost 5000 films. To the right, underneath the editor, you can see the data in this database by clicking through the tabs.

From looking at the tabs, who is the first person listed in the `people` table?

`@pre_exercise_code`
```{python}
# The pre exercise code runs code to initialize the user's workspace.
# You can use it to load packages, initialize datasets and draw a plot in the viewer

connect('postgresql', 'vocabulary3')
```

`@instructions`
- Kanye West
- Biggie Smalls
- 50 Cent
- Jay Z

`@hint`
Look at the `people` tab under the editor!

`@sct`
```{python}
# SCT written with sqlwhat: https://github.com/datacamp/sqlwhat/wiki
msg_bad = 'Nope, look at the `people` table!'
msg_success = 'Correct!'

Ex().test_mc(3,[msg_bad, msg_bad, msg_success, msg_bad])
```

