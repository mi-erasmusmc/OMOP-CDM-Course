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

You can find all information about the OMOP-CDM and its tables on the <a href="https://github.com/OHDSI/CommonDataModel/wiki/" style="color:black">Github Wiki</a>. We suggest you take some time now to explore this wiki page.

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
## Loading the data in the CDM

```yaml
type: PureMultipleChoiceExercise
key: ac3583f08b
lang: sql
xp: 50
skills: 1
```
A fist step is that the source data will have to be stored in the CDM. This process is called Extraction Transform Load (ETL).
Do you know what drives the choice of the domain to store the data?

`@possible_answers`
- a human expert
- the source data
- [the concept damain in the Standardized Vocabularies]
- your personal preference

`@hint`

`@feedbacks`

---
## Person Table

```yaml
type: PureMultipleChoiceExercise
key: e7bce3227c
lang: sql
xp: 50
skills: 1
```
The central table in the CDM is the person table. All other Standardized Clinical Data tables have a key (person\_id) that refers to this table. You can see all the fields in this table below and can find detailed information <a href="https://github.com/OHDSI/CommonDataModel/wiki/PERSON" style="color:black">here</a>. 

<p><center><img src="https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/persontable.png" alt="OMOP-CDM" width="300" height="400"></center></p> 

On the wiki you can see that a person can occur only once in this table. This also suggests a person can have only one provider or care\_site. Does this mean we cannot track different care providers, care_sites over time? 


`@possible_answers`
- Yes
- [No]

`@hint`

`@feedbacks`
- Not correct, the other domains have fields for this as well. For example, a condition\_occurrence can be associated with its own care_site, provider etc.
- Correct, the other domains have fields for this as well. For example, a condition\_occurrence can be associated with its own care\_site, provider etc. It is true the person can have only one location of residence in the current version of the CDM. However, if there is a good use case for this kind of time-varying information we can easily extend the CDM.

---
## Measurement Table


```yaml
type: PureMultipleChoiceExercise
key: 0485643d60
lang: sql
xp: 50
skills: 1
```
The MEASUREMENT table contains records of Measurement, i.e. structured values (numerical or categorical) obtained through systematic and standardized examination or testing of a Person or Person's sample. The MEASUREMENT table contains both orders and results of such Measurements as laboratory tests, vital signs, quantitative findings from pathology reports, etc.

Measurements differ from Observations in that they require a standardized test or some other activity to generate a quantitative or qualitative result. For example, LOINC 1755-8 concept_id 3027035 'Albumin [Mass/time] in 24 hour Urine' is the lab test to measure a certain chemical in a urine sample.

Is it true that all measurements in the measurement table have a value?


`@possible_answers`
- Yes
- [No]
`@hint`

`@feedbacks`
- Incorrect. The vaue is not mandatory you should store the fact that the measurement was performed in this table as well.
- Correct. The vaue is not mandatory you should store the fact that the measurement was performed in this table as well.

---

## Finding data (1)

```yaml
type: PureMultipleChoiceExercise
key: 254b13962b
lang: sql
xp: 50
skills: 1
```
Let's see if you know which tables you need to query to find your data elements of interest. We will test this by asking you to name all the clinical tables you need to include in your query for a certain research question. We will not go into the details of really creating the full query here. 

<p><center><img src="https://github.com/mi-erasmusmc/OMOP-CDM-Course/raw/master/img/omop-cdm.png" alt="OMOP-CDM" width="550" height="400"></center></p>

Suppose you have to extract all males that have had a bypass surgical procedure during a hospital visit. Which clinical tables should you include in your query to do that?

`@possible_answers`
- PROCEDURE\_OCCURRENCE, PERSON
- VISIT\_OCCURRENCE, PROCEDURE\_OCCURRENCE
- VISIT\_OCCURRENCE, PERSON
- [PROCEDURE\_OCCURRENCE, PERSON, VISIT\_OCCURRENCE]

`@hint`
Detailed information about the data model can be found on the <a href="https://github.com/OHDSI/CommonDataModel/wiki/" style="color:black">Github Wiki</a>

`@feedbacks`
- How do you find the hospital visit?
- How do you extract the male?
- How do you find the hospital visit
- Indeed you need all these tables in you query.

---
## Finding data (2)

```yaml
type: PureMultipleChoiceExercise
key: 3a45604228
lang: sql
xp: 50
skills: 1
```
The OBSERVATION_PERIOD table contains records which uniquely define the spans of time for which a Person is at-risk to have clinical events recorded within the source systems, even if no events in fact are recorded (healthy patient with no healthcare interactions).

What is not a valid use of the observation\_period table?

`@possible_answers`
- define lookback period
- define followup period
- denominator for population prevalence
- [to find all persons with at least one observation]

`@hint`

`@feedbacks`
- you do use the observation\_period table for this purpose
- you do use the observation\_period table for this purpose
- you do use the observation\_period table for this purpose
- indeed, observation periods define the spans of time a person is eligible to have recorded clinical observations, but does not require that one or more observations are actually observed

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
- The entity\_id is primary key for that table. The same id value could for example occur for a visit\_occurrence\_id or a location\_id.
- Only the verbatim text should be placed in the value field. The code should be place in the condition\_source\_id field which refers to a concept\_id in the CONCEPT table
- The best practive is to still store this data in the provenance fields source\_value and source\_id (if there is a source code in the vocabulary)




