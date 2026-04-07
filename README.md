# interventive-learning
Interventive Learning Reading Database
WMU Senior Design

Each skill set has:
1. A module (teaches the concept)
2. An assessment (checks understanding)

After a student completes the assessment:
- If they pass: they move to the next skill  
- If they don’t: they move back for more practice  
- All results are stored and tracked per student

Setup Instructions:

1. Start Docker Desktop.

2. Create the database container
   - docker run -d --name wmu_reading_db -e POSTGRES_USER=wmuuser -e POSTGRES_PASSWORD=wmupassword -e POSTGRES_DB=wmu_reading -p 5433:5432 -v wmu_reading_data:/var/lib/postgresql/data postgres:15

3. Copy the seed files into the container
   - docker cp create_tables.sql wmu_reading_db:/tmp/tables.sql
   - docker cp k5_reading_prereq.sql wmu_reading_db:/tmp/seed.sql
   - docker cp modules_seed.sql wmu_reading_db:/tmp/modules.sql
   - docker cp assessments_seed.sql wmu_reading_db:/tmp/assessments.sql

4. Connect to the database
   - docker exec -it wmu_reading_db psql -U wmuuser -d wmu_reading

5. Run the files in order
   - \i /tmp/tables.sql
   - \i /tmp/seed.sql
   - \i /tmp/modules.sql
   - \i /tmp/assessments.sql

6. Run this after seeding
   - UPDATE modules SET item_code = module_code, sequence_index = 10;
   - UPDATE assessments SET sequence_index = 20;

Running progression.py:

1. Install Dependency:
   - pip install psycopg2-binary

2. Run the program:
   - python progression.py

3. Code Flow:
   - Enter student name
   - Enter starting skill set (e.g., 4.RSLKID.1)
   - Enter scores (0–100)
   - System automatically:
      - Determines pass/fail
      - Moves student up/down
      - Records results in database

Done!

To connect again later:
   docker exec -it wmu_reading_db psql -U wmuuser -d wmu_reading

Credentials
   - Host:     localhost
   - Port:     5433
   - Database: wmu_reading
   - Username: wmuuser
   - Password: wmupassword
