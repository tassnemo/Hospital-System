#  Hospital Management System Database

A relational database schema for a hospital management system 
designed using Oracle SQL

##  About
This project models a fully structured hospital database covering 
staff management, patient records, appointments, admissions, and room allocation.

## Tables
- Staff > base table for all hospital staff
- Doctor > doctor specialization and department
- Nurse > nurse shift, ward, and certification
- Security > assigned zone, shift, and badge number
- Frontdesk > desk location
- Utility > role and assigned areas
- Patient > patient personal and medical info
- Department > hospital departments and head doctor
- Room > room type, capacity, floor, and status
- Clinic_Appointment > patient appointments with doctors
- Medical_Record > diagnoses and treatment records
- Admission > patient admissions and discharge info
- Nurse_Admission > nurses assigned to admissions
- Phones > Patient_Phones — multi-valued phone numbers

##  Features
- Role-based staff specialization using a shared Staff base table
- Constraints and validation on shifts, room status, gender, and employment type
- Discharge date must be after admission date
- Room capacity enforcement
- Junction tables for many-to-many relationships
- Sample data included for all tables

##  Requirements
- Oracle Database 21c Express Edition (XE) — free version
- Oracle SQL Developer to run the script

##  How to Run
1. Install Oracle 21c XE from oracle.com
2. Open SQL Developer and create a new connection
3. Open `hospital.sql`
4. Run the script

## 📁 Files
- `hospital.sql` — full schema with tables, inserts, and queries
- `Schema.pdf` — ERD diagram of the database
