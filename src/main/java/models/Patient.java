package models;

public class Patient {
    private int patientId;
    private String patientName;
    private String email;
    private String contactNumber;
    private String gender;
    private String address;
    private String createdAt;

    // Default Constructor
    public Patient() {}

    // Constructor with All Fields
    public Patient(int patientId, String patientName, String email, String contactNumber, String gender, String address, String createdAt) {
        this.patientId = patientId;
        this.patientName = patientName;
        this.email = email;
        this.contactNumber = contactNumber;
        this.gender = gender;
        this.address = address;
        this.createdAt = createdAt;
    }

    // Constructor for New Registration
    public Patient(String patientName, String email, String contactNumber, String gender, String address) {
        this.patientName = patientName;
        this.email = email;
        this.contactNumber = contactNumber;
        this.gender = gender;
        this.address = address;
    }

    // Getters & Setters
    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}