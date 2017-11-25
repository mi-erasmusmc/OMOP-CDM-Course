/*********************************************************************************
# Copyright 2014-6 Observational Health Data Sciences and Informatics
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
********************************************************************************/

/************************
 ####### #     # ####### ######      #####  ######  #     #           #######      #####
 #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #           #     #
 #     # # # # # #     # #     #    #       #     # # # # #    #    # #                 #
 #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######       #####
 #     # #     # #     # #          #       #     # #     #    #    #       # ### #
 #     # #     # #     # #          #     # #     # #     #     #  #  #     # ### #
 ####### #     # ####### #           #####  ######  #     #      ##    #####  ### #######

script to create OMOP common data model, version 5.2 for PostgreSQL database
last revised: 14 July 2017
Authors:  Patrick Ryan, Christian Reich
*************************/


/************************
Standardized vocabulary
************************/


CREATE TABLE films (
  id                    INTEGER     PRIMARY KEY,
  title                 VARCHAR,
  release_year          INTEGER,
  country               VARCHAR,
  duration              INTEGER,
  language              VARCHAR,
  certification         VARCHAR,
  gross                 BIGINT,
  budget                BIGINT
);

CREATE TABLE concept (
  concept_id			INTEGER			NOT NULL,
  concept_name			VARCHAR(255)	NOT NULL,
  domain_id				VARCHAR(20)		NOT NULL,
  vocabulary_id			VARCHAR(20)		NOT NULL,
  concept_class_id		VARCHAR(20)		NOT NULL,
  standard_concept		CHAR(1)		NULL,
  concept_code			VARCHAR(50)		NOT NULL,
  valid_start_date		DATE			NOT NULL,
  valid_end_date		DATE			NOT NULL,
  invalid_reason		CHAR(1)		NULL
)
;

CREATE TABLE concept_relationship (
  concept_id_1			INTEGER			NOT NULL,
  concept_id_2			INTEGER			NOT NULL,
  relationship_id		VARCHAR(20)		NOT NULL,
  valid_start_date		DATE			NOT NULL,
  valid_end_date		DATE			NOT NULL,
  invalid_reason		CHAR(1)		NULL)
;


CREATE TABLE concept_ancestor (
  ancestor_concept_id		INTEGER		NOT NULL,
  descendant_concept_id		INTEGER		NOT NULL,
  min_levels_of_separation	INTEGER		NOT NULL,
  max_levels_of_separation	INTEGER		NOT NULL
)
;


-- Copy over data from CSVs
\copy films FROM 'data/vocab/films.csv' DELIMITER ',' CSV HEADER;

-- Copy over data from CSVs
\copy concept FROM 'data/vocab/concept.csv' DELIMITER ',' CSV HEADER;

