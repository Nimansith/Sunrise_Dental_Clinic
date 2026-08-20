package models;

import java.sql.Timestamp;

public class Appointment {
    private int appointmentId;
    private Integer patientId; 
    private String patientName;
    private String address;
    private String contactNumber;
    private int dentistId;
    private String dentistName; 
    private int treatmentId;
    private Timestamp appointmentDateTime;
    private String status;

    // Default Constructor
    public Appointment() {}

    // Constructor with All Fields
    public Appointment(int appointmentId, Integer patientId, String patientName, String address, String contactNumber, 
                       int dentistId, String dentistName, int treatmentId, Timestamp appointmentDateTime, String status) {
        this.appointmentId = appointmentId;
        this.patientId = patientId;
        this.patientName = patientName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.dentistId = dentistId;
        this.dentistName = dentistName;
        this.treatmentId = treatmentId;
        this.appointmentDateTime = appointmentDateTime;
        this.status = status;
    }

    // Constructor without ID (New Appointment)
    public Appointment(Integer patientId, String patientName, String address, String contactNumber, 
                       int dentistId, String dentistName, int treatmentId, Timestamp appointmentDateTime, String status) {
        this.patientId = patientId;
        this.patientName = patientName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.dentistId = dentistId;
        this.dentistName = dentistName;
        this.treatmentId = treatmentId;
        this.appointmentDateTime = appointmentDateTime;
        this.status = status;
    }

    // Getters and Setters
    public int getAppointmentId() { return appointmentId; }
    public void setAppointmentId(int appointmentId) { this.appointmentId = appointmentId; }

    public Integer getPatientId() { return patientId; }
    public void setPatientId(Integer patientId) { this.patientId = patientId; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public int getDentistId() { return dentistId; }
    public void setDentistId(int dentistId) { this.dentistId = dentistId; }

    public String getDentistName() { return dentistName; }
    public void setDentistName(String dentistName) { this.dentistName = dentistName; }

    public int getTreatmentId() { return treatmentId; }
    public void setTreatmentId(int treatmentId) { this.treatmentId = treatmentId; }

    public Timestamp getAppointmentDateTime() { return appointmentDateTime; }
    public void setAppointmentDateTime(Timestamp appointmentDateTime) { this.appointmentDateTime = appointmentDateTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}