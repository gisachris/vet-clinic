CREATE TABLE "treatments"(
  "id" INTEGER NOT NULL,
  "type" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
  "treatments" ADD PRIMARY KEY("id");
CREATE TABLE "medical_histories"(
  "id" SERIAL PRIMARY KEY,
  "admitted_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
  "patient_id" INTEGER REFERENCES patients(id),
  "status" VARCHAR(255) NOT NULL
);
ALTER TABLE
  "medical_histories" ADD PRIMARY KEY("id");
CREATE INDEX "medical_histories_patient_id_index" ON
  "medical_histories"("patient_id");
CREATE TABLE "Patients"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "date_of_birth" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Patients" ADD PRIMARY KEY("id");
CREATE TABLE "invoice_items"(
  "id" SERIAL PRIMARY KEY,
  "unit_price" DECIMAL(8, 2) NOT NULL,
  "quantity" INTEGER NOT NULL,
  "total_price" DECIMAL(8, 2) NOT NULL,
  "invoice_id" INTEGER REFERENCES invoices(id),
  "treatment_id" INTEGER REFERENCES treatments(id)
);
CREATE INDEX "invoice_items_invoice_id_index" ON
  "invoice_items"("invoice_id");
CREATE INDEX "invoice_items_treatment_id_index" ON
  "invoice_items"("treatment_id");
ALTER TABLE
  "invoice_items" ADD PRIMARY KEY("id");
CREATE INDEX "invoice_items_invoice_id_index" ON
  "invoice_items"("invoice_id");
CREATE INDEX "invoice_items_treatment_id_index" ON
  "invoice_items"("treatment_id");
CREATE TABLE "medical_treatments"(
  "medical_histories_id" INTEGER REFERENCES medical_histories(id),
  "treatments_id" INTEGER treatments(id)
);
CREATE INDEX "medical_treatments_medical_histories_id_index" ON
  "medical_treatments"("medical_history_id");
CREATE INDEX "medical_treatments_treatments_id_index" ON
  "medical_treatments"("treatment_id");
CREATE TABLE "Invoices"(
  "id" SERIAL PRIMARY KEY,
  "total_amount" DECIMAL(8, 2) NOT NULL,
  "generated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
  "payed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
  "medical_history_id" INTEGER REFERENCES medical_histories(id)
);
CREATE INDEX "invoices_medical_history_id_index" ON
  "Invoices"("medical_history_id");
ALTER TABLE
  "Invoices" ADD PRIMARY KEY("id");
CREATE INDEX "invoices_medical_history_id_index" ON
  "Invoices"("medical_history_id");
ALTER TABLE
  "medical_treatments" ADD CONSTRAINT "medical_treatments_treatments_id_foreign" FOREIGN KEY("treatments_id") REFERENCES "treatments"("id");
ALTER TABLE
  "medical_histories" ADD CONSTRAINT "medical_histories_patient_id_foreign" FOREIGN KEY("patient_id") REFERENCES "Patients"("id");
ALTER TABLE
  "medical_treatments" ADD CONSTRAINT "medical_treatments_medical_histories_id_foreign" FOREIGN KEY("medical_histories_id") REFERENCES "medical_histories"("id");
ALTER TABLE
  "invoice_items" ADD CONSTRAINT "invoice_items_treatment_id_foreign" FOREIGN KEY("treatment_id") REFERENCES "treatments"("id");
ALTER TABLE
  "Invoices" ADD CONSTRAINT "invoices_medical_history_id_foreign" FOREIGN KEY("medical_history_id") REFERENCES "medical_histories"("id");