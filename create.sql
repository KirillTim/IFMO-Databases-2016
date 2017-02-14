DROP TABLE IF EXISTS Components CASCADE;
DROP TABLE IF EXISTS Machines CASCADE;
DROP TABLE IF EXISTS ServiceVendors CASCADE;
DROP TABLE IF EXISTS BuildSteps CASCADE;
DROP TABLE IF EXISTS BuildStepDependencies CASCADE;
DROP TABLE IF EXISTS BuildPlans CASCADE;
DROP TABLE IF EXISTS Staff CASCADE;
DROP TABLE IF EXISTS StaffCanWorkOn CASCADE;
DROP TABLE IF EXISTS Vendors CASCADE;
DROP TABLE IF EXISTS VendorsSell CASCADE;
DROP TYPE IF EXISTS Gender;

CREATE TABLE Components (
  id         SERIAL PRIMARY KEY,
  name       VARCHAR(100) NOT NULL UNIQUE,
  sell_price MONEY CHECK (sell_price > 0 :: MONEY)
  --build_step SERIAL REFERENCES BuildSteps (id)
);

CREATE TABLE Machines (
  id            SERIAL PRIMARY KEY,
  name          VARCHAR(100) NOT NULL UNIQUE,
  work_stations INT          NOT NULL CHECK (work_stations >= 0)
);

CREATE TABLE BuildPlans (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(100) NOT NULL
);

CREATE TABLE Steps (
  id                  SERIAL PRIMARY KEY,
  plan_id             SERIAL REFERENCES BuildPlans (id) ON DELETE CASCADE,
  result_component_id SERIAL REFERENCES Components (id),
  machine             SERIAL REFERENCES Machines (id)
);

CREATE TABLE BuildSteps (
  id               SERIAL PRIMARY KEY,
  result_component SERIAL REFERENCES Components (id) ON DELETE CASCADE,
  machine          SERIAL REFERENCES Machines (id) ON DELETE CASCADE,
  hours            INT CHECK (hours > 0),
  total_price      MONEY CHECK (total_price > 0 :: MONEY)
);

ALTER TABLE Components ADD COLUMN build_step SERIAL REFERENCES BuildSteps (id);

CREATE TABLE BuildStepDependencies (
  step      SERIAL REFERENCES Steps (id) ON DELETE CASCADE,
  component SERIAL REFERENCES Components (id) ON DELETE CASCADE,
  PRIMARY KEY (step, component)
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

CREATE TABLE ServiceVendors (
  id           SERIAL PRIMARY KEY,
  name         VARCHAR(100) NOT NULL,
  contact_info VARCHAR(100) NOT NULL
);