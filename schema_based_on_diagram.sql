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
  CONSTRAINT patients_id_fk FOREIGN KEY(id) REFERENCES patients(id)
);

CREATE TABLE IF NOT EXISTS treatments(
  id INT GENERATED ALWAYS AS IDENTITY,
  treatments_id INT,
  type VARCHAR(255),
  name VARCHAR(255)
-- ALTER TABLE treatments ADD CONSTRAINT treatments_patient_id_fk FOREIGN KEY(treatments_id) REFERENCES prescribed_treatments(treatments_id);
);

CREATE TABLE IF NOT EXISTS prescribed_treatments (
  id INT GENERATED ALWAYS AS IDENTITY UNIQUE,
  treatments_id INT,
  medical_history INT,
  PRIMARY KEY (treatments_id, medical_history)
);

-- Update made the patient_id a foreign key referencing the prescribed_treatments table
ALTER TABLE medical_histories ADD CONSTRAINT medical_patient_id_fk FOREIGN KEY(patient_id) REFERENCES prescribed_treatments(patient_id);

CREATE TABLE IF NOT EXISTS invoices (
  id INT GENERATED ALWAYS AS IDENTITY UNIQUE,
  total_amount DECIMAL NOT NULL,
  generated_at timestamp NOT NULL,
  payed_at timestamp NOT NULL,
  medical_history_id INT NOT NULL,
  PRIMARY KEY (id,generated_at,payed_at)
);

CREATE TABLE IF NOT EXISTS invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT NOT NULL,
  treatment_id INT NOT NULL,
  PRIMARY KEY (id)
);


ALTER TABLE invoice_items ADD CONSTRAINT invoice_id_fk FOREIGN KEY(invoice_id) REFERENCES invoices(id);

ALTER TABLE invoices ADD CONSTRAINT invoices_medical_histories_fk FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id);