CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at timestamp NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT patients_id_fk FOREIGN KEY(id) REFERENCES patients(id),
--   CONSTRAINT patients_id_fk FOREIGN KEY(patient_id) REFERENCES prescribed_treatments(id)
);

CREATE TABLE IF NOT EXISTS treatments(
  id INT GENERATED ALWAYS AS IDENTITY,
  treatments_id INT,
  type VARCHAR(255),
  name VARCHAR(255),
  -- CONSTRAINT patients_id_fk FOREIGN KEY(id) REFERENCES prescribed_treatments(patient_id)
);

CREATE TABLE IF NOT EXISTS prescribed_treatments(
  treatments_id INT,
  patient_id INT,
  PRIMARY KEY(treatments_id, patient_id)
);