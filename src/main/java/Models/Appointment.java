package Models;

import java.sql.Timestamp;

public class Appointment {
    private int appointmentId;
    private String patientName;
    private String address;
    private String contactNumber;
    private int dentistId;
    private int treatmentId;
    private Timestamp appointmentDateTime;
    private String status;

    // Default Constructor
    public Appointment() {}

    // Constructor with All Fields
    public Appointment(int appointmentId, String patientName, String address, String contactNumber, 
                       int dentistId, int treatmentId, Timestamp appointmentDateTime, String status) {
        this.appointmentId = appointmentId;
        this.patientName = patientName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.dentistId = dentistId;
        this.treatmentId = treatmentId;
        this.appointmentDateTime = appointmentDateTime;
        this.status = status;
    }

    // Constructor without ID (New Appointment)
    public Appointment(String patientName, String address, String contactNumber, 
                       int dentistId, int treatmentId, Timestamp appointmentDateTime, String status) {
        this.patientName = patientName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.dentistId = dentistId;
        this.treatmentId = treatmentId;
        this.appointmentDateTime = appointmentDateTime;
        this.status = status;
    }

    // Getters and Setters
    public int getAppointmentId() { return appointmentId; }
    public void setAppointmentId(int appointmentId) { this.appointmentId = appointmentId; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public int getDentistId() { return dentistId; }
    public void setDentistId(int dentistId) { this.dentistId = dentistId; }

    public int getTreatmentId() { return treatmentId; }
    public void setTreatmentId(int treatmentId) { this.treatmentId = treatmentId; }

    public Timestamp getAppointmentDateTime() { return appointmentDateTime; }
    public void setAppointmentDateTime(Timestamp appointmentDateTime) { this.appointmentDateTime = appointmentDateTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}