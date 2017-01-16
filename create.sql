DROP TABLE IF EXISTS Components CASCADE;
DROP TABLE IF EXISTS BuildPlans CASCADE;
DROP TABLE IF EXISTS Machines CASCADE;
DROP TABLE IF EXISTS Staff CASCADE;
DROP TABLE IF EXISTS StaffCanWorkOn CASCADE;
DROP TABLE IF EXISTS Steps CASCADE;
DROP TABLE IF EXISTS RequiredSteps CASCADE;
DROP TABLE IF EXISTS Vendors CASCADE;
DROP TABLE IF EXISTS VendorsSell CASCADE;
DROP TABLE IF EXISTS WeSell CASCADE;
DROP TYPE IF EXISTS Gender;

CREATE TABLE Components (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE BuildPlans (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Machines (
  id            SERIAL PRIMARY KEY,
  name          VARCHAR(100) NOT NULL UNIQUE,
  work_stations INT          NOT NULL CHECK (work_stations >= 0)
);

CREATE TYPE Gender AS ENUM ('Male', 'Female');

CREATE TABLE Staff (
  id          SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  second_name VARCHAR(50) NOT NULL,
  hourly_wage MONEY       NOT NULL CHECK (hourly_wage > 0 :: MONEY),
  gender      Gender      NOT NULL
);

CREATE TABLE StaffCanWorkOn (
  staff_id   SERIAL REFERENCES Staff (id) ON DELETE CASCADE,
  machine_id SERIAL REFERENCES Machines (id) ON DELETE CASCADE,
  PRIMARY KEY (staff_id, machine_id)
);

CREATE TABLE Steps (
  id                  SERIAL PRIMARY KEY,
  plan_id             SERIAL REFERENCES BuildPlans (id) ON DELETE CASCADE,
  result_component_id SERIAL REFERENCES Components (id),
  machine             SERIAL REFERENCES Machines (id)
);

CREATE TABLE RequiredSteps (
  parent SERIAL REFERENCES Steps (id) ON DELETE CASCADE,
  child  SERIAL REFERENCES Steps (id) ON DELETE RESTRICT,
  count  INT CHECK (count > 0),
  PRIMARY KEY (parent, child)
);

CREATE TABLE Vendors (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE VendorsSell (
  vendor_id    SERIAL REFERENCES Vendors (id) ON DELETE CASCADE,
  component_id SERIAL REFERENCES Components (id) ON DELETE RESTRICT,
  price        MONEY NOT NULL,
  PRIMARY KEY (vendor_id, component_id)
);

CREATE TABLE WeSell (
  component_id SERIAL REFERENCES Components(id) ON DELETE CASCADE PRIMARY KEY
);
